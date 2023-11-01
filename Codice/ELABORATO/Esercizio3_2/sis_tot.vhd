library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity sis_tot is
    Port (    
        a_tot : in STD_LOGIC;
        o_tot : out STD_LOGIC;
        i_tot : in STD_LOGIC;
        m_tot : in STD_LOGIC;
        b1_tot : in STD_LOGIC;
        b2_tot : in STD_LOGIC
    );
end sis_tot;

architecture sis_totArch of sis_tot is
    signal b1_temp : STD_LOGIC;
    signal b2_temp : STD_LOGIC;

    component rico_seq
        Port (    
            i_rico : in std_logic;
            m_rico : in std_logic;
            a_rico : in std_logic;
            b_i_rico : in std_logic;
            b_m_rico : in std_logic;
            o_rico : out std_logic
        );
    end component;

    component ButtonDebouncer
        Generic (                       
            CLK_period: integer := 10; -- Period of the board's clock in nanoseconds
            btn_noise_time: integer := 10000000 -- Estimated button bounce duration in nanoseconds
        );
        Port (
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
    end component;

begin
    rico: rico_seq
        Port map (    
            i_rico => i_tot,
            o_rico => o_tot,
            a_rico => a_tot,
            b_i_rico => b1_temp,
            b_m_rico => b2_temp,
            m_rico => m_tot
        );

    de_B1: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => a_tot,
            BTN => b1_tot,
            CLEARED_BTN => b1_temp
        );

    de_B2: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        Port map (
            RST => '0',
            CLK => a_tot,
            BTN => b2_tot,
            CLEARED_BTN => b2_temp
        );

end sis_totArch;
