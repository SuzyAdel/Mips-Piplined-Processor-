LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PipelinedMips_Tb IS
END PipelinedMips_Tb;
 
ARCHITECTURE behavior OF PipelinedMips_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PipelineMips
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PipelineMips PORT MAP (
          clk => clk,
          rst => rst
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
		rst<='0';
		wait for 100 ns;	

      wait for clk_period*10;
		rst<='1';
		wait for 100 ns;	

      wait for clk_period*10;
		rst<='0';
		wait for 100 ns;	

      wait for clk_period*10;
		assert false report "End of Test" severity failure;

		

      -- insert stimulus here 

      wait;
   end process;

END;
