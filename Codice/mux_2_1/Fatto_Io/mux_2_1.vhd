library ieee;
use ieee.std_logic_1164.all;

--commento <--

entity mux_2_1 is
    port
    (
        a0 : in std_logic;
        a1 : in std_logic;
        y : out std_logic;
        s : in std_logic
    );

end mux_2_1;

architecture OOO of mux_2_1 is

    begin 
        y   <=  a0 when s = '0' else
                a1 when s = '1' else
                '-';

end OOO ;