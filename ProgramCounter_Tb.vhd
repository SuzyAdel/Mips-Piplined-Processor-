LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ProgramCounter_Tb IS
END ProgramCounter_Tb;
 
ARCHITECTURE behavior OF ProgramCounter_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgramCounter
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pc_in : IN  std_logic_vector(31 downto 0);
         pc_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal pc_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal pc_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgramCounter PORT MAP (
          clk => clk,
          reset => reset,
          pc_in => pc_in,
          pc_out => pc_out
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
		reset<='0';
		pc_in<=x"CDEF2378";
		wait for 100 ns;	

      wait for clk_period*10;
		reset<='1';
		
		wait for 100 ns;	

      wait for clk_period*10;
		reset<='0';
		pc_in<=x"345ABCD7";
		wait for 100 ns;	

      wait for clk_period*10;
		

      -- insert stimulus here 

      wait;
   end process;

END;
