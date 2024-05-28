library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is
signal pc_reg : std_logic_vector(31 downto 0) := (others => '0');

begin
process (clk, reset)
    begin
        if reset = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            pc_reg <= pc_in;
        end if;
    end process;

    pc_out <= pc_reg;

end Behavioral;

