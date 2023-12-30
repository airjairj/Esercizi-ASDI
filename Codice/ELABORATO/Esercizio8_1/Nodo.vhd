-- QUESTA Ã¨ LA CONTROL UNIT
library ieee;
use ieee.std_logic_1164.all;

entity Nodo is
    port
    (
        input_msg : in STD_LOGIC_VECTOR (3 downto 0);
        output_msg : out STD_LOGIC_VECTOR (3 downto 0);
        tipo_nodo : in std_logic;
        avanza_stato : in std_logic;
        clk_nodo : in std_logic;
        rst_nodo : in STD_LOGIC
    );
end Nodo;

architecture NodoArch of Nodo is
    signal o_contatore: STD_LOGIC_VECTOR (3 downto 0);
    
    type stato is (PAUSA, READING, WRITING, WAITING_ACK, WAITING_DATA, PREPARING_MSG, PREPARING_ACK, READY, WAITING_END, PREPARING_END); 
    signal stato_attuale : stato := PAUSA;
    signal stato_prossimo : stato;
    signal o_temp : std_logic_vector(3 downto 0) := "0000";
    signal registro_temp1 : std_logic_vector(3 downto 0) := "0000";
    signal registro_temp2 : std_logic_vector(3 downto 0) := "0000";
    signal enable_sommatore : std_logic := '0';
    signal enable_contatore : std_logic := '0';
    signal o_sommatore : std_logic_vector(3 downto 0) := "0000";
    signal risultato_da_scrivere : std_logic_vector(3 downto 0) := "0000";
    signal enable_write : std_logic := '0';
    signal c_out_adder : std_logic;

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

    component ripple_carry is
	port(	a_r_p : in STD_LOGIC_VECTOR (3 downto 0);
			b_r_p : in STD_LOGIC_VECTOR (3 downto 0);
			c_r_p : in STD_LOGIC;
			s_r_p : out STD_LOGIC_VECTOR (3 downto 0);
			r_r_p : out STD_LOGIC
			);	
    end component;
    

	begin
        Cont: MOD_N_COUNTER
            generic map (
                        N => 16
            )
            Port map(	
                        clk => clk_nodo,
                        reset => rst_nodo,
                        enable => enable_contatore,
                        counter => o_contatore
            );

        MEM0: MEM
            Port map(	
                        CLK => clk_nodo,
                        address => o_contatore,
                        s_write => enable_write,
                        out_val => o_temp,
                        inp_val => risultato_da_scrivere
                );

        SOMMATORE: ripple_carry
            port map(
                        a_r_p => registro_temp1,
                        b_r_p  => registro_temp2,
                        c_r_p => '0',
                        r_r_p => c_out_adder,
                        s_r_p => o_sommatore
                );
  
    f_stato_uscita: process(clk_nodo)
    begin
        if (rst_nodo = '1') then
            stato_prossimo <= PAUSA;
        else
            if tipo_nodo = '0' then -- NODO A
                            
                case stato_attuale is 
                    
                when PAUSA => --AVANZA CON INPUT DALL ESTERNO
                if (avanza_stato = '0') then
                    stato_prossimo <= PAUSA;
                else -- avanza_stato = 1
                    stato_prossimo <= READY;
                end if;

                when READY => --AVANZA CON INPUT DALL ESTERNO
                if (avanza_stato = '0') then
                    stato_prossimo <= READY;
                else -- avanza_stato = 1
                    stato_prossimo <= PREPARING_MSG;
                end if;

                when PREPARING_MSG =>
                if (avanza_stato = '0') then
                    output_msg <= "1110"; -- RICHIESTA = 1110, ACK = 1101, END = 1100
                    stato_prossimo <= WAITING_ACK;
                else -- avanza_stato = 1
                    stato_prossimo <= WAITING_ACK;
                end if;

                when WAITING_ACK =>
                if (avanza_stato = '0') then
                    stato_prossimo <= WAITING_ACK;

                    if(input_msg = "1101") then -- ACK = 1101
                        stato_prossimo <= READING;
                    end if;                    
                else -- avanza_stato = 1
                    stato_prossimo <= READING;
                end if;

                when READING =>
                if (avanza_stato = '0') then
                    output_msg <= o_temp;
                    enable_contatore <= '1';
                    stato_prossimo <= WAITING_END;
                else -- avanza_stato = 1
                    stato_prossimo <= WAITING_END;
                end if;

                when WAITING_END =>
                if (avanza_stato = '0') then
                    stato_prossimo <= WAITING_END;
                    enable_contatore <= '0';

                    if(input_msg = "1100") then -- END = 1100
                        stato_prossimo <= PREPARING_MSG;
                    end if; 

                else -- avanza_stato = 1
                    stato_prossimo <= PREPARING_MSG;
                end if;

                when others =>
                    stato_prossimo <= PAUSA;
                end case;

            else -- NODO B
                case stato_attuale is 
                        
                when PAUSA => --AVANZA CON INPUT DALL ESTERNO
                if (avanza_stato = '0') then
                    stato_prossimo <= PAUSA;
                else -- avanza_stato = 1
                    stato_prossimo <= READY;
                end if;

                when READY =>
                if (avanza_stato = '0') then
                    stato_prossimo <= READY;

                    if(input_msg = "1110") then -- RICHIESTA = 1110
                        stato_prossimo <= PREPARING_ACK;
                    end if;  

                else -- avanza_stato = 1
                    stato_prossimo <= PREPARING_ACK;
                end if;

                when PREPARING_ACK =>
                if (avanza_stato = '0') then
                    output_msg <= "1101"; -- RICHIESTA = 1110, ACK = 1101, END = 1100
                    stato_prossimo <= WAITING_DATA;
                else -- avanza_stato = 1
                    stato_prossimo <= WAITING_DATA;
                end if;

                when WAITING_DATA =>
                if (avanza_stato = '0') then
                    if input_msg /= "1110" and input_msg /= "1101" and input_msg /= "1100" then -- RICHIESTA = 1110, ACK = 1101, END = 1100
                        stato_prossimo <= READING;
                    else
                        stato_prossimo <= WAITING_DATA;
                    end if;
                else -- avanza_stato = 1
                    stato_prossimo <= READING;
                end if;

                when READING =>
                if (avanza_stato = '0') then
                    registro_temp1 <= input_msg;
                    registro_temp2 <= o_temp;
                    enable_sommatore <= '1';
                    stato_prossimo <= WRITING;
                else -- avanza_stato = 1
                    stato_prossimo <= WRITING;
                end if;

                when WRITING =>
                if (avanza_stato = '0') then
                    stato_prossimo <= PREPARING_END;
                    risultato_da_scrivere <= o_sommatore;
                    enable_write <= '1';
                    enable_contatore <= '1';
                else -- avanza_stato = 1
                    stato_prossimo <= PREPARING_END;
                end if;

                when PREPARING_END =>
                if (avanza_stato = '0') then
                    enable_contatore <= '0';
                    enable_write <= '0';
                    output_msg <= "1100"; -- END = 1100
                    stato_prossimo <= READY;
                else -- avanza_stato = 1
                    stato_prossimo <= READY;
                end if;

                when others =>
                    stato_prossimo <= PAUSA;
                end case;
            end if;

        end if;
    end process;

    cambio_stato: process (clk_nodo)
    begin
        if (rising_edge(clk_nodo) and clk_nodo = '1') then
            stato_attuale <= stato_prossimo;
        end if;
    end process;
end NodoArch;
