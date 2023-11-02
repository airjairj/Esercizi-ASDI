library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port(
        CLK : in STD_LOGIC;
        s_read : in std_logic;
        address : in integer;
        out_rom : out std_logic_vector(7 downto 0)
    );
end entity ROM;

architecture RomArch of ROM is
    type MEMORY_N_4 is array (0 to 15) of std_logic_vector(7 downto 0);
        constant ROM_N_4 : MEMORY_N_4 := (
        x"11",
        x"12",
        x"14",
        x"18",
        x"21",
        x"22",
        x"24",
        x"28",
        x"41",
        x"42",
        x"44",
        x"48",
        x"81",
        x"82",
        x"84",
        x"88"
        );

    begin
        process (CLK,s_read)
    begin
        if (rising_edge(CLK) and s_read = '1') then
            out_rom <= ROM_N_4(address);
        end if;
    end process;
end RomArch;
