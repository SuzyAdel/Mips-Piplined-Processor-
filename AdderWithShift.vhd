library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity AdderWithShift is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           sum : out  STD_LOGIC_VECTOR (31 downto 0));
end AdderWithShift;

architecture Behavioral of AdderWithShift is
signal shifted_B : STD_LOGIC_VECTOR(31 downto 0);
begin

    -- Shift B left by 2 bits
    shifted_B <= B(29 downto 0) & "00";

    -- Add A and shifted B
    Sum <= std_logic_vector(unsigned(A) + unsigned(shifted_B));



end Behavioral;

