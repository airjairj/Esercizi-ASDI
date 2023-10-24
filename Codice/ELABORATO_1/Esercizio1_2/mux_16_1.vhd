library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo mux_16_1.
entity mux_16_1 is 
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
end mux_16_1;

-- Definizione architettura del modulo mux_16_1 con una descrizione strutturale.
architecture OOO of mux_16_1 is
	signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';
	signal u2 : STD_LOGIC := '0';
	signal u3 : STD_LOGIC := '0';

	component mux_4_1
		port(	b0 	: in STD_LOGIC;
				b1 	: in STD_LOGIC;
				b2 	: in STD_LOGIC;
				b3 	: in STD_LOGIC;
				s0 	: in STD_LOGIC;
				s1 	: in STD_LOGIC;
				y0 	: out STD_LOGIC
			);	
	end component;

	begin
		mux0: mux_4_1 
			Port map(	
                        b0 	=> c0,
						b1 	=> c1,
						b2 	=> c2,
						b3 	=> c3,
						s0 	=> s00,
						s1 	=> s11,
						y0 	=> u0
					);
		mux1: mux_4_1
            Port map(
                        b0 	=> c4,
                        b1 	=> c5,
                        b2 	=> c6,
                        b3 	=> c7,
                        s0 	=> s00,
                        s1 	=> s11,
                        y0 	=> u1
                    );
        mux2: mux_4_1
            Port map(
                        b0 	=> c8,
                        b1 	=> c9,
                        b2 	=> c10,
                        b3 	=> c11,
                        s0 	=> s00,
                        s1 	=> s11,
                        y0 	=> u2
                    );
        mux3: mux_4_1
            Port map(
                        b0 	=> c12,
                        b1 	=> c13,
                        b2 	=> c14,
                        b3 	=> c15,
                        s0 	=> s00,
                        s1 	=> s11,
                        y0 	=> u3
                    );
        mux4: mux_4_1
            Port map(
                        b0 	=> u0,
                        b1 	=> u1,
                        b2 	=> u2,
                        b3 	=> u3,
                        s0 	=> s22,
                        s1 	=> s33,
                        y0 	=> y00
                    );

end OOO;