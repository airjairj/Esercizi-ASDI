library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sis_tot is
	port(	
            start_tot : in STD_LOGIC;
            RST : in STD_LOGIC;
            CLK_tot : in STD_LOGIC;
            a_tot : in STD_LOGIC_VECTOR (0 to 3);
			y_tot : out STD_LOGIC_VECTOR (0 to 3)
		);		
end sis_tot;

architecture sis_totArch of sis_tot is
	signal intermedio : STD_LOGIC_VECTOR (0 to 7);
	signal intermedio2 : STD_LOGIC_VECTOR (0 to 3);
    signal o_contatore: integer;
    
    component M
        port(	
                a_M : in STD_LOGIC_VECTOR (0 to 7);
                y_M : out STD_LOGIC_VECTOR (0 to 3)
            );		
    end component;

    component ROM
        port(
                CLK : in STD_LOGIC;
                s_read : in std_logic;
                address : in integer;
                out_rom : out std_logic_vector(7 downto 0)
        );
    end component;

    component MEM
        port(
                    CLK : in std_logic;
                    s_write : in std_logic;
                    address : in integer;
                    out_mem : out std_logic_vector(3 downto 0);
                    m_in : in std_logic_vector(3 downto 0)
        );
    end component;

    component contatore_mod_N
        generic (
                    N: integer := 16
        );
        port(
                    a      : in std_logic;
                    reset  : in std_logic;
                    enable : in std_logic;
                    o      : out integer
        );
    end component;

	begin
		ROM0: ROM 
			Port map(	
                        CLK => CLK_tot,
                        s_read => start_tot,
                        address => o_contatore, 
						out_rom => intermedio
					);
        M0: M 
            Port map(	
                        a_M => intermedio,
                        y_M	=> intermedio2
                );
        
        MEM0: MEM
            Port map(	
                        CLK => CLK_tot,
                        address => o_contatore,
                        m_in => intermedio2,
                        s_write => start_tot,
                        out_mem => y_tot
                );

        Cont: contatore_mod_N
            generic map (
                        N => 16
            )
            Port map(	
                        a => CLK_tot,
                        reset => RST,
                        enable => start_tot,
                        o => o_contatore
            );

end sis_totArch;