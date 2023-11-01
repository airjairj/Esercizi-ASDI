library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;



entity ROM is
port(
    
    RST : in std_logic;
    ADDR : in std_logic_vector(2 downto 0); --3 bit di indirizzo per accedere agli elementi della ROM,
                                            --sono inseriti tramite gli switch
    DATA : out std_logic_vector(31 downto 0) -- dato su 32 bit letto dalla ROM
    );
end ROM;
-- creo una ROM di 8 elementi da 32 bit ciascuno
architecture behavioral of ROM is 
type rom_type is array (0 to 7) of std_logic_vector(31 downto 0);
signal ROM : rom_type := (
X"AAAAAAAA", 
X"BBBBBBBB", 
X"CCCCCCCC", 
X"DDDDDDDD", 
X"12345678",
X"87654321",
X"00112233", 
X"44556677");

attribute rom_style : string;
attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT
begin

process(ADDR)
  begin
    if (RST = '1') then
       DATA <= ROM(conv_integer("000"));
    else
        DATA <= ROM(conv_integer(ADDR));
    end if;
    
end process;
end behavioral;