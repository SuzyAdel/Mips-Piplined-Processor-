library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mips_Tb is
end Mips_Tb;

architecture behavior of Mips_Tb is
    signal tb_clk : std_logic := '0';
    signal tb_rst : std_logic := '0';
    

    constant clk_period: time := 20 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.Mips
        port map (
            clk => tb_clk,
            rst => tb_rst
        );

    -- Clock process definitions
    clk_process: process
    begin
        tb_clk <= '0';
        wait for clk_period / 2;
        tb_clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Insert stimulus here
        wait for 100 ns;
		  wait for clk_period*10;
		  tb_rst<='0';
		  wait for 100 ns;
		  wait for clk_period*10;
        assert false report "End of Test" severity failure;
    end process;
end behavior;
