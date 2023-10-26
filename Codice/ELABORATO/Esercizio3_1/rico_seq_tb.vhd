
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity rico_seq_tb is
end;

architecture bench of rico_seq_tb is

  component rico_seq
      port
      (
          i : in std_logic;
          m : in std_logic;
          a : in std_logic;
          o : out std_logic
      );
  end component;

  signal input: std_logic := 'U';
  signal mode: std_logic := 'U';
  signal abilitazione: std_logic;
  signal output: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: rico_seq port map ( i => input,
                           m => mode,
                           a => abilitazione,
                           o => output );

  stimulus: process
  begin
  
    wait for 100 ns;
    mode <= '1'; --Cambiare per: Non sovrapposte (0) | Parzialmente sovrapposte (1)
    input <= '0';
   
    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';
    
    --CAMBIO M = 0
    wait for 10 ns;
    input <= '0';

    wait for 100 ns;
    mode <= '0'; --Cambiare per: Non sovrapposte (0) | Parzialmente sovrapposte (1)
    input <= '0';
   
    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '1';

    wait for 10 ns;
    input <= '0';

    wait for 10 ns;
    input <= '1';

    stop_the_clock <= true;
    wait;
  end process;


  clocking: process
  begin
    while not stop_the_clock loop
      abilitazione <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;