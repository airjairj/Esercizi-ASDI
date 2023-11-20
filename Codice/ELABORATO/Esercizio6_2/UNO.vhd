library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.Std_Logic_Arith.ALL;

entity UNO is
    Port (
        start : in std_logic;
        clk : in std_logic;
        rst : in std_logic;
        read_o_write : out std_logic
    );
end UNO;

architecture UNOArch of UNO is
    signal r_w : std_logic := '0';
begin

    process (clk,rst)
    begin
        if rst = '1' then
            r_w <= '0';
            read_o_write <= '0';
        end if;
        if rising_edge(clk) and start = '1' then
            if r_w = '0' then
                r_w <= '1';
            else 
                r_w <= '0';
            end if;
        end if;
        read_o_write <= r_w;

    end process;

end UNOArch;
