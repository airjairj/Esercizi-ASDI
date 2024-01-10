-- QUESTA Ã¨ LA CONTROL UNIT
library ieee;
use ieee.std_logic_1164.all;

entity CONTROL_UNIT is
    port
    (
        i : in std_logic;
        clock : in std_logic;
        RST_tot : in STD_LOGIC;
        y_tot : out STD_LOGIC_VECTOR (0 to 3);
        b_read: in STD_LOGIC;
        b_write: in STD_LOGIC
    );
end CONTROL_UNIT;

architecture CONTROL_UNITArch of CONTROL_UNIT is
    signal intermedio_ROM_M : STD_LOGIC_VECTOR (0 to 7);
	signal intermedio_M_MEM : STD_LOGIC_VECTOR (0 to 3);
	signal intermedio_UNO_COUNTER: STD_LOGIC := '0';
    signal o_contatore: STD_LOGIC_VECTOR (3 downto 0);
    
    signal intermedio_READ: STD_LOGIC := '0';
    signal intermedio_WRITE: STD_LOGIC := '0';
    signal temp_READ: STD_LOGIC := '0';
    signal temp_WRITE: STD_LOGIC := '0';
    
    signal bottone_read: STD_LOGIC := '0';
    signal bottone_write: STD_LOGIC := '0';
    
    type stato is (READING, WRITING, PAUSA); 
    signal stato_attuale : stato := PAUSA;
    signal stato_prossimo : stato;
    signal o_temp : std_logic;
        
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
                counter       : out std_logic_vector (3 downto 0)
            );
    end component;
    
    component ButtonDebouncer
        Generic (                       
            CLK_period: integer := 10; -- Period of the board's clock in nanoseconds
            btn_noise_time: integer := 10000000 -- Estimated button bounce duration in nanoseconds
        );
        Port (
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
  end component;

	begin
        Cont: MOD_N_COUNTER
            generic map (
                        N => 16
            )
            Port map(	
                        clk => clock,
                        reset => RST_tot,
                        enable => intermedio_WRITE,
                        counter => o_contatore
            );

		ROM0: ROM 
			Port map(	
                        CLK => clock,
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
                        CLK => clock,
                        address => o_contatore,
                        s_write => intermedio_WRITE,
                        out_val => y_tot,
                        inp_val => intermedio_M_MEM
                );
                
        Btn_read: ButtonDebouncer
            Generic map ( 
                CLK_period => 10,  -- Period of the board's clock in 10ns
                btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
            )
            Port map (
                RST => rst_tot,
                CLK => clock,
                BTN => b_read,
                CLEARED_BTN => bottone_read
            );    

        Btn_wirte: ButtonDebouncer
            Generic map ( 
                CLK_period => 10,  -- Period of the board's clock in 10ns
                btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
            )
            Port map (
                RST => rst_tot,
                CLK => clock,
                BTN => b_write,
                CLEARED_BTN => bottone_write
            );


    f_stato_uscita: process(clock)
    begin
        if (RST_tot = '1') then
            stato_prossimo <= PAUSA;
        else
            
            case stato_attuale is 
            when PAUSA =>
                if (i = '0') then
                    stato_prossimo <= PAUSA;
                    temp_READ <= '0';
                    temp_WRITE <= '0';
                else       
                    if bottone_read = '1' then
                        stato_prossimo <= READING;
                        temp_READ <= '1';
                        temp_WRITE <= '0';
                    elsif bottone_write = '1' then
                        stato_prossimo <= WRITING;
                        temp_READ <= '0';
                        temp_WRITE <= '1';
                    end if;
                end if;

            when READING =>
                if (i = '0') then
                    stato_prossimo <= PAUSA;
                    temp_READ <= '0';
                    temp_WRITE <= '0';
                else             
                    if bottone_read = '1' then
                        stato_prossimo <= READING;
                        temp_READ <= '1';
                        temp_WRITE <= '0';
                    elsif bottone_write = '1' then
                        stato_prossimo <= WRITING;
                        temp_READ <= '0';
                        temp_WRITE <= '1';
                    end if;
                end if;

            when WRITING =>
                if (i = '0') then
                    stato_prossimo <= READING;
                    temp_READ <= '0';
                    temp_WRITE <= '0';
                else
                    if bottone_read = '1' then
                        stato_prossimo <= READING;
                        temp_READ <= '1';
                        temp_WRITE <= '0';
                    elsif bottone_write = '1' then
                        stato_prossimo <= WRITING;
                        temp_READ <= '0';
                        temp_WRITE <= '1';
                    end if;
                end if;
            end case;
        end if;
    end process;

    cambio_stato: process (clock)
    begin
        if (rising_edge(clock)) then
            stato_attuale <= stato_prossimo;
            intermedio_READ <= temp_READ;
            intermedio_WRITE <= temp_WRITE;
        end if;
    end process;
end CONTROL_UNITArch;
