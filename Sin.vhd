library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sin is
    Port (
        clk         : in STD_LOGIC;
        reset       : in STD_LOGIC;
        angle       : in STD_LOGIC_VECTOR(31 downto 0); -- Input angle in radians (fixed-point format)
        sine_result : out STD_LOGIC_VECTOR(31 downto 0) -- Output sine value (fixed-point format)
    );
end Sin;

architecture Behavioral of Sin is

    -- Define constants for factorials (fixed-point representation)
    constant FACT_3 : STD_LOGIC_VECTOR(31 downto 0) := x"00000006"; -- 3!
    constant FACT_5 : STD_LOGIC_VECTOR(31 downto 0) := x"00000078"; -- 5!
    constant FACT_7 : STD_LOGIC_VECTOR(31 downto 0) := x"00001320"; -- 7!
    constant FACT_9 : STD_LOGIC_VECTOR(31 downto 0) := x"0004A380"; -- 9!

    -- Temporary signals for calculations
    signal angle_r, angle_r2, angle_r3, angle_r5, angle_r7, angle_r9 : STD_LOGIC_VECTOR(31 downto 0);
    signal term1, term2, term3, term4, term5 : STD_LOGIC_VECTOR(31 downto 0);
    signal result : STD_LOGIC_VECTOR(31 downto 0);

begin

    process(clk, reset)
    begin
        if reset = '1' then
            sine_result <= (others => '0');
            result <= (others => '0');
        elsif rising_edge(clk) then
            -- Convert angle to radians (if needed)
            angle_r <= angle; -- Assume the input is already in radians

            -- Calculate powers of angle
            angle_r2 <= (angle_r * angle_r)(31 downto 0);
            angle_r3 <= (angle_r2 * angle_r)(31 downto 0);
            angle_r5 <= (angle_r3 * angle_r2)(31 downto 0);
            angle_r7 <= (angle_r5 * angle_r2)(31 downto 0);
            angle_r9 <= (angle_r7 * angle_r2)(31 downto 0);

            -- Calculate terms of the Taylor series
            term1 <= angle_r; -- x
            term2 <= (angle_r3 / FACT_3)(31 downto 0); -- x^3 / 3!
            term3 <= (angle_r5 / FACT_5)(31 downto 0); -- x^5 / 5!
            term4 <= (angle_r7 / FACT_7)(31 downto 0); -- x^7 / 7!
            term5 <= (angle_r9 / FACT_9)(31 downto 0); -- x^9 / 9!

            -- Calculate sine result using Taylor series
            result <= term1 - term2 + term3 - term4 + term5; -- Combine terms

            sine_result <= result;
        end if;
    end process;

end Behavioral;

