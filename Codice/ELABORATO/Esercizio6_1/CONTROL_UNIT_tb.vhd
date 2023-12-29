library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CONTROL_UNIT_tb is
end;

architecture bench of CONTROL_UNIT_tb is

  component CONTROL_UNIT
      port
      (
          i : in std_logic;
          a : in std_logic;
          RST_tot : in STD_LOGIC;
          y_tot : out STD_LOGIC_VECTOR (0 to 3)
      );
  end component;

  signal i: std_logic;
  signal a: std_logic;
  signal RST: STD_LOGIC;
  signal y_tot: STD_LOGIC_VECTOR (0 to 3) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: CONTROL_UNIT port map ( i       => i,
                               a       => a,
                               RST_tot => RST,
                               y_tot   => y_tot );

  stimulus: process
        begin
          wait for 10 ns;
          RST <= '1';
          i <= '0';
          wait for 100 ns;
          RST <= '0';
          i <= '1';

          wait for 100 ns;
          wait for 100 ns;
          wait for 100 ns;
          wait for 100 ns;
      
          RST <= '1';
          stop_the_clock <= true;
          wait;
        end process;

  clocking: process
  begin
    while not stop_the_clock loop
      a <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;