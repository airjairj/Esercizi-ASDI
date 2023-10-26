library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- la CU ha il compito di caricare la stringa da 32 bit da mostrare sugli 8 display
-- in due passi e di settare hìgli enable per i punti e le cifre

entity control_unit is
    Port ( 
           reset : in  STD_LOGIC;
		   load_first_part : in  STD_LOGIC;
           load_second_part : in  STD_LOGIC;
		   INP : in STD_LOGIC_VECTOR(7 downto 0); --valore acquisito dai , 8 alla volta
		   SEL : in STD_LOGIC_VECTOR(5 downto 0);
           OUTP : out STD_LOGIC_VECTOR(3 downto 0) --valore su 32 bit da mostrare sui display
			  );
end control_unit;

architecture control_unitArch of control_unit is

signal INP_temp : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

component rete_16_4 is 
	port(	e0 : IN STD_LOGIC;
            e1 : IN STD_LOGIC;
            e2 : IN STD_LOGIC;
            e3 : IN STD_LOGIC;
            e4 : IN STD_LOGIC;
            e5 : IN STD_LOGIC;
            e6 : IN STD_LOGIC;
            e7 : IN STD_LOGIC;
            e8 : IN STD_LOGIC;
            e9 : IN STD_LOGIC;
            e10 : IN STD_LOGIC;
            e11 : IN STD_LOGIC;
            e12 : IN STD_LOGIC;
            e13 : IN STD_LOGIC;
            e14 : IN STD_LOGIC;
            e15 : IN STD_LOGIC;
			s0000 : IN STD_LOGIC;
			s1111 : IN STD_LOGIC;
			s2222 : IN STD_LOGIC;
			s3333 : IN STD_LOGIC;
			s4444 : IN STD_LOGIC;
			s5555 : IN STD_LOGIC;
			y0000 : out STD_LOGIC;
			y1111 : out STD_LOGIC;
			y2222 : out STD_LOGIC;
			y3333 : out STD_LOGIC
		);		
end component;

begin

    rete: rete_16_4 port map(
        e0 	    => INP_temp(0),
        e1 	    => INP_temp(1),
        e2 	    => INP_temp(2),
        e3 	    => INP_temp(3),
        e4 	    => INP_temp(4),
        e5 	    => INP_temp(5),
        e6 	    => INP_temp(6),
        e7 	    => INP_temp(7),
        e8 	    => INP_temp(8),
        e9 	    => INP_temp(9),
        e10 	=> INP_temp(10),
        e11     => INP_temp(11),
        e12 	=> INP_temp(12),
        e13	    => INP_temp(13),
        e14	    => INP_temp(14),
        e15	    => INP_temp(15),
        s0000	=> SEL(0),
        s1111 	=> SEL(1),
        s2222 	=> SEL(2),
        s3333 	=> SEL(3),
        s4444 	=> SEL(4),
        s5555 	=> SEL(5),
        y0000   => OUTP(0), 
        y1111   => OUTP(1), 
        y2222   => OUTP(2), 
        y3333   => OUTP(3)
);

main: process(load_first_part,load_second_part,INP)
begin

    if reset = '1' then
        INP_temp <= (others => '0');
	else
        if load_first_part = '1' then
            INP_temp(7 downto 0) <= INP(7 downto 0);
        elsif load_second_part = '1' then
            INP_temp(15 downto 8) <= INP(7 downto 0);
        end if;
    end if;

end process;




end control_unitArch;

