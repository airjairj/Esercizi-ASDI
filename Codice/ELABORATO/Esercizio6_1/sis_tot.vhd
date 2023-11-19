library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.all;

entity sis_tot is
	port(	
            start_tot : in STD_LOGIC;
            RST_tot : in STD_LOGIC;
            CLK_tot : in STD_LOGIC;
			y_tot : out STD_LOGIC_VECTOR (0 to 3)
		);		
end sis_tot;

architecture sis_totArch of sis_tot is
	signal intermedio_ROM_M : STD_LOGIC_VECTOR (0 to 7);
	signal intermedio_M_MEM : STD_LOGIC_VECTOR (0 to 3);
	signal intermedio_UNO_COUNTER: STD_LOGIC := '0';
	signal intermedio_READ: STD_LOGIC;
	signal intermedio_WRITE: STD_LOGIC;
    signal o_contatore: STD_LOGIC_VECTOR (3 downto 0);
    
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
                address : in std_logic_vector (3 downto 0);
                out_rom : out std_logic_vector(7 downto 0)
        );
    end component;

    component MEM
        port(
                CLK : in std_logic;
                s_write : in std_logic;
                address : in std_logic_vector (3 downto 0);
                out_val : out std_logic_vector(3 downto 0);
                inp_val : in std_logic_vector(3 downto 0)
        );
    end component;

    component MOD_N_COUNTER
        Generic (N : integer := 16);  -- Imposta il valore di N come desideri
        Port (
                clk           : in std_logic;      -- clock input
                reset         : in std_logic;      -- reset input
                enable        : in std_logic;      -- start
                counter       : out std_logic_vector (3 downto 0);
                segnale_read  : out std_logic;
                segnale_write : out std_logic
            );
    end component;

    component UNO is
    Port (
        start : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        read_o_write : out std_logic := '0'
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
                        enable => intermedio_UNO_COUNTER,
                        counter => o_contatore,
                        segnale_read => intermedio_READ,
                        segnale_write => intermedio_WRITE
            );

		ROM0: ROM 
			Port map(	
                        CLK => CLK_tot,
                        s_read => intermedio_READ,
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
                        s_write => intermedio_WRITE,
                        out_val => y_tot,
                        inp_val => intermedio_M_MEM
                );

        UNO_coso: UNO
            Port map(
                        start => start_tot,
                        clk => clk_tot,
                        rst => rst_tot,
                        read_o_write => intermedio_UNO_COUNTER
            );

end sis_totArch;