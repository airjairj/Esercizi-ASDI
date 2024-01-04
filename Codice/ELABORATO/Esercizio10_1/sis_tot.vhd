--IMPORTANTE: FATE run 100us NELLA "Tcl Console" (in basso) PER VEDERE QUALCOSA IN SIMULAZIONE

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sis_tot is
    Port (
        start_tot : in STD_LOGIC;
        rst_tot : in STD_LOGIC;
        clk_tot : in STD_LOGIC
    );
end sis_tot;

architecture sis_totArch of sis_tot is
    signal txd_rxd : std_logic;
    signal CTS : std_logic;
    signal RTS : std_logic;
    signal stop : std_logic := '0';

    component Unita_a
        Port (     
            start : in STD_LOGIC;   
            rst_nodo : in STD_LOGIC;
            clk_nodo : in STD_LOGIC;
            txd_nodo : out STD_LOGIC;
            stop_read : out std_logic := '0';
            canale_invio_richieste : out STD_LOGIC  := '0';
            canale_lettura_risposte : in STD_LOGIC := '0'
        );
    end component;
    component Unita_b
        Port (        
            rst_nodo : in STD_LOGIC;
            clk_nodo : in STD_LOGIC;
            rxd_nodo : in STD_LOGIC;
            stop_read : in std_logic := '0';
            canale_invio_richieste : in STD_LOGIC  := '0';
            canale_lettura_risposte : out STD_LOGIC := '0'
        );
    end component;

begin
    nodo_a: Unita_a
    port map
    (
        start => start_tot,
        rst_nodo => rst_tot,
        clk_nodo => clk_tot,
        txd_nodo => txd_rxd,
        stop_read => stop,
        canale_invio_richieste => RTS,
        canale_lettura_risposte => CTS
    );

    nodo_b: Unita_b
    port map
    (
        rst_nodo => rst_tot,
        clk_nodo => clk_tot,
        rxd_nodo => txd_rxd,
        stop_read => stop,
        canale_invio_richieste => RTS,
        canale_lettura_risposte => CTS
    );

    aggiorna_val: process (clk_tot)
		begin
	end process;
end sis_totArch;
