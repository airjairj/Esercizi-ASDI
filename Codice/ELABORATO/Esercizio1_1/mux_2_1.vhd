library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ******************************************************************************* --
-- Definizione di un componente MUX 2:1 attraverso 
-- l'utilizzo di vari costrutti al livello di astrazione dataflow/behavioral
-- ******************************************************************************* --


-- Definizione dell'interfaccia del modulo mux_2_1.
entity mux_2_1 is

	port( 	a0 	: in STD_LOGIC;
			a1 	: in STD_LOGIC;
			s 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	);
		
end mux_2_1;


-- Quando si definiscono diverse architetture per la stessa entity,
-- di default viene sintetizzata l'ultima in ordine di definizione;
-- nel testbench è possibile specificare quale architettura si vuole simulare



-- Utilizzo del costrutto di conditional signal assignment.
-- qui è come se stessi specificando la tabella di verità della funzione y
architecture dataflow_v1 of mux_2_1 is
	
	begin
		y 	<= 	a0 when s = '0' else	
				a1 when s = '1' else
				'-'; --specifico cosa succede quando s non assume valore 0 o 1
				     -- perchè s è uno STD_LOGIC, non un BIT

end dataflow_v1;


-- Utilizzo del costrutto selected signal assignment.
-- qui i casi sono mutuamente esclusivi e viene valutata esclusivamente
-- la condizione di uguaglianza
architecture dataflow_v2 of mux_2_1 is
	
	begin
		with s select
			y 	<= 	a0 when '0',	
					a1 when '1',
					'-' when others;

end dataflow_v2;

---- Utilizzo del costrutto process.
architecture behavioral of mux_2_1 is
	
	begin
		process (s,a0,a1)
            begin
               case s is
                  when '0' => y <= a0;
                  when '1' => y <= a1;
                  when others => y <= '-';
               end case;
            end process;

end behavioral;

-- Utilizzo di statement di assegnazione concorrente.
architecture dataflow of mux_2_1 is

	begin
		y <= ((a0 and (NOT s)) OR (a1 and s));

end dataflow;