--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY AdderWithShift_Tb IS
END AdderWithShift_Tb;
 
ARCHITECTURE behavior OF AdderWithShift_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AdderWithShift
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         sum : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal sum : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AdderWithShift PORT MAP (
          A => A,
          B => B,
          sum => sum
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		A<=x"12445566";
		B<=x"ABCD1234";
		wait for 100 ns;
		A<=x"CEFD5566";
		B<=x"44441234";
		wait for 100 ns;
		A<=x"EAFD5566";
		B<=x"33331234";
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
