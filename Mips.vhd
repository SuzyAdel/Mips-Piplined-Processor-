library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity Mips is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end Mips;

architecture Behavioral of Mips is
signal ReadData1: STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal ReadData2: STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal instruction: STD_LOGIC_VECTOR(31 downto 0):= "00000000001000010001000000011000";
signal RegWrite: STD_LOGIC:='1';
signal se_output: STD_LOGIC_VECTOR(31 downto 0);
signal AluOp: STD_LOGIC_VECTOR(1 downto 0):="10";
signal ALU_control: STD_LOGIC_VECTOR(3 downto 0):="1000";
signal PC_Out: STD_LOGIC_VECTOR(31 downto 0):=x"00000001";
signal Next_PC: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal branch_address : STD_LOGIC_VECTOR(31 downto 0) := x"33334444";
signal shifted_instruction: std_logic_vector(31 downto 0) := (others => '0');
signal pc_in: STD_LOGIC_VECTOR(31 downto 0):=x"12345678";
signal data_out: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal ALU_result : STD_LOGIC_VECTOR(31 downto 0) := x"00000001";
signal MemRead: STD_LOGIC:='0';
signal MemWrite: STD_LOGIC:='0';
signal regdst: STD_LOGIC:='0';
signal jump: STD_LOGIC:='0';
signal PCSrc: STD_LOGIC := '0';
signal MemtoReg: STD_LOGIC := '0';
signal ALUSrc: STD_LOGIC := '0';
signal mux_output: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal Zero: STD_LOGIC:='1';
signal mux_output1: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal mux_output2: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');
signal mux_output3: STD_LOGIC_VECTOR(31 downto 0):=(others=>'0');

begin
    -- Concatenate and shift instruction to get branch address
    shifted_instruction <= std_logic_vector(resize(signed(instruction(15 downto 0)), 32) sll 2);
    u1: entity work.RegisterFile(Behavioral)
        port map(
            ReadReg1 => instruction(25 downto 21),
            ReadReg2 => instruction(20 downto 16),
            WriteReg => instruction(15 downto 11),
            WriteData => mux_output3,
            RegWrite => RegWrite,
            Clk => clk,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );
u2: entity work.Sign_Extender(Behavioral)
        port map(
            se_input => instruction(15 downto 0),
            se_output => se_output
        );
u3: entity work.AluControl(Behavioral)
        port map(
            funct => instruction(5 downto 0),
            alu_op => ALUOp,
            operation => ALU_control
        );
u4: entity work.PC_Adder(Behavioral)
        port map(
            PC => PC_out,
            Next_PC => Next_PC
        );
u5: entity work.AdderWithShift(Behavioral)
        port map(
            A => Next_PC,
            B => shifted_instruction,
            sum => branch_address
        );
u6: entity work.ProgramCounter(Behavioral)
        port map(
            clk => clk,
            reset => rst,
            pc_in => PC_in,
            pc_out => PC_out
        );
u7: entity work.DataMemory(Behavioral)
        port map(
            address => ALU_result(9 downto 0),
            data_in => ReadData2,
            data_out => data_out,
            memory_read => MemRead,
            memory_write => MemWrite,
            clk => clk
        );
u8: entity work.ControlUnit(Behavioral)
        port map(
            opcode => instruction(31 downto 26),
            reg_dst => RegDst,
            jump => Jump,
            branch => PCSrc,
            mem_read => MemRead,
            mem_to_reg => MemtoReg,
            reg_write => RegWrite,
            mem_write => MemWrite,
            alu_src => ALUSrc,
            alu_op => ALUOp
        );
u9: entity work.Mux(Behavioral)
        port map(
            mux_input1 => ReadData2,
            mux_input2 => se_output,
            mux_output => mux_output,
            mux_control => ALUSrc
        );
u10: entity work.Alu(Behavioral)
        port map(
            a1 => ReadData1,
            a2 => mux_output,
            alu_control => ALU_control,
            alu_result => ALU_result,
            Zero => Zero
        );
u11: entity work.Instruction_Memory(Behavioral)
        port map(
            address => PC_out(9 downto 0),
            instruction => instruction
        );

    u13: entity work.Mux(Behavioral)
    port map(
      mux_input1 => shifted_instruction, -- Shifted instruction for jump address
      mux_input2 => mux_output2, -- Output of second mux (explained below)
      mux_output => mux_output1,
      mux_control => jump -- Controlled by jump signal
    );
 
  -- Second mux for branch address
  u12: entity work.Mux(Behavioral)
    port map(
      mux_input1 => Next_PC, -- Next PC
      mux_input2 => branch_address, -- ALU result
      mux_output => mux_output2,
      mux_control => PCSrc and Zero -- Controlled by both PCSrc and Zero
    );
u14: entity work.Mux(Behavioral)
    port map(
      mux_input1 => data_out, -- Next PC
      mux_input2 => ALU_result, -- ALU result
      mux_output => mux_output3,
      mux_control => MemToReg -- Controlled by both PCSrc and Zero
    );
 
  -- Connect the output of the first mux to PC_in
  PC_in <= mux_output1;
end Behavioral;
