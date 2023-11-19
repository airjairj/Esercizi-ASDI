library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MEM is
    port(
    CLK : in std_logic;
    s_write : in std_logic;
    s_read : in std_logic;
    indirizzo: in std_logic_vector(3 downto 0);
    out_val : out std_logic_vector(31 downto 0);
    out_lucine : out std_logic_vector(7 downto 0);
    intertempi : in std_logic_vector(31 downto 0)
    );
end entity MEM;

architecture MemArch of MEM is
    type MEMORY_N_4 is array (0 to 7) of std_logic_vector(31 downto 0);
    signal MEMO : MEMORY_N_4;
    signal address : integer;

    begin
    
    address <= to_integer(unsigned(indirizzo));
        process (CLK)
            begin
                if (rising_edge(CLK) and s_write = '1') then
                    MEMO(address) <= intertempi;
                end if;

            case indirizzo is
                when "0000" => out_lucine <= "00000001";
                when "0001" => out_lucine <= "00000010";
                when "0010" => out_lucine <= "00000100";
                when "0011" => out_lucine <= "00001000";
                when "0100" => out_lucine <= "00010000";
                when "0101" => out_lucine <= "00100000";
                when "0110" => out_lucine <= "01000000";            
                when "0111" => out_lucine <= "10000000";  
                when others => out_lucine <= "00000000";          
            end case;
            
            out_val <= MEMO(address);


            end process;

end MemArch;
