library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TaylorCosine is
    Port (
        angle       : in STD_LOGIC_VECTOR(31 downto 0); -- Input angle in radians (fixed-point format)
        cosine_result : out STD_LOGIC_VECTOR(31 downto 0) -- Output cosine value (fixed-point format)
    );
end TaylorCosine;

architecture Behavioral of TaylorCosine is

    -- Define constants for factorials (fixed-point representation)
    constant FACT_2 : INTEGER := 2; -- 2!
    constant FACT_4 : INTEGER := 24; -- 4!
    constant FACT_6 : INTEGER := 720; -- 6!
    constant FACT_8 : INTEGER := 40320; -- 8!

    -- Temporary signals for calculations
    signal angle_r, angle_r2, angle_r4, angle_r6, angle_r8 : INTEGER range -(2**31) to (2**31)-1;
    signal term1, term2, term3, term4, term5 : INTEGER range -(2**31) to (2**31)-1;
    signal result : INTEGER range -(2**31) to (2**31)-1;

begin

    process(angle)
    begin
        -- Convert angle to radians (if needed)
        angle_r <= to_integer(signed(angle)); -- Convert angle to integer

        -- Calculate powers of angle
        angle_r2 <= angle_r * angle_r;
        angle_r4 <= angle_r2 * angle_r2;
        angle_r6 <= angle_r4 * angle_r2;
        angle_r8 <= angle_r4 * angle_r4;

        -- Calculate terms of the Taylor series
        term1 <= 1; -- 1
        term2 <= angle_r2 / FACT_2; -- x^2 / 2!
        term3 <= angle_r4 / FACT_4; -- x^4 / 4!
        term4 <= angle_r6 / FACT_6; -- x^6 / 6!
        term5 <= angle_r8 / FACT_8; -- x^8 / 8!

        -- Calculate cosine result using Taylor series
        result <= term1 - term2 + term3 - term4 + term5; -- Combine terms

        cosine_result <= std_logic_vector(to_unsigned(result, cosine_result'length)); -- Convert result back to std_logic_vector
    end process;
end Behavioral;
