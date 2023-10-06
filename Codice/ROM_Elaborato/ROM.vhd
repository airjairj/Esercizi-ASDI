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
        x"00",
        x"01",
        x"02",
        x"03",
        x"04",
        x"05",
        x"06",
        x"07",
        x"08",
        x"09",
        x"0a",
        x"0b",
        x"0c",
        x"0d",
        x"0e",
        x"0f"
        );

    begin
		out_rom <= ROM_16_4(to_integer(unsigned(address)));
end RomArch;
