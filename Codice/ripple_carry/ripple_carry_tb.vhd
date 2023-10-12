library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ripple_carry_tb is
end ripple_carry_tb;

architecture ripple_carry_tbArch of ripple_carry_tb is

    component ripple_carry is
        port(	
                a_r_p : in STD_LOGIC_VECTOR (3 downto 0);
                b_r_p : in STD_LOGIC_VECTOR (3 downto 0);
                c_r_p : in STD_LOGIC;
                s_r_p : out STD_LOGIC_VECTOR (3 downto 0);
			    r_r_p : out STD_LOGIC
        );		
    end component;

    signal input1   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal input2   : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal carry1   : STD_LOGIC := '0';
    signal overflow : STD_LOGIC := '0';
    signal output   : STD_LOGIC_VECTOR (3 downto 0) := "UUUU";

begin

    utt: ripple_carry port map (
        a_r_p => input1,
        b_r_p => input2,
        c_r_p => carry1,
        s_r_p => output,
        r_r_p => overflow
    );

    stim_proc: process begin
        wait for 100 ns;
--                   +--- 
        input1    <= "1111";
        input2    <= "1111";
        wait for 10 ns;


        assert output = "0000"
            report "errore NON TI TROVI"
            severity failure;

        wait;
    end process;

end ripple_carry_tbArch;
