LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY InstructionMemory_Tb IS
END InstructionMemory_Tb;
 
ARCHITECTURE behavior OF InstructionMemory_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Instruction_Memory
    generic(
		DATA_WIDTH : integer := 32; -- Width of each instruction (32 bits)
      ADDR_WIDTH : integer := 10    -- Address width (10 bits)
		);
    Port ( address : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           instruction : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
    END COMPONENT;
    CONSTANT DATA_WIDTH : integer := 32; -- Width of each instruction (32 bits)
    CONSTANT ADDR_WIDTH : integer := 10;

   --Inputs
   signal address : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');

 	--Outputs
   signal instruction : std_logic_vector(DATA_WIDTH-1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Instruction_Memory 
	Generic MAP(
	DATA_WIDTH=>DATA_WIDTH,
	ADDR_WIDTH=>ADDR_WIDTH
	)
	PORT MAP (
          address => address,
          instruction => instruction
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      
		address<="0000000001";
		wait for 100 ns;	

      
		address<="0000000010";
		wait for 100 ns;	

      
		address<="0000000011";
		wait for 100 ns;	

      
		address<="0000000100";
		wait for 100 ns;	

      
		

      -- insert stimulus here 

      wait;
   end process;

END;
