library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity shift_register_tb is
end;

architecture bench of shift_register_tb is

  component shift_register
      generic (
          N: integer := 8
      );
      port (
          CLK, RST, SI: in std_logic;
          SO: out std_logic;
          Y: in integer range 1 to 2
      );
  end component;

  signal CLK, RST, SI: std_logic;
  signal SO: std_logic;
  signal Y: integer range 1 to 2 ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

    begin

        -- Insert values for generic parameters !!
        uut: shift_register 
            generic map ( N   =>  4)
            port map ( CLK => CLK,
                       RST => RST,
                       SI  => SI,
                       SO  => SO,
                       Y   => Y );

      
        stimulus: process
        begin
        
          wait for 100 ns;
          Y <= 1; --Cambiare per: 1 bit shift (1) | 2 bit shift (2)
          SI <= '0';
         
          wait for 10 ns;
          SI <= '1';
          
          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';
          
          wait for 10 ns;
          SI <= '0';
          
          wait for 10 ns;
          SI <= '0';
          
          wait for 10 ns;
          SI <= '0';

          wait for 100 ns;
          Y <= 2; --Cambiare per: 1 bit shift (1) | 2 bit shift (2)
          SI <= '0';
         
          wait for 10 ns;
          SI <= '1';
          
          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '0';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '1';

          wait for 10 ns;
          SI <= '1';
          

        stop_the_clock <= true;
        wait;
    end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;