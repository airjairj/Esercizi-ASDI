library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port(
        CLK : in STD_LOGIC;
        s_read : in std_logic;
        address : in std_logic_vector (2 downto 0);
        out_rom : out std_logic_vector(7 downto 0)
    );
end entity ROM;

architecture RomArch of ROM is
    signal ind : integer := 0;
    type MEMORY_N_4 is array (0 to 7) of std_logic_vector(7 downto 0);
        constant ROM_N_4 : MEMORY_N_4 := (
        "00001000",
        "00001001",
        "00001010",
        "00001011",
        "00001100",
        "00001101",
        "00001110",
        "00001111"
        );

    begin
        ind <= to_integer(unsigned(address));
        process (CLK,s_read)
    begin
        if (rising_edge(CLK) and s_read = '1') then
            out_rom <= ROM_N_4(ind);
        end if;
    end process;
end RomArch;
