library ieee;
use ieee.std_logic_1164.all;

entity cont_mod_N is
    generic (
        N: integer := 16
    );
    port
    (
        a      : in std_logic;
        reset  : in std_logic;
        enable : in std_logic;
        o      : out integer  -- o codificato su 4 bit
    );
end cont_mod_N;

architecture cont_mod_NArch of cont_mod_N is
begin
    process (a, reset, enable)
    variable contatore : integer range 0 to N-1 := 0;
    begin
        if reset = '1' then
            contatore := 0;
        elsif rising_edge(a) and enable = '1' then
            if contatore = N-1 then
                contatore := 0;
            else
                contatore := contatore + 1;
            end if;
        end if;
        o <= contatore;
    end process;

     -- Converti l'integer in std_logic_vector a 4 bit
end cont_mod_NArch;
