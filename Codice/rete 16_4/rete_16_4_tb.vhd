library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rete_16_4_tb is
end rete_16_4_tb;

architecture OOOOO of rete_16_4_tb is

    component rete_16_4 is
        port(
            e0 : in STD_LOGIC;
            e1 : in STD_LOGIC;
            e2 : in STD_LOGIC;
            e3 : in STD_LOGIC;
            e4 : in STD_LOGIC;
            e5 : in STD_LOGIC;
            e6 : in STD_LOGIC;
            e7 : in STD_LOGIC;
            e8 : in STD_LOGIC;
            e9 : in STD_LOGIC;
            e10 : in STD_LOGIC;
            e11 : in STD_LOGIC;
            e12 : in STD_LOGIC;
            e13 : in STD_LOGIC;
            e14 : in STD_LOGIC;
            e15 : in STD_LOGIC;
			s0000 : in STD_LOGIC;
			s1111 : in STD_LOGIC;
			s2222 : in STD_LOGIC;
			s3333 : in STD_LOGIC;
			s4444 : in STD_LOGIC;
			s5555 : in STD_LOGIC;
			y0000 : out STD_LOGIC;
			y1111 : out STD_LOGIC;
			y2222 : out STD_LOGIC;
			y3333 : out STD_LOGIC
        );
    end component;

    signal input     : STD_LOGIC_VECTOR (0 to 15)    := (others => '0');
    signal control   : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
    signal output    : STD_LOGIC_VECTOR (0 to 3)     := "UUUU";

begin

    utt: rete_16_4 port map (
        e0 => input(0),
        e1 => input(1),
        e2 => input(2),
        e3 => input(3),
        e4 => input(4),
        e5 => input(5),
        e6 => input(6),
        e7 => input(7),
        e8 => input(8),
        e9 => input(9),
        e10 => input(10),
        e11 => input(11),
        e12 => input(12),
        e13 => input(13),
        e14 => input(14),
        e15 => input(15),
        s0000 => control(0),
        s1111 => control(1),
        s2222 => control(2),
        s3333 => control(3),
        s4444 => control(4),
        s5555 => control(5),
        y0000 => output(0),
        y1111 => output(1),
        y2222 => output(2),
        y3333 => output(3)
    );

    stim_proc: process begin
        wait for 100 ns;

        -- input = b0 b1 b2 b3 ... b15
        -- control = s3 s2 s1 s0

        input    <= "0100000000000000"; -- 4000

        control <= "000101"; -- ESCE IN HEX
        wait for 10 ns;

        assert output = "0010"
            report "errore NON TI TROVI"
            severity failure;

        wait;
    end process;

end OOOOO;
