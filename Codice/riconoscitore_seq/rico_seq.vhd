library ieee;
use ieee.std_logic_1164.all;

-- 101 parzialmente sovrapposto

entity rico_seq is
    port
    (
            i : in std_logic;
            CLK : in std_logic;
            o : out std_logic
    );

end rico_seq;

architecture rico_seqArch of rico_seq is

    type stato is (S0, S1, S2);
    signal stato_attuale : stato := S0;
    signal stato_prossimo : stato;
    begin
    f_stato_uscita: process(stato_attuale,i)
    begin
        case stato_attuale is 
            when S0 =>
                if(i='0') then 
                    stato_prossimo <= S0;
                    o <= '0';
                else
                    stato_prossimo <= S1;
                    o <= '0';
                end if;
            when S1 =>
                if(i='0') then 
                    stato_prossimo <= S2;
                    o <= '0';
                else 
                    stato_prossimo <= S1;
                    o <= '0';
                end if;
            when S2 =>
                if(i='0') then 
                    stato_prossimo <= S0;
                    o <= '0';
                else 
                    stato_prossimo <= S0;
                    o <= '1';
                end if;
            when others =>
                stato_prossimo <= S0;
                o <= '0';
        end case;
    end process;

    mem: process (CLK)
        begin
            if (rising_edge(CLK) and CLK = '1') then
                stato_attuale <= stato_prossimo;
            end if;
        end process;
end rico_seqArch;