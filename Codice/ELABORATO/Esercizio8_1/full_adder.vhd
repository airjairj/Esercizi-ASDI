library ieee;
use ieee.std_logic_1164.all;

--commento <--

entity full_adder is
    port
    (
        a_f_a : in std_logic;
        b_f_a : in std_logic;
        c_f_a : in std_logic;
        s_f_a : out std_logic;
        r_f_a : out std_logic
    );

end full_adder;

architecture full_adderArch of full_adder is

    begin 
        s_f_a   <=  (a_f_a xor b_f_a) xor c_f_a;
        r_f_a   <=  ((a_f_a xor b_f_a) and c_f_a) or (a_f_a and b_f_a);

end full_adderArch;