LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY AluControl_Tb IS
END AluControl_Tb;
 
ARCHITECTURE behavior OF AluControl_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT AluControl
    PORT(
         funct : IN  std_logic_vector(5 downto 0);
         alu_op : IN  std_logic_vector(1 downto 0);
         operation : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal funct : std_logic_vector(5 downto 0) := (others => '0');
   signal alu_op : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal operation : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AluControl PORT MAP (
          funct => funct,
          alu_op => alu_op,
          operation => operation
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		funct<="100000";
		alu_op<="10";
		wait for 100 ns;
		funct<="010000";
		alu_op<="01";
		wait for 100 ns;
		funct<="001000";
		alu_op<="11";
		wait for 100 ns;
      

      -- insert stimulus here 

      wait;
   end process;

END;
