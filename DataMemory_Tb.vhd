LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DataMemory_Tb IS
END DataMemory_Tb;
 
ARCHITECTURE behavior OF DataMemory_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DataMemory
	 generic(
		DATA_WIDTH : integer := 32; -- Width of each instruction (32 bits)
      ADDR_WIDTH : integer := 10    -- Address width (10 bits)
		);
    PORT(
			  address : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           data_in : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           data_out : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
			  memory_read: in STD_LOGIC;
			  memory_write: in STD_LOGIC;
			  clk: in STD_LOGIC
        );
    END COMPONENT;
    CONSTANT DATA_WIDTH : integer := 32; -- Width of each instruction (32 bits)
    CONSTANT ADDR_WIDTH : integer := 10;

   --Inputs
   signal address : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
   signal data_in : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
   signal memory_read : std_logic := '0';
   signal memory_write : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(DATA_WIDTH-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DataMemory 
	GENERIC MAP(
	DATA_WIDTH=>DATA_WIDTH,
	ADDR_WIDTH=>ADDR_WIDTH
	)
	PORT MAP (
          address => address,
          data_in => data_in,
          data_out => data_out,
          memory_read => memory_read,
          memory_write => memory_write,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		address<="0000000001";
		memory_read<='0';
		memory_write<='1';
		data_in<=x"12345678";
		wait for 100 ns;	

      wait for clk_period*10;
		memory_read<='1';
		memory_write<='0';
		address<="0000000010";
		data_in<=x"ABCD5678";
		wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
