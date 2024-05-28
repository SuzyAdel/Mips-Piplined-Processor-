LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY SignExtender_Tb IS
END SignExtender_Tb;
 
ARCHITECTURE behavior OF SignExtender_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sign_Extender
    PORT(
         se_input : IN  std_logic_vector(15 downto 0);
         se_output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal se_input : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal se_output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sign_Extender PORT MAP (
          se_input => se_input,
          se_output => se_output
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		se_input<=x"1234";
		wait for 100 ns;
		se_input<=x"2222";
		wait for 100 ns;
		se_input<=x"6666";
		wait for 100 ns;
      se_input<=x"f123";

      -- insert stimulus here 

      wait;
   end process;

END;
