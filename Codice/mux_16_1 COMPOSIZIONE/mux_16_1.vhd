library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo mux_16_1.
entity mux_16_1 is 
	port(	b0 : in STD_LOGIC;
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
end mux_16_1;

-- Definizione architettura del modulo mux_16_1 con una descrizione strutturale.
architecture OOO of mux_16_1 is
	signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';
	signal u2 : STD_LOGIC := '0';
	signal u3 : STD_LOGIC := '0';

	component mux_4_1
		port(	a0 	: in STD_LOGIC;
				a1 	: in STD_LOGIC;
				a2 	: in STD_LOGIC;
				a3 	: in STD_LOGIC;
				s0 	: in STD_LOGIC;
				s1 	: in STD_LOGIC;
				y 	: out STD_LOGIC
			);	
	end component;

	begin
		mux0: mux_4_1 
			Port map(	
                        a0 	=> b0,
						a1 	=> b1,
						a2 	=> b2,
						a3 	=> b3,
						s0 	=> s1,
						s1 	=> s0,
						y 	=> u0
					);
		mux1: mux_4_1
            Port map(
                        a0 	=> b4,
                        a1 	=> b5,
                        a2 	=> b6,
                        a3 	=> b7,
                        s0 	=> s1,
                        s1 	=> s0,
                        y 	=> u1
                    );
        mux2: mux_4_1
            Port map(
                        a0 	=> b8,
                        a1 	=> b9,
                        a2 	=> b10,
                        a3 	=> b11,
                        s0 	=> s1,
                        s1 	=> s0,
                        y 	=> u2
                    );
        mux3: mux_4_1
            Port map(
                        a0 	=> b12,
                        a1 	=> b13,
                        a2 	=> b14,
                        a3 	=> b15,
                        s0 	=> s1,
                        s1 	=> s0,
                        y 	=> u3
                    );
        mux4: mux_4_1
            Port map(
                        a0 	=> u0,
                        a1 	=> u1,
                        a2 	=> u2,
                        a3 	=> u3,
                        s0 	=> s3,
                        s1 	=> s2,
                        y 	=> y0
                    );

end OOO;