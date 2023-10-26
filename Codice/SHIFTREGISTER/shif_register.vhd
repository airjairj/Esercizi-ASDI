library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    port(CLK, RST, SI : in std_logic;
         SO : out std_logic);
end shift_register;

architecture archi of shift_register is
    signal tmp: std_logic_vector(3 downto 0);
begin

    process (CLK)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                tmp <= (others=>'0');
            else
                --questi segnali vengono aggiornati con i valori che avevano alla fine della 
                -- precedente attivazione
                tmp(0) <= SI; 
                tmp(1) <= tmp(0);
                tmp(2) <= tmp(1);
                tmp(3) <= tmp(2);
                                
                -- SO <= tmp(3);--se inserisco qui questa istruzione invece che fuori dal process,
                                --l'uscita SO non viene aggiornata contestualmente a tmp(3) 
                                --ci vorrà un altro fronte del clock per vedere SO e quindi, per conservare
                                --il valore di tmp(3) fino al prossimo clock, verrà inserito un altro flip-flop
                                --tra tmp(3) e SO      
            end if;
            
        end if;
        --SO <= tmp(3); --se inserisco qui questa istruzione, il valore di SO è aggiornato alla prossima
                        --attivazione del process, quindi sul fronte di discesa successivo a quando è stato
                        --aggiornato tmp(3)
    end process;
    SO <= tmp(3);   --se inserisco qui questa istruzione, il valore di SO viene aggiornato continuamente
                    --in maniera concorrente
    

end archi;

				
				
