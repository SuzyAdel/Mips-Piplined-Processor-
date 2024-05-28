LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PCAdder_Tb IS
END PCAdder_Tb;
 
ARCHITECTURE behavior OF PCAdder_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC_Adder
    PORT(
         PC : IN  std_logic_vector(31 downto 0);
         Next_PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Next_PC : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC_Adder PORT MAP (
          PC => PC,
          Next_PC => Next_PC
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		PC<=x"12345678";
		wait for 100 ns;
		PC<=x"ABCD1234";
		wait for 100 ns;
		PC<=x"99998888";
		wait for 100 ns;

      

      -- insert stimulus here 

      wait;
   end process;

END;
