library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    port(
        CLK : in std_logic;
        RST : in std_logic;
        y_s_r   : in std_logic;
        i_s_r   : in std_logic;
        o_s_r   : out std_logic
        );
end shift_register;

architecture shift_registerArch of shift_register is
    signal tmp: std_logic_vector(3 downto 0);
begin

    process (CLK)
    begin
        if (CLK'event and CLK='1') then
            if (RST='1') then
                tmp <= (others=>'0');
            else
                tmp(0) <= i_s_r; 
                tmp(1) <= tmp(0);
                tmp(2) <= tmp(1);
                tmp(3) <= tmp(2);    
            end if;
            
        end if;

    end process;
    o_s_r <= tmp(3);
    

end shift_registerArch;

				
				
