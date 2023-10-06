library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sis_tot is
	port(	
            a_tot : in STD_LOGIC_VECTOR (0 to 3);
            s_tot : in STD_LOGIC_VECTOR (1 downto 0);
			y_tot : out STD_LOGIC_VECTOR (0 to 3)
		);		
end sis_tot;

architecture sis_totArch of sis_tot is
	signal intermedio : STD_LOGIC_VECTOR (0 to 7);

    component M
        port(	
                a_M : in STD_LOGIC_VECTOR (0 to 7);
                s_M : in STD_LOGIC_VECTOR (1 downto 0);
                y_M : out STD_LOGIC_VECTOR (0 to 3)
            );		
    end component;

    component ROM
        port(
                address : in std_logic_vector(3 downto 0);
                out_rom : out std_logic_vector(7 downto 0)
        );
    end component;

	begin
		ROM0: ROM 
			Port map(	
                        address => a_tot, 
						out_rom => intermedio
					);
        M0: M 
            Port map(	
                        a_M => intermedio,
                        y_M	=> y_tot,
                        s_M => s_tot
                );

end sis_totArch;