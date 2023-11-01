library ieee;
use ieee.std_logic_1164.all;

entity rico_seq is
    port
    (
        i_rico : in std_logic;
        m_rico : in std_logic; -- m_rico = 0 -> ingresso a_rico gruppi di 3 (non sovrapposte), m_rico = 1 -> ingresso singolo bit (parzialmente sovrapposte)
        a_rico : in std_logic;
        b_i_rico : in std_logic;
        b_m_rico : in std_logic;
        o_rico : out std_logic
    );
end rico_seq;

architecture rico_seqArch of rico_seq is
    type stato is (S0, S1, S2, S3, S4); 
    signal stato_attuale : stato := S0;
    signal stato_prossimo : stato;
    signal o_temp : std_logic := '0';
    signal m_temp : std_logic := '0';
begin
    f_stato_uscita: process(stato_attuale)
    begin
        case stato_attuale is 
            when S0 =>
                if m_temp = '0' then -- NON SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S3;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S1;
                        o_temp <= '0';
                    end if;
                elsif m_temp = '1' then -- m_temp = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S1;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';
                end if;

            when S1 =>
                if m_temp = '0' then -- NON SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S2;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    end if;
                elsif m_temp = '1' then -- m_temp = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S2;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S1;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';
                end if;

            when S2 =>
                if m_temp = '0' then -- NON SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S0;
                        o_temp <= '1';
                    end if;
                elsif m_temp = '1' then -- m_temp = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S0;
                        o_temp <= '1';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';
                end if;

            when S3 =>
                if m_temp = '0' then -- NON SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    end if;
                elsif m_temp = '1' then -- m_temp = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';                    
                end if;

            when S4 =>
                if m_temp = '0' then -- NON SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    end if;
                elsif m_temp = '1' then -- m_temp = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i_rico = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i_rico = 1
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';                    
                end if;
        end case;
    end process;

    mem: process (a_rico)
    begin
        if (rising_edge(a_rico)) then
            if b_i_rico = '1' then
                stato_attuale <= stato_prossimo;
                o_rico <= o_temp;
            end if;
            if b_m_rico = '1' then
                m_temp <= m_rico;
            end if;
        end if;
    end process;
end rico_seqArch;
