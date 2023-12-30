library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sis_tot is
    Port (
        avanza_a : in STD_LOGIC;
        avanza_b : in STD_LOGIC;
        Reset : in STD_LOGIC;
        Clock : in STD_LOGIC
    );
end sis_tot;

architecture sis_totArch of sis_tot is
    signal temp1 : std_logic_vector(3 downto 0);
    signal temp2 : std_logic_vector(3 downto 0);

    component Nodo
        port
        (
            input_msg : in STD_LOGIC_VECTOR (3 downto 0);
            output_msg : out STD_LOGIC_VECTOR (3 downto 0);
            tipo_nodo : in std_logic;
            avanza_stato : in std_logic;
            clk_nodo : in std_logic;
            rst_nodo : in STD_LOGIC
        );
  end component;

begin
    nodo_a: Nodo
    port map
    (
        input_msg => temp1,
        output_msg  => temp2,
        tipo_nodo => '0',
        avanza_stato => avanza_a,
        clk_nodo => Clock,
        rst_nodo => Reset
    );

    nodo_b: Nodo
    port map
    (
        input_msg => temp2,
        output_msg  => temp1,
        tipo_nodo => '1',
        avanza_stato => avanza_b,
        clk_nodo => Clock,
        rst_nodo => Reset
    );




end sis_totArch;
