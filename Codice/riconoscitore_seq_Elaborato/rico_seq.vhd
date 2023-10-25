library ieee;
use ieee.std_logic_1164.all;

entity rico_seq is
    port
    (
        i : in std_logic;
        m : in std_logic; -- m = 0 -> ingresso a gruppi di 3 (non sovrapposte), m = 1 -> ingresso singolo bit (parzialmente sovrapposte)
        a : in std_logic;
        o : out std_logic
    );
end rico_seq;

architecture rico_seqArch of rico_seq is
    type stato is (S0, S1, S2, S3, S4); 
    signal stato_attuale : stato := S0;
    signal stato_prossimo : stato;
    signal o_temp : std_logic;
begin
    f_stato_uscita: process(a)
    begin
        case stato_attuale is 
            when S0 =>
                if m = '0' then -- NON SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S3;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S1;
                        o_temp <= '0';
                    end if;
                elsif m = '1' then -- m = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S1;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';
                end if;

            when S1 =>
                if m = '0' then -- NON SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S2;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    end if;
                elsif m = '1' then -- m = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S2;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S1;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';
                end if;

            when S2 =>
                if m = '0' then -- NON SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S0;
                        o_temp <= '1';
                    end if;
                elsif m = '1' then -- m = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S0;
                        o_temp <= '1';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';
                end if;

            when S3 =>
                if m = '0' then -- NON SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    end if;
                elsif m = '1' then -- m = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S4;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';                    
                end if;

            when S4 =>
                if m = '0' then -- NON SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    end if;
                elsif m = '1' then -- m = 1 PARZIALMENTE SOVRAPPOSTE
                    if (i = '0') then
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    else -- i = 1
                        stato_prossimo <= S0;
                        o_temp <= '0';
                    end if;
                else
                    stato_prossimo <= S0;
                    o_temp <= '0';                    
                end if;
        end case;
    end process;

    mem: process (a)
    begin
        if (rising_edge(a) and a = '1') then
            stato_attuale <= stato_prossimo;
    	    o <= o_temp;
        end if;
    end process;
end rico_seqArch;
