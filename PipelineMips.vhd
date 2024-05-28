library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PipelineMips is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end PipelineMips;

architecture Behavioral of PipelineMips is
signal IF_ID_IR, ID_EX_IR, EX_MEM_IR, MEM_WB_IR : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal IF_ID_PC, ID_EX_PC, EX_MEM_PC, MEM_WB_PC : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal ID_EX_A, ID_EX_B, ID_EX_SE, EX_MEM_ALUOut, EX_MEM_B, MEM_WB_ALUOut, MEM_WB_LMD : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_RegDst, MEM_WB_RegWrite, MEM_WB_MemtoReg : STD_LOGIC := '0';
signal Zero : STD_LOGIC := '0';

-- Intermediate signals
signal ReadData1, ReadData2, ALU_result, branch_address, mux_output, mux_output1, mux_output2, mux_output3, pc_in, data_out, instruction : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal PC_Out, Next_PC, shifted_instruction, se_output : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
signal ALU_control : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal AluOp : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal RegWrite, MemRead, MemWrite, regdst, jump, PCSrc, MemtoReg, ALUSrc : STD_LOGIC := '0';

-- Declare signals for data and register to be written to RegisterFile
signal REG_WriteData : std_logic_vector(31 downto 0) := (others => '0');
signal REG_WriteReg : std_logic_vector(4 downto 0) := (others => '0'); -- Assuming 5-bit register addresses

