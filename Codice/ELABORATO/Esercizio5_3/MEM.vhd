library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM is
    port(
    CLK : in std_logic;
    s_write : in std_logic;
    address : in integer;
    out_val : out std_logic_vector(31 downto 0);
    out_lucine : out std_logic_vector(7 downto 0);
    intertempi : in std_logic_vector(31 downto 0)
    );
end entity MEM;

architecture MemArch of MEM is
    type MEMORY_N_4 is array (0 to 7) of std_logic_vector(31 downto 0);
    signal MEMO : MEMORY_N_4;
    signal address_to_lucine : std_logic_vector(7 downto 0);

    begin
        process (CLK)
                variable is_nonzero : boolean;
            begin
                if (rising_edge(CLK) and s_write = '1') then
                    MEMO(address) <= intertempi;
                end if;

            address_to_lucine <= std_logic_vector(to_unsigned(address, 8));
            out_lucine <= address_to_lucine;
            out_val <= MEMO(address);

            end process;

            out_val <= MEMO(address);    
end MemArch;
