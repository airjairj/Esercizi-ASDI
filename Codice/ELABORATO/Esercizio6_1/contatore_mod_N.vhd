library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MOD_N_COUNTER is
    Generic (N : integer := 0);  -- Imposta il valore di N come desideri
    Port (
        clk : in std_logic;         -- clock input
        reset : in std_logic;       -- reset input
        enable : in std_logic;
        counter : out integer
    );
end MOD_N_COUNTER;

architecture Behavioral of MOD_N_COUNTER is
    signal counter_up : integer := 0;
begin
    process(clk,enable)
    begin
        if reset = '1' then
            counter_up <= 0;
        end if;
        if (rising_edge(clk) and enable = '1') then
            if reset = '1' then
                counter_up <= 0;
            else
                if counter_up = N - 1 then
                    counter_up <= 0;
                else
                    counter_up <= counter_up + 1;
                end if;
            end if;
        end if;
    end process;

    counter <= counter_up;
end Behavioral;
