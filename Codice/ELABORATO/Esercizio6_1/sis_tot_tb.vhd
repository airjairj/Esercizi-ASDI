library ieee;
use ieee.std_logic_1164.all;

entity tb_sis_tot is
end tb_sis_tot;

architecture tb of tb_sis_tot is

    component sis_tot
        port (start_tot : in std_logic;
              RST       : in std_logic;
              CLK_tot   : in std_logic;
              a_tot     : in std_logic_vector (0 to 3);
              y_tot     : out std_logic_vector (0 to 3));
    end component;

    signal start_tot : std_logic;
    signal RST       : std_logic;
    signal CLK_tot   : std_logic;
    signal a_tot     : std_logic_vector (0 to 3);
    signal y_tot     : std_logic_vector (0 to 3);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : sis_tot
    port map (start_tot => start_tot,
              RST       => RST,
              CLK_tot   => CLK_tot,
              a_tot     => a_tot,
              y_tot     => y_tot);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK_tot is really your main clock signal
    CLK_tot <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        start_tot <= '0';
        a_tot <= (others => '0');

        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        start_tot <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;




        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sis_tot of tb_sis_tot is
    for tb
    end for;
end cfg_tb_sis_tot;