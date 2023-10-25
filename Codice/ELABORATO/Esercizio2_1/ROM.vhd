library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port(
    address : in std_logic_vector(3 downto 0);
    out_rom : out std_logic_vector(7 downto 0)
    );
end entity ROM;

architecture RomArch of ROM is
    type MEMORY_16_4 is array (0 to 15) of std_logic_vector(7 downto 0);
        constant ROM_16_4 : MEMORY_16_4 := (
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
		out_rom <= ROM_16_4(to_integer(unsigned(address)));
end RomArch;
