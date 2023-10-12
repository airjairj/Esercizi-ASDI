library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity DELTAexample is

	port( 	x 	: in STD_LOGIC;
			y 	: out STD_LOGIC
	);
		
end DELTAexample;



--architecture noproc_arch of DELTAexample is
	
--	SIGNAL tmp : std_logic := 'U';

--	begin
	
--		tmp <= x;
--		y <= not tmp;
		
--end noproc_arch;


--architecture proc_sign_arch of DELTAexample is
	
--	SIGNAL tmp : std_logic := 'U';

--	begin
	
--	process (x)
--	begin
--		tmp <= x;       -- a tmp viene assegnato x dopo un delta da quando x varia
--		y <= not tmp;   -- sempre dopo un delta y assume il valore di tmp che però non si è
--		                -- ancora aggiornato, quindi y ha lo stesso valore di tmp;
--		                -- a questo punto il process si sospende e i segnali vengono aggiornati
--		                -- il process si riattiverà solo alla prossima variazione di x
--	end process;
	
--end proc_sign_arch;

architecture proc_sign_arch_v2 of DELTAexample is
	
	SIGNAL tmp : std_logic := 'U';

	begin
	
	process (x,tmp)
	begin
		tmp <= x;       -- a tmp viene assegnato x dopo un delta da quando x varia
		y <= not tmp;   -- sempre dopo un delta y assume il valore di tmp che però non si è
		                -- ancora aggiornato, quindi y ha lo stesso valore di tmp;
		                -- a questo punto il process si sospende e i segnali vengono aggiornati.
		                -- il process si riattiverà solo alla prossima variazione di x o tmp,
		                -- e quindi a 2delta perchè tmq è variato: quindi y si aggiorna
	end process;
	
end proc_sign_arch_v2;


-- architecture proc_var_arch of DELTAexample is
	
--	 begin
 
--	 process (x) 
     
--     variable tmp,yout : std_logic :='U';
--     begin
--         tmp := not x;
--         yout := tmp;
--	 end process;
	
-- end proc_var_arch;
