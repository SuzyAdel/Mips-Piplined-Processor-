library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Memory is
	generic(
		DATA_WIDTH : integer := 32; -- Width of each instruction (32 bits)
      ADDR_WIDTH : integer := 10    -- Address width (10 bits)
		);
    Port ( address : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
           instruction : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
type instruction_memory_type is array (0 to (2**ADDR_WIDTH)-1) of STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
constant instructions : instruction_memory_type := (
	 0 => x"00001234", 
    1 => x"ABCD1234", 
    2 => x"98761234", 
    3 => x"33334444", 
    4 => x"FFF2AB87", 
	 632=>x"11114444",
	 208=>x"00001111",
    others => (others => '0') 
);
begin
instruction <= instructions(to_integer(unsigned(address))); -- Output instruction at the specified address

end Behavioral;

