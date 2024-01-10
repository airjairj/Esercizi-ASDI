-- QUESTO WRAPPA LA CONTROL UNIT
library ieee;
use ieee.std_logic_1164.all;

entity sis_tot is
    port
    (
        start : in std_logic;
        clk : in std_logic;
        rst : in STD_LOGIC;
        y : out STD_LOGIC_VECTOR (0 to 3);
        b_r: in STD_LOGIC;
        b_w: in STD_LOGIC
    );
end sis_tot;

architecture sis_totArch of sis_tot is
    
    component CONTROL_UNIT
        port
        (
            i : in std_logic;
            clock : in std_logic;
            RST_tot : in STD_LOGIC;
            y_tot : out STD_LOGIC_VECTOR (0 to 3);
            b_read: in STD_LOGIC;
            b_write: in STD_LOGIC
        );
    end component;

	begin
        prova: CONTROL_UNIT
            Port map(	
                i => start,
                clock => clk,
                RST_tot => rst,
                y_tot => y,
                b_read => b_r,
                b_write => b_w
            );
        
end sis_totArch;
