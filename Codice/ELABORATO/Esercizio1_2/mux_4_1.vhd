library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Definizione dell'interfaccia del modulo mux_4_1.
entity mux_4_1 is 
	port(	b0 : in STD_LOGIC;
			b1 : in STD_LOGIC;
			b2 : in STD_LOGIC;
			b3 : in STD_LOGIC;
			s0 : in STD_LOGIC;
			s1 : in STD_LOGIC;
			y0 : out STD_LOGIC
		);		
end mux_4_1;

-- Definizione architettura del modulo mux_4_1 con una descrizione strutturale.
architecture structural of mux_4_1 is
	signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';

	component mux_2_1
		port(	a0 	: in STD_LOGIC;
				a1 	: in STD_LOGIC;
				s 	: in STD_LOGIC;
				y 	: out STD_LOGIC
			);	
	end component;

	begin
		mux0: mux_2_1 
			Port map(	a0 	=> b0,
						a1 	=> b1,
						s 	=> s0,
						y 	=> u0
					);
		mux1: mux_2_1
			Port map(	a0 	=> b2,
						a1 	=> b3,
						s 	=> s0,
						y 	=> u1
					);
		mux2: mux_2_1
			Port map(	a0 	=> u0,
						a1 	=> u1,
						s 	=> s1,
						y 	=> y0
				);
end structural;