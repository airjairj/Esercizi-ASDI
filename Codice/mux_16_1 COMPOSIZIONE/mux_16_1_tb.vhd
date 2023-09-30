library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_16_1_tb is
end mux_16_1_tb;

architecture OOOO of mux_16_1_tb is

    component mux_16_1 is
        port(
            b0 : in STD_LOGIC;
            b1 : in STD_LOGIC;
            b2 : in STD_LOGIC;
            b3 : in STD_LOGIC;
            b4 : in STD_LOGIC;
            b5 : in STD_LOGIC;
            b6 : in STD_LOGIC;
            b7 : in STD_LOGIC;
            b8 : in STD_LOGIC;
            b9 : in STD_LOGIC;
            b10 : in STD_LOGIC;
            b11 : in STD_LOGIC;
            b12 : in STD_LOGIC;
            b13 : in STD_LOGIC;
            b14 : in STD_LOGIC;
            b15 : in STD_LOGIC;
            s0 : in STD_LOGIC;
            s1 : in STD_LOGIC;
            s2 : in STD_LOGIC;
            s3 : in STD_LOGIC;
            y0 : out STD_LOGIC
        );
    end component;

    signal input     : STD_LOGIC_VECTOR (0 to 15)    := (others => '0');
    signal control   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal output    : STD_LOGIC                     := 'U';

begin

    utt: mux_16_1 port map (
        b0 => input(0),
        b1 => input(1),
        b2 => input(2),
        b3 => input(3),
        b4 => input(4),
        b5 => input(5),
        b6 => input(6),
        b7 => input(7),
        b8 => input(8),
        b9 => input(9),
        b10 => input(10),
        b11 => input(11),
        b12 => input(12),
        b13 => input(13),
        b14 => input(14),
        b15 => input(15),
        s0 => control(0),
        s1 => control(1),
        s2 => control(2),
        s3 => control(3),
        y0 => output
    );

    stim_proc: process begin
        wait for 100 ns;

        -- input = b0 b1 b2 b3 ... b15
        -- control = s3 s2 s1 s0

        input    <= "0100000000000000";

        control <= "0001";
        wait for 10 ns;

        control <= "1110";
        wait for 10 ns;

        assert output = '0'
            report "error"
            severity failure;

        wait;
    end process;

end OOOO;
