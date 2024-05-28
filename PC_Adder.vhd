library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_Adder is
    Port ( PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Next_PC : out  STD_LOGIC_VECTOR (31 downto 0));
end PC_Adder;

architecture Behavioral of PC_Adder is

begin
process(PC)
    begin
        Next_PC <= std_logic_vector(unsigned(PC)+4); -- Add 4 to the PC
    end process;

end Behavioral;

