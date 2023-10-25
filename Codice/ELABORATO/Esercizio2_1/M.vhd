library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity M is
	port(	a_M : in STD_LOGIC_VECTOR (0 to 7);
			y_M : out STD_LOGIC_VECTOR (0 to 3)
		);		
end M;

-- Definizione architettura del modulo mux_16_1 con una descrizione strutturale.
architecture MArch of M is

    component encoder_4_2

        port( 	
                a_enc : in STD_LOGIC_VECTOR (0 to 3);
                y_enc : out STD_LOGIC_VECTOR (0 to 1)
        );
            
    end component;


	begin
        enc0: encoder_4_2
            Port map(
                    a_enc(0) => a_M(0), 
                    a_enc(1) => a_M(1), 
                    a_enc(2) => a_M(2), 
                    a_enc(3) => a_M(3), 
                    y_enc(0) => y_M(0), 
                    y_enc(1) => y_M(1) 
                );
        enc1: encoder_4_2
            Port map(
                    a_enc(0) => a_M(4), 
                    a_enc(1) => a_M(5), 
                    a_enc(2) => a_M(6), 
                    a_enc(3) => a_M(7), 
                    y_enc(0) => y_M(2), 
                    y_enc(1) => y_M(3) 
                );

end MArch;