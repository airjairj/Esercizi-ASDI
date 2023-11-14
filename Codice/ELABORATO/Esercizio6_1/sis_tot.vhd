library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sis_tot is
	port(	
            start_tot : in STD_LOGIC;
            avanza_contatore : in std_logic;
            RST_tot : in STD_LOGIC;
            CLK_tot : in STD_LOGIC;
			y_tot : out STD_LOGIC_VECTOR (0 to 3)
		);		
end sis_tot;

architecture sis_totArch of sis_tot is
	signal intermedio_ROM_M : STD_LOGIC_VECTOR (0 to 7);
	signal intermedio_M_MEM : STD_LOGIC_VECTOR (0 to 3);
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

    component MOD_N_COUNTER
        generic (
                    N: integer := 16
        );
        Port (
                    clk : in std_logic;
                    reset : in std_logic;
                    counter : out integer;
                    enable : in std_logic
        );
    end component;

	begin
        Cont: MOD_N_COUNTER
            generic map (
                        N => 16
            )
            Port map(	
                        clk => CLK_tot,
                        reset => RST_tot,
                        enable => avanza_contatore,
                        counter => o_contatore
            );

		ROM0: ROM 
			Port map(	
                        CLK => CLK_tot,
                        s_read => start_tot,
                        address => o_contatore, 
						out_rom => intermedio_ROM_M
					);
        M0: M 
            Port map(	
                        a_M => intermedio_ROM_M,
                        y_M	=> intermedio_M_MEM
                );
        
        MEM0: MEM
            Port map(	
                        CLK => clk_tot,
                        address => o_contatore,
                        m_in => intermedio_M_MEM,
                        s_write => start_tot,
                        out_mem => y_tot
                );



end sis_totArch;