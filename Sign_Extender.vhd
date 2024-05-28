library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Sign_Extender is
    Port ( se_input : in  STD_LOGIC_VECTOR (15 downto 0);
           se_output : out  STD_LOGIC_VECTOR (31 downto 0));
end Sign_Extender;

architecture Behavioral of Sign_Extender is

begin
	se_output<=x"0000" & se_input when se_input(15)='0' else
				  x"ffff" & se_input;

end Behavioral;

