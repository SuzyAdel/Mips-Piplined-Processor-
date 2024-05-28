library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataMemory is
 generic (
        DATA_WIDTH : integer := 32;  -- Width of the data bus
        ADDR_WIDTH : integer := 10   -- Width of the address bus
    );
    Port ( address : in  STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0); 
           data_in : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- 3ashan el store
           data_out : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- 3ashan el load
			  memory_read: in STD_LOGIC; -- ba load
			  memory_write: in STD_LOGIC; -- ba store
			  clk: in STD_LOGIC
			  );
end DataMemory;

architecture Behavioral of DataMemory is
type memory_array is array (0 to 2**ADDR_WIDTH-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal memory : memory_array := (
    0=>x"33330000",
	 1=>x"3343ABCD", 
    2 => x"99912222", 
    3 => x"44447777", 
    4 => x"FFFF1234", 
    others => (others => '0'));

begin
process (clk)
    begin
        if rising_edge(clk) then
            if memory_write = '1' then
                memory(to_integer(unsigned(address))) <= data_in;  -- Write operation (Store)
            end if;
            if memory_read = '1' then
                data_out <= memory(to_integer(unsigned(address)));  -- Read operation
            end if;
				if memory_read ='0' and memory_write='0' then
				data_out<=x"00000000";
				end if;
        end if;
    end process;

end Behavioral;

