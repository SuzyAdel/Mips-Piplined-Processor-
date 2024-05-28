LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegisterFile_Tb IS
END RegisterFile_Tb;
 
ARCHITECTURE behavior OF RegisterFile_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
	     generic (
        DATA_WIDTH : integer := 32; -- Width of the data
        ADDR_WIDTH : integer := 5   -- Width of the address
    );
    PORT(
        ReadReg1 : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
        ReadReg2 : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
        WriteReg : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
        WriteData : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        RegWrite : in STD_LOGIC;
        Clk : in STD_LOGIC;
        ReadData1 : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        ReadData2 : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
        );
    END COMPONENT;
    
	 CONSTANT DATA_WIDTH : integer := 32; -- Width of the data
    CONSTANT ADDR_WIDTH : integer := 5;

   --Inputs
   signal ReadReg1 : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
   signal ReadReg2 : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
   signal WriteReg : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
   signal WriteData : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal RegWrite : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal ReadData1 : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal ReadData2 : std_logic_vector(DATA_WIDTH-1 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 30 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile 
    generic map (
        DATA_WIDTH => DATA_WIDTH,
        ADDR_WIDTH => ADDR_WIDTH
    )
    port map (
        ReadReg1 => ReadReg1,
        ReadReg2 => ReadReg2,
        WriteReg => WriteReg,
        WriteData => WriteData,
        RegWrite => RegWrite,
        Clk => Clk,
        ReadData1 => ReadData1,
        ReadData2 => ReadData2
    );
   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;
		ReadReg1<="00001";
		ReadReg2<="00010";
		WriteReg<="00110";
		WriteData<=x"12345678";
		RegWrite<='1';
		wait for 100 ns;	

      wait for Clk_period*10;
		ReadReg1<="00011";
		ReadReg2<="00100";
		WriteReg<="01110";
		WriteData<=x"AB123456";
		RegWrite<='1';
		wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
