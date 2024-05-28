library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity AluControl is
    Port ( funct : in  STD_LOGIC_VECTOR (5 downto 0);
           alu_op : in  STD_LOGIC_VECTOR (1 downto 0);
           operation : out  STD_LOGIC_VECTOR (3 downto 0));
end AluControl;

architecture Behavioral of AluControl is

begin
	operation(3)<='0';
	operation(2)<=alu_op(0) or (alu_op(1) and funct(1));
	operation(1)<=not alu_op(1) or not funct(2);
	operation(0)<=(funct(3) or funct(0)) and alu_op(1);
	


end Behavioral;

