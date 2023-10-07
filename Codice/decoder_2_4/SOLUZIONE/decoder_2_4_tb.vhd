-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;


entity decoder_2_4_tb is
end;

architecture bench of decoder_2_4_tb is

  component decoder_2_4
  	port( 	a 	: in STD_LOGIC_VECTOR(1 downto 0);
  			y 	: out STD_LOGIC_VECTOR(3 downto 0)
  	);
  end component;

  signal a: STD_LOGIC_VECTOR(1 downto 0);
  signal y: STD_LOGIC_VECTOR(3 downto 0);
  
begin

  uut: decoder_2_4 port map ( a => a,
                          y=> y
						  );

  stimulus: process
  begin
  
    wait for 100 ns;
    
    wait for 10 ns;
    
    a<="00";
    
    wait for 10 ns;
    
    a<="01";
    
    wait for 10 ns;
    
    a<="10";

     wait for 10 ns;
    
    a<="11";
    
	wait for 20 ns;
	 a<="00";
    
	
    wait;
  end process;


end;