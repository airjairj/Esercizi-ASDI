library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.Std_Logic_Arith.ALL;

-- Questa macchina si chiama B.O.H., perche non sapeco che nome dare
-- No, in realt√É  prende gli int dei contatori e li unisce e trasforma in std_logic_vector

entity BOH is
    Port (
        secondi : in integer;
        minuti : in integer;
        ore : in integer;
        outp : out std_logic_vector(31 downto 0);
        modalita_normale : in std_logic;
        valore_salvato : in std_logic_vector(31 downto 0)
    );
end BOH;

architecture BOHArch of BOH is
    signal secondi_u : integer;
    signal secondi_d : integer;
    signal minuti_u : integer;
    signal minuti_d : integer;
    signal ore_u : integer;
    signal ore_d : integer;

    signal secondi_tot : std_logic_vector(7 downto 0);
    signal minuti_tot : std_logic_vector(7 downto 0);
    signal ore_tot : std_logic_vector(7 downto 0);
    signal uscita_temp : std_logic_vector(31 downto 0);

begin
 
    secondi_u <= secondi mod 10;
    secondi_d <= secondi / 10;
    minuti_u <= minuti mod 10;
    minuti_d <= minuti / 10;
    ore_u <= ore mod 10;
    ore_d <= ore / 10;

    secondi_tot (3 downto 0) <= std_logic_vector(to_unsigned(secondi_u, 4));
    secondi_tot (7 downto 4) <= std_logic_vector(to_unsigned(secondi_d, 4));

    minuti_tot (3 downto 0) <= std_logic_vector(to_unsigned(minuti_u, 4));
    minuti_tot (7 downto 4) <= std_logic_vector(to_unsigned(minuti_d, 4));
    
    ore_tot (3 downto 0) <= std_logic_vector(to_unsigned(ore_u, 4));
    ore_tot (7 downto 4) <= std_logic_vector(to_unsigned(ore_d, 4));
    
    uscita_temp(11 downto 8) <= "1111";
    uscita_temp(23 downto 20) <= "1111";
    uscita_temp(7 downto 0) <= secondi_tot;
    uscita_temp(19 downto 12) <= minuti_tot;
    uscita_temp(31 downto 24) <= ore_tot;

    process (modalita_normale)
    begin
        if modalita_normale = '1' then
            outp <= valore_salvato;
        else
            outp <= uscita_temp;
        end if;
    end process;
    --outp <= uscita_temp; --Questo Ë il base
    --outp <= valore_salvato;
    
    --outp <= ((NOT modalita_normale) AND uscita_temp) OR (modalita_normale AND valore_salvato);

end BOHArch;
