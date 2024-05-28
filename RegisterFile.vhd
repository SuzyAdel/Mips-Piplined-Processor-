library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
    generic (
        DATA_WIDTH : integer := 32; -- Width of the data
        ADDR_WIDTH : integer := 5   -- Width of the address
    );
    port (
        ReadReg1 : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
        ReadReg2 : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
        WriteReg : in STD_LOGIC_VECTOR (ADDR_WIDTH-1 downto 0);
        WriteData : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        RegWrite : in STD_LOGIC;
        Clk : in STD_LOGIC;
        ReadData1 : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        ReadData2 : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type regfile_type is array ((2**ADDR_WIDTH)-1 downto 0) of STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
    signal regfile : regfile_type := (
	 0=> x"00000002",
    1 => x"12345678", 
    2 => x"ABCD3456", 
    3 => x"56783421", 
    4 => x"BACD1234", 
    others => (others => '0') -- Initialize all other registers with zeros
);

begin
    process(Clk)
    begin
        if rising_edge(Clk) then
            if RegWrite = '1' then
                regfile(to_integer(unsigned(WriteReg))) <= WriteData;
            end if;
        end if;
    end process;

    ReadData1 <= regfile(to_integer(unsigned(ReadReg1)));
    ReadData2 <= regfile(to_integer(unsigned(ReadReg2)));

end Behavioral;

