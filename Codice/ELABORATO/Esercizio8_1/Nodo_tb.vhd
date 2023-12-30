library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Nodo_tb is
end;

architecture bench of Nodo_tb is

  component Nodo
      port
      (
          input_msg : in STD_LOGIC_VECTOR (0 to 3);
          output_msg : out STD_LOGIC_VECTOR (0 to 3);
          tipo_nodo : in std_logic;
          avanza_stato : in std_logic;
          clk_nodo : in std_logic;
          rst_nodo : in STD_LOGIC
      );
  end component;

  signal input_msg: STD_LOGIC_VECTOR (0 to 3);
  signal output_msg: STD_LOGIC_VECTOR (0 to 3);
  signal tipo_nodo: std_logic;
  signal avanza_stato: std_logic;
  signal clk_nodo: std_logic;
  signal rst_nodo: STD_LOGIC ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Nodo port map ( input_msg    => input_msg,
                       output_msg   => output_msg,
                       tipo_nodo    => tipo_nodo,
                       avanza_stato => avanza_stato,
                       clk_nodo     => clk_nodo,
                       rst_nodo     => rst_nodo );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk_nodo <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;