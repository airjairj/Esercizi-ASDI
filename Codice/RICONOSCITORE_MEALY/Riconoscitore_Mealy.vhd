----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2022 15:15:28
-- Design Name: 
-- Module Name: Riconoscitore_Mealy - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- RICONOSCITORE DELLA SEQUENZA 101 PARZIALMENTE SOVRAPPOSTA 
-- (QUANDO RICONOSCE LA SEQUENZA TORNA IN S0 ---


entity Riconoscitore_Mealy is
	port( i: in std_logic;
		  RST, CLK: in std_logic;
		  Y: out std_logic
	);
end Riconoscitore_Mealy;

-- versione con 1 process:
--architecture Behavioral_1proc of Riconoscitore_Mealy is

--type stato is (S0, S1, S2, S3, S4);
--signal stato_corrente : stato := S0;
--attribute fsm_encoding : string;
--attribute fsm_encoding of stato_corrente : signal is "one_hot";


--begin
--stato_uscita_mem: process(CLK)
--	begin
--	if rising_edge(CLK) then
--	   if( RST = '1') then
--	       stato_corrente <= S0;
--	       Y <= '0';
--	   else
--	   	case stato_corrente is
--			when S0 =>
--				if( i = '0' ) then
--					stato_corrente <= S0;
--					Y <= '0';
--				else 
--					stato_corrente <= S1;
--					Y <= '0';
--				end if;
--			when S1 =>
--				if( i = '0' ) then
--					stato_corrente <= S2;
--					Y <= '0';
--				else
--					stato_corrente <= S1;
--					Y <= '0';
--				end if;
--			when S2 =>
--				if( i = '0' ) then
--					stato_corrente <= S0;
--					Y <= '0';
--				else
--					stato_corrente <= S0;
--					Y <= '1';
--				end if;
--			when others =>
--			        stato_corrente <= S0;
--			        Y <= '0';
--		end case;
--		end if;
--	end if;
--end process;

--end Behavioral_1proc;



-- versione con 2 process : attenzione, in presenza di più architecture
-- viene sintetizzata quella che compare per ultima nel file
architecture Behavioral_2proc of Riconoscitore_Mealy is

type stato is (S0, S1, S2);

signal stato_corrente : stato := S0;
signal stato_prossimo : stato;

--signal Ytemp : std_logic;

begin

-- questo processo rappresenta la parte combinatoria di una macchina sequenziale
-- attenzione: l'uscita viene aggiornata da un processo puramente combinatorio
-- quindi appena mi trovo in S2 se i diventa 1 l'uscita si alza immediatamente

stato_uscita: process(stato_corrente, i)
	begin
	   case stato_corrente is
			when S0 =>
				if( i = '0' ) then
					stato_prossimo <= S0;
					Y <= '0';
				else 
					stato_prossimo <= S1;
					Y <= '0';
				end if;
			when S1 =>
				if( i = '0' ) then
					stato_prossimo <= S2;
					Y <= '0';
				else
					stato_prossimo <= S1;
					Y <= '0';
					
				end if;
			when S2 =>
				if( i = '0' ) then
					stato_prossimo <= S0;
					Y <= '0';
				else
					stato_prossimo <= S0;
					Y <= '1';
				end if;
				
				
		end case;
		
end process;


-- questo processo rappresenta gli elementi di memoria 
mem: process (CLK)
begin
	if( CLK'event and CLK = '1' ) then
		if( RST = '1') then
	       stato_corrente <= S0;
	    else
	       stato_corrente <= stato_prossimo;
	    end if;
   end if;
end process;


end Behavioral_2proc;


-- versione con 2 process alternativo, con uscita sincrona col clock
--architecture Behavioral_2proc_v2 of Riconoscitore_Mealy is

--type stato is (S0, S1, S2);

--signal stato_corrente : stato := S0;
--signal stato_prossimo : stato;

--signal Ytemp : std_logic;

--begin

--stato_uscita: process(stato_corrente, i)
--	begin
--	   case stato_corrente is
--			when S0 =>
--				if( i = '0' ) then
--					stato_prossimo <= S0;
--					Ytemp <= '0';
					
--				else 
--					stato_prossimo <= S1;
--					Ytemp <= '0';
					
--				end if;
--			when S1 =>
--				if( i = '0' ) then
--					stato_prossimo <= S2;
--					Ytemp <= '0';
					
--				else
--					stato_prossimo <= S1;
--					Ytemp <= '0';
					
					
--				end if;
--			when S2 =>
--				if( i = '0' ) then
--					stato_prossimo <= S0;
--					Ytemp <= '0';
					
--				else
--					stato_prossimo <= S0;
--					Ytemp <= '1';
					
--				end if;
--		end case;
		
		
--end process;


---- questo processo rappresenta gli elementi di memoria 
--mem: process (CLK)
--begin
--	if( CLK'event and CLK = '1' ) then
--		if( RST = '1') then
--	       stato_corrente <= S0;
--	       Y <= '0';
--	    else
--	       stato_corrente <= stato_prossimo;
--	       Y <= Ytemp;
--	    end if;
--   end if;
--end process;


--end Behavioral_2proc_v2;


