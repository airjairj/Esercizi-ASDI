library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity priorita is
    Port (
        input1, input2, input3, input4 : in STD_LOGIC;
        output : out STD_LOGIC_VECTOR(1 downto 0)
    );
end priorita;

architecture Dataflow of priorita is

begin
    -- Logica di selezione: il nodo con valore maggiore ha la massima priorit�
    
    output <= "11" when input4 = '1' else
              "10" when input3 = '1' else
              "01" when input2 = '1' else
              "00" when input1 = '1' else
              "--";

end Dataflow;


