library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
    generic (
        N: integer := 8  -- Imposta la larghezza predefinita del registro a 8 bit
    );
    port (
        CLK, RST, SI: in std_logic;
        SO: out std_logic;
        Y: in integer range 1 to 2  -- Numero di posizioni da shiftare (1 o 2)
    );
end shift_register;

architecture shift_registerArch of shift_register is
    signal tmp: std_logic_vector(N - 1 downto 0);
begin
    process (CLK)
    begin
        if (rising_edge(CLK)) then
            if (RST = '1') then
                tmp <= (others => '0');
            else
                -- Shift a destra di Y posizioni
                for k in 1 to Y loop
                    tmp(0) <= SI;
                    for i in 1 to (N - 1) loop
                        tmp(i) <= tmp(i - 1);
                    end loop;
                end loop;
            end if;
        end if;
    end process;
    
    SO <= tmp(N - 1);  -- Uscita collegata all'ultimo bit del registro
end shift_registerArch;