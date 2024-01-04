library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM is
    port(
    CLK : in std_logic;
    s_write : in std_logic;
    address : in std_logic_vector (2 downto 0);
    out_val : out std_logic_vector(7 downto 0);
    inp_val : in std_logic_vector(7 downto 0)
    );
end entity MEM;

architecture MemArch of MEM is
    signal ultimo_indirizzo_scritto : std_logic_vector(2 downto 0) := "000";
    type MEMORY_N_4 is array (0 to 7) of std_logic_vector(7 downto 0);
    signal MEMO : MEMORY_N_4 := (
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000",
        "00000000"
        );
    begin
        process (CLK,s_write)
            begin
                if (rising_edge(CLK) and s_write = '1') then
                    MEMO(to_integer(unsigned(address))) <= inp_val;
                    ultimo_indirizzo_scritto <= address;
                end if;
                out_val <= MEMO(to_integer(unsigned(address)));     

            end process;

end MemArch;
