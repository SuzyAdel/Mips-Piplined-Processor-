LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ControlUnit_Tb IS
END ControlUnit_Tb;
 
ARCHITECTURE behavior OF ControlUnit_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit
    PORT(
         opcode : IN  std_logic_vector(5 downto 0);
         reg_dst : OUT  std_logic;
         jump : OUT  std_logic;
         branch : OUT  std_logic;
         mem_read : OUT  std_logic;
         mem_to_reg : OUT  std_logic;
         reg_write : OUT  std_logic;
         mem_write : OUT  std_logic;
         alu_src : OUT  std_logic;
         alu_op : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal opcode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal reg_dst : std_logic;
   signal jump : std_logic;
   signal branch : std_logic;
   signal mem_read : std_logic;
   signal mem_to_reg : std_logic;
   signal reg_write : std_logic;
   signal mem_write : std_logic;
   signal alu_src : std_logic;
   signal alu_op : std_logic_vector(1 downto 0);

   -- Clock period definitions
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          opcode => opcode,
          reg_dst => reg_dst,
          jump => jump,
          branch => branch,
          mem_read => mem_read,
          mem_to_reg => mem_to_reg,
          reg_write => reg_write,
          mem_write => mem_write,
          alu_src => alu_src,
          alu_op => alu_op
        );

   

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		-- hold reset state for 100 ns.	
		opcode<="000000";
		wait for 100 ns;
		opcode<="100011";
		wait for 100 ns;
		opcode<="101011";
		wait for 100 ns;
		opcode<="000110";
		wait for 100 ns;
		opcode<="000010";
		wait for 100 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
