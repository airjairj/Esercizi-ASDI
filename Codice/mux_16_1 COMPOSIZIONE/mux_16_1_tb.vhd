library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1_tb is
end mux_16_1_tb;

architecture OOOO of mux_16_1_tb is

    component mux_16_1 is
        port(
            c0 : in STD_LOGIC;
            c1 : in STD_LOGIC;
            c2 : in STD_LOGIC;
            c3 : in STD_LOGIC;
            c4 : in STD_LOGIC;
            c5 : in STD_LOGIC;
            c6 : in STD_LOGIC;
            c7 : in STD_LOGIC;
            c8 : in STD_LOGIC;
            c9 : in STD_LOGIC;
            c10 : in STD_LOGIC;
            c11 : in STD_LOGIC;
            c12 : in STD_LOGIC;
            c13 : in STD_LOGIC;
            c14 : in STD_LOGIC;
            c15 : in STD_LOGIC;
            s00 : in STD_LOGIC;
            s11 : in STD_LOGIC;
            s22 : in STD_LOGIC;
            s33 : in STD_LOGIC;
            y00 : out STD_LOGIC
        );
    end component;

    signal input     : STD_LOGIC_VECTOR (0 to 15)    := (others => '0');
    signal control   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal output    : STD_LOGIC                     := 'U';

begin

    utt: mux_16_1 port map (
        c0 => input(0),
        c1 => input(1),
        c2 => input(2),
        c3 => input(3),
        c4 => input(4),
        c5 => input(5),
        c6 => input(6),
        c7 => input(7),
        c8 => input(8),
        c9 => input(9),
        c10 => input(10),
        c11 => input(11),
        c12 => input(12),
        c13 => input(13),
        c14 => input(14),
        c15 => input(15),
        s00 => control(0),
        s11 => control(1),
        s22 => control(2),
        s33 => control(3),
        y00 => output
    );

    stim_proc: process begin
        wait for 100 ns;

        -- input = b0 b1 b2 b3 ... b15
        -- control = s3 s2 s1 s0

        input    <= "0100000000000000"; -- 4000

        control <= "0001"; -- ESCE IN HEX
        wait for 10 ns;

        control <= "1010"; -- ESCE IN HEX
        input    <= "0000000000100000"; -- 4000
        wait for 10 ns;

        assert output = '1'
            report "errore NON TI TROVI 1"
            severity failure;

        wait;
    end process;

end OOOO;
