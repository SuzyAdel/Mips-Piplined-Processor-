library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TaylorSine is
    Port (
        angle       : in STD_LOGIC_VECTOR(31 downto 0); -- Input angle in radians (fixed-point format)
        sine_result : out STD_LOGIC_VECTOR(31 downto 0) -- Output sine value (fixed-point format)
    );
end TaylorSine;

architecture Behavioral of TaylorSine is

    -- Define constants for factorials (fixed-point representation)
    constant FACT_3 : INTEGER := 6; -- 3!
    constant FACT_5 : INTEGER := 120; -- 5!
    constant FACT_7 : INTEGER := 5040; -- 7!
    constant FACT_9 : INTEGER := 362880; -- 9!

    -- Temporary signals for calculations
    signal angle_r, angle_r2, angle_r3, angle_r5, angle_r7, angle_r9 : INTEGER range -(2**31) to (2**31)-1;
    signal term1, term2, term3, term4, term5 : INTEGER range -(2**31) to (2**31)-1;
    signal result : INTEGER range -(2**31) to (2**31)-1;

begin

    process(angle)
    begin
        -- Convert angle to radians (if needed)
        angle_r <= to_integer(signed(angle)); -- Convert angle to integer

        -- Calculate powers of angle
        angle_r2 <= angle_r * angle_r;
        angle_r3 <= angle_r2 * angle_r;
        angle_r5 <= angle_r3 * angle_r2;
        angle_r7 <= angle_r5 * angle_r2;
        angle_r9 <= angle_r7 * angle_r2;

        -- Calculate terms of the Taylor series
        term1 <= angle_r; -- x
        term2 <= angle_r3 / FACT_3; -- x^3 / 3!
        term3 <= angle_r5 / FACT_5; -- x^5 / 5!
        term4 <= angle_r7 / FACT_7; -- x^7 / 7!
        term5 <= angle_r9 / FACT_9; -- x^9 / 9!

        -- Calculate sine result using Taylor series
        result <= term1 - term2 + term3 - term4 + term5; -- Combine terms

        sine_result <= std_logic_vector(to_unsigned(result, sine_result'length)); -- Convert result back to std_logic_vector
    end process;
end Behavioral;
