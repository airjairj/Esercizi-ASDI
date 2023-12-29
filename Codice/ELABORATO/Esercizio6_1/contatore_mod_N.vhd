library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MOD_N_COUNTER is
    Generic (N : integer := 16);  -- Imposta il valore di N come desideri
    Port (
        clk           : in std_logic;      -- clock input
        reset         : in std_logic;      -- reset input
        enable        : in std_logic;      -- start
        counter       : out std_logic_vector (3 downto 0)
    );
end MOD_N_COUNTER;

architecture Behavioral of MOD_N_COUNTER is
    signal counter_up : integer := 0;
begin
    process(clk,enable,reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                counter_up <= 0;
            else
               if enable = '1' then
                   if counter_up = N - 1 then
                       counter_up <= 0;
                   else
                       counter_up <= counter_up + 1;
                   end if;
               end if;
            end if;
        end if;
    end process;

    counter <= std_logic_vector(to_unsigned(counter_up, counter'length));
end Behavioral;