begin

    -- Concatenate and shift instruction to get branch address
    shifted_instruction <= std_logic_vector(resize(signed(ID_EX_IR(15 downto 0)), 32) sll 2);

    -- Pipeline Stage: Instruction Fetch (IF)
    process(clk, rst)
    begin
        if rst = '1' then
            IF_ID_IR <= (others => '0');
            IF_ID_PC <= (others => '0');
            PC_Out <= (others => '0');
        elsif rising_edge(clk) then
            IF_ID_IR <= instruction;
            IF_ID_PC <= PC_Out;
            PC_Out <= pc_in;
        end if;
    end process;

    -- Pipeline Stage: Instruction Decode (ID)
    process(clk, rst)
    begin
        if rst = '1' then
            ID_EX_IR <= (others => '0');
            ID_EX_PC <= (others => '0');
            ID_EX_A <= (others => '0');
            ID_EX_B <= (others => '0');
            ID_EX_SE <= (others => '0');
        elsif rising_edge(clk) then
            ID_EX_IR <= IF_ID_IR;
            ID_EX_PC <= IF_ID_PC;
            ID_EX_A <= ReadData1;   --from register file
            ID_EX_B <= ReadData2;
            ID_EX_SE <= se_output; --elhwa immediate (constant)
        end if;
    end process;

    -- Pipeline Stage: Execute (EX)
    process(clk, rst)
    begin
        if rst = '1' then
            EX_MEM_IR <= (others => '0');
            EX_MEM_PC <= (others => '0');
            EX_MEM_ALUOut <= (others => '0');
            EX_MEM_B <= (others => '0');
            EX_MEM_MemRead <= '0';
            EX_MEM_MemWrite <= '0';--control signals
            EX_MEM_RegWrite <= '0';
            EX_MEM_RegDst <= '0';
        elsif rising_edge(clk) then
            EX_MEM_IR <= ID_EX_IR;
            EX_MEM_PC <= ID_EX_PC;
            EX_MEM_ALUOut <= ALU_result;
            EX_MEM_B <= ID_EX_B;
            EX_MEM_MemRead <= MemRead;
            EX_MEM_MemWrite <= MemWrite;
            EX_MEM_RegWrite <= RegWrite;
            EX_MEM_RegDst <= regdst;
        end if;
    end process;

    -- Pipeline Stage: Memory Access (MEM)
    process(clk, rst)
    begin
        if rst = '1' then
            MEM_WB_IR <= (others => '0');
            MEM_WB_PC <= (others => '0');
            MEM_WB_ALUOut <= (others => '0');
            MEM_WB_LMD <= (others => '0');
            MEM_WB_RegWrite <= '0';
            MEM_WB_MemtoReg <= '0';
        elsif rising_edge(clk) then
            MEM_WB_IR <= EX_MEM_IR;
            MEM_WB_PC <= EX_MEM_PC;
            MEM_WB_ALUOut <= EX_MEM_ALUOut;
            MEM_WB_LMD <= data_out; --mn el data memmory
            MEM_WB_RegWrite <= EX_MEM_RegWrite;
            MEM_WB_MemtoReg <= MemtoReg;
        end if;
    end process;

    -- Pipeline Stage: Write Back (WB)
    process(clk, rst)
    begin
        if rst = '1' then
            -- Reset conditions if necessary
        elsif rising_edge(clk) then
            if MEM_WB_RegWrite = '1' then
                if MEM_WB_MemtoReg = '1' then
                    -- Write data from memory to the register file
                    REG_WriteData <= MEM_WB_LMD; --el write data hatb2a load memory data
                    REG_WriteReg <= MEM_WB_IR(15 downto 11); -- Write to the destination register
                else
                    -- Write ALU result to the register file
                    REG_WriteData <= MEM_WB_ALUOut;
                    REG_WriteReg <= MEM_WB_IR(15 downto 11); -- Write to the destination register
                end if;
            end if;
        end if;
    end process;
    -- Instantiate components and interconnect signals
    REG: entity work.RegisterFile(Behavioral)
        port map(
            ReadReg1 => IF_ID_IR(25 downto 21),
            ReadReg2 => IF_ID_IR(20 downto 16),
            WriteReg => MEM_WB_IR(15 downto 11),
            WriteData => mux_output3, --bakhtar maben el alu result w el load
            RegWrite => MEM_WB_RegWrite,
            Clk => clk,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );

    SE: entity work.Sign_Extender(Behavioral)
        port map(
            se_input => IF_ID_IR(15 downto 0),
            se_output => se_output
        );

    ALUC: entity work.AluControl(Behavioral)
        port map(
            funct => ID_EX_IR(5 downto 0),
            alu_op => AluOp,   -- 2 bits
            operation => ALU_control
        );

    PA: entity work.PC_Adder(Behavioral)
        port map(
            PC => PC_Out,
            Next_PC => Next_PC
        );

    AWS: entity work.AdderWithShift(Behavioral)
        port map(
            A => ID_EX_PC,
            B => shifted_instruction,
            sum => branch_address
        );

    PCX: entity work.ProgramCounter(Behavioral)
        port map(
            clk => clk,
            reset => rst,
            pc_in => pc_in,
            pc_out => PC_Out
        );

    DM: entity work.DataMemory(Behavioral)
        port map(	
            address => EX_MEM_ALUOut(9 downto 0), --10 bits not 32 bits
            data_in => EX_MEM_B,
            data_out => data_out,
            memory_read => EX_MEM_MemRead,
            memory_write => EX_MEM_MemWrite,
            clk => clk
        );

    CU: entity work.ControlUnit(Behavioral)
        port map(
            opcode => IF_ID_IR(31 downto 26),
            reg_dst => regdst,
            jump => jump,
            branch => PCSrc,
            mem_read => MemRead,
            mem_to_reg => MemtoReg,
            reg_write => RegWrite,
            mem_write => MemWrite,
            alu_src => ALUSrc,
            alu_op => AluOp
        );

    MU1: entity work.Mux(Behavioral) -- maben register file w el alu
        port map(
            mux_input1 => ID_EX_B,
            mux_input2 => ID_EX_SE,
            mux_output => mux_output,
            mux_control => ALUSrc
        );

    AL: entity work.Alu(Behavioral)
        port map(
            a1 => ID_EX_A,
            a2 => mux_output,
            alu_control => ALU_control,
            alu_result => ALU_result,
            Zero => Zero
        );

    IM: entity work.Instruction_Memory(Behavioral)
        port map(
            address => PC_Out(9 downto 0),
            instruction => instruction
        );

    MU2: entity work.Mux(Behavioral)
        port map( --bet adder with shift and mux 
            mux_input1 => Next_PC,
            mux_input2 => branch_address,
            mux_output => mux_output2,
            mux_control => (PCSrc and Zero)
        );

    MU3: entity work.Mux(Behavioral)
        port map( -- TOP RIGHT MUX
            mux_input1 => shifted_instruction,
            mux_input2 => mux_output2,
            mux_output => mux_output1,
            mux_control => jump
        );

    MU4: entity work.Mux(Behavioral)
        port map( 
            mux_input1 => data_out,
            mux_input2 => EX_MEM_ALUOut,
            mux_output => mux_output3,
            mux_control => MEM_WB_MemtoReg
        );

    -- Connect the output of the first mux to PC_in
    pc_in <= mux_output1;


end Behavioral;
