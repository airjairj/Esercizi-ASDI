library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.Std_Logic_Arith.ALL;

entity MOD_N_COUNTER is
    Generic (N : integer := 0);  -- Imposta il valore di N come desideri
    Port (
        clk : in std_logic;         -- clock input
        reset : in std_logic;       -- reset input
        enable : in std_logic;
        counter : out integer;
        outp : out std_logic;
        val_iniziale : in std_logic_vector(5 downto 0) := (others => '0');
        btn_iniziale : in std_logic
    );
end MOD_N_COUNTER;



architecture Behavioral of MOD_N_COUNTER is
    signal counter_up : integer := 0;
    signal o_temp : std_logic := '0';
begin
    process(clk,reset)
    begin
        if btn_iniziale = '1' then
            counter_up <=  conv_integer(unsigned(val_iniziale));
        elsif rising_edge(clk) and enable = '1' then
                if counter_up > N-1 then
                    counter_up <= N-1;
                elsif counter_up = N - 1 then
                    counter_up <= 0;
                    o_temp <= '1';
                else
                    counter_up <= counter_up + 1;
                    o_temp <= '0';
                end if;
            end if;
    end process;


    counter <= counter_up;
    outp <= o_temp;
end Behavioral;
