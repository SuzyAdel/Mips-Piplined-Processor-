LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
ENTITY Mux_Tb IS
END Mux_Tb;
 
ARCHITECTURE behavior OF Mux_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mux
    generic(
		N: integer:=32
	);
    Port ( mux_input1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           mux_input2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           mux_output : out  STD_LOGIC_VECTOR (N-1 downto 0);
           mux_control : in  STD_LOGIC);
    END COMPONENT;
    CONSTANT N : integer := 32;
   --Inputs
   signal mux_input1 : std_logic_vector(N-1 downto 0) := (others => '0');
   signal mux_input2 : std_logic_vector(N-1 downto 0) := (others => '0');
   signal mux_control : std_logic := '0';

 	--Outputs
   signal mux_output : std_logic_vector(N-1 downto 0);
   
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mux 
	GENERIC MAP (
            N => N
        )
	PORT MAP (
          mux_input1 => mux_input1,
          mux_input2 => mux_input2,
          mux_output => mux_output,
          mux_control => mux_control
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		mux_input1<=X"12345678";
		mux_input2<=X"45671234";
		mux_control<='0';
		wait for 100 ns;
		mux_input1<=X"a2345678";
		mux_input2<=X"b5671234";
		mux_control<='1';
		wait for 100 ns;
		mux_input1<=X"a2225678";
		mux_input2<=X"bb671234";
		mux_control<='0';
		wait for 100 ns;

      

      -- insert stimulus here 

      wait;
   end process;

END;
