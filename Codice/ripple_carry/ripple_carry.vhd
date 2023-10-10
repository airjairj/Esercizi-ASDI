library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ripple_carry is
	port(	a_r_p : in STD_LOGIC_VECTOR (3 downto 0);
			b_r_p : in STD_LOGIC_VECTOR (3 downto 0);
			c_r_p : in STD_LOGIC;
			s_r_p : out STD_LOGIC_VECTOR (3 downto 0);
			r_r_p : out STD_LOGIC
			);		
end ripple_carry;

architecture ripple_carryArch of ripple_carry is

    component full_adder

        port( 	
			a_f_a : in std_logic;
			b_f_a : in std_logic;
			c_f_a : in std_logic;
			s_f_a : out std_logic;
			r_f_a : out std_logic
        );
            
    end component;

	for all : full_adder use entity work.full_adder;

    CONSTANT n : INTEGER := 4;
	signal carry : std_logic_vector(0 TO 3); --SEGNALE d'APPOGGIO

    BEGIN
        c_all: FOR i IN 0 TO n-1 generate
            l: IF i=0 GENERATE
                least: full_adder PORT MAP
                (
                    a_f_a => a_r_p(i),
                    b_f_a => b_r_p(i),
                    c_f_a => '0',
                    s_f_a => s_r_p(i),
                    r_f_a => carry(i)
                );
            END GENERATE;

            r: IF i > 0 and i <= n-1 GENERATE
            rest: full_adder PORT MAP
            (
                a_f_a => a_r_p(i),
				b_f_a => b_r_p(i),
                c_f_a => carry(i-1),
				s_f_a => s_r_p(i),
				r_f_a => carry(i)
            );
            END GENERATE;

        end generate;

end ripple_carryArch;