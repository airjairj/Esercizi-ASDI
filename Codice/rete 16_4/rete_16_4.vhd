library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo mux_16_1.
entity rete_16_4 is 
	port(	e0 : in STD_LOGIC;
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
end rete_16_4;

-- Definizione architettura del modulo mux_16_1 con una descrizione strutturale.
architecture OOOOO of rete_16_4 is
	signal u5 : STD_LOGIC := '0';

	component demux_1_4
        port(	d : in STD_LOGIC;
                s000 : in STD_LOGIC_VECTOR (1 downto 0);
                y000 : out STD_LOGIC_VECTOR (0 to 3)
            );			
	end component;

    component mux_16_1
		port(	c0 : in STD_LOGIC;
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

	begin
		mux16to1: mux_16_1 
				Port map(	
                        c0 	=> e0,
						c1 	=> e1,
						c2 	=> e2,
						c3 	=> e3,
						c4 	=> e4,
						c5 	=> e5,
						c6 	=> e6,
						c7 	=> e7,
						c8 	=> e8,
						c9 	=> e9,
						c10 	=> e10,
						c11 	=> e11,
						c12 	=> e12,
						c13 	=> e13,
						c14 	=> e14,
						c15 	=> e15,
						s00 	=> s0000,
						s11 	=> s1111,
						s22 	=> s2222,
						s33 	=> s3333,
						y00 	=> u5
					);
		demux4to1: demux_1_4
           		Port map(
                        d => u5,
                        s000(0) => s4444,
                        s000(1) => s5555,
                        y000(0) => y0000,
                        y000(1) => y1111,
                        y000(2) => y2222,
                        y000(3) => y3333
                    );

end OOOOO;