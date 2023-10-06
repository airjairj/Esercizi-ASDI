library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity M is
	port(	a_M : in STD_LOGIC_VECTOR (0 to 7);
            s_M : in STD_LOGIC_VECTOR (1 downto 0);
			y_M : out STD_LOGIC_VECTOR (0 to 3)
		);		
end M;

-- Definizione architettura del modulo mux_16_1 con una descrizione strutturale.
architecture MArch of M is
	signal intermedio0 : STD_LOGIC := '0';
	signal intermedio1 : STD_LOGIC := '0';

    component decoder_2_4

        port( 	
                a_dec : in STD_LOGIC_VECTOR (1 downto 0);
                y_dec : out STD_LOGIC_VECTOR (0 to 3)
        );
            
    end component;
    
    component mux_4_1 is 
        port(	
                a_mux : in STD_LOGIC_VECTOR (0 to 3);
                s_mux : in STD_LOGIC_VECTOR (1 downto 0);
                y_mux : out STD_LOGIC
            );		
    end component;

	begin
		mux0: mux_4_1 
			Port map(	
                        a_mux(0) => a_M(0),
                        a_mux(1) => a_M(1),
                        a_mux(2) => a_M(2),
                        a_mux(3) => a_M(3),
                        s_mux(0) => s_M(0),
                        s_mux(1) => s_M(1),
						y_mux 	 => intermedio0 
					);
        mux1: mux_4_1 
            Port map(	
                    a_mux(0) => a_M(4),
                    a_mux(1) => a_M(5),
                    a_mux(2) => a_M(6),
                    a_mux(3) => a_M(7),
                    s_mux(0) => s_M(0),
                    s_mux(1) => s_M(1),
                    y_mux 	 => intermedio1 
                );
        dec0: decoder_2_4
            Port map(
                    a_dec(0) => intermedio0, 
                    a_dec(1) => intermedio1,
                    y_dec => y_M 
                );

end MArch;