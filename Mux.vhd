library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux is
generic(
N: integer:=32
);
    Port ( mux_input1 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           mux_input2 : in  STD_LOGIC_VECTOR (N-1 downto 0);
           mux_output : out  STD_LOGIC_VECTOR (N-1 downto 0);
           mux_control : in  STD_LOGIC);
end Mux;

architecture Behavioral of Mux is

begin
	mux_output<=mux_input1 when mux_control='0' else
					mux_input2;

end Behavioral;

