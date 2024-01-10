library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity unita_controllo is 
	port( qLSB : in std_logic_vector(1 downto 0);
	      clock, reset, start: in std_logic;--clock ? il clock della board, clock_div viene dal divisore di freq
		  count: in std_logic_vector(2 downto 0);
		  loadM, count_in, loadAQ, en_shift: out std_logic;
		  selAQ, subtract, stop_cu: out std_logic); 
end unita_controllo;


architecture structural of unita_controllo is
	type state is (idle, acquisisci_op, waitSR, avvia_scan, avvia_shift, incr_count, fine);
	signal current_state,next_state: state;

	begin 
		
	reg_stato: process(clock)
			  begin
			  if(clock'event and clock='1') then
		         if(reset='1') then 
				    current_state <=idle;
			    else 
				    current_state <=next_state;
			     end if;
			  end if;
			  end process;
			  
	comb: process(current_state, start, count)
		  begin
		  
		  -- Attenzione! questo process si attiva ogni volta che c'? una variazione nei segnali della sensitivity list
		  -- current_state e count per loro natura variano sempre in corrispodenza del fronte di salita del clock
		  -- start viene dall'esterno: se non varia (sale e scende) col fronte del clock, si potrebbe avere una situazione
		  -- in cui il next_state varia ma non ha modo da stabilizzarsi (perch? current_state non ? ancora variato)
		  -- quando il moltiplicatore sar? messo su board, START dovr? essere generato come uscita del button debouncer
		  
		count_in <='0'; 
		subtract <='0';
		selAQ <= '0';
		loadAQ <='0';  --carica nello shift register
		loadM <='0';   --carica il moltiplicando nel registro M
		stop_cu <='0';  
		en_shift <='0'; --segnale che abilita lo shift durante le prime N-1 iterazioni
         
		  	            
		CASE current_state is
			-- Inizializzazione
			WHEN idle =>          
				if(start='1') then 
					next_state <= acquisisci_op;
				else 
					next_state <= idle;
				end if;
		
		  	-- Fornisce i segnali di caricamento operandi
		  	WHEN acquisisci_op => 
				loadM <='1'; --abilita il caricamento del moltiplicando nel registro M
				loadAQ <='1'; --abilita il caricamento del moltiplicatore e degli 8 zeri in testa 
					              --nello shift register A.Q (perch? selAQ=0)	
				next_state <= waitSR;
						
			-- Acquisisce gli operandi, su cui il sommatore inizia a lavorare immediatamente
		  	WHEN waitSR => 
		        next_state <= avvia_scan;    
					              
		 	-- Guarda i due bit meno significativi del moltiplicatore e decide cosa fare
			WHEN avvia_scan =>  
				if(qLSB = "01") then --sommi
					selAQ <= '1';
					loadAQ <= '1'; --fornisce il segnale di caricamento in A del risultato della somma
					next_state <= avvia_shift;
				elsif(qLSB = "10") then --sottrai
					subtract <= '1';  
					selAQ <= '1';
					loadAQ <= '1'; --fornisce il segnale di caricamento in A del risultato della somma
					next_state <= avvia_shift;
				elsif (qLSB = "00" or qLSB = "11") then --shifti solo
					next_state <= avvia_shift;
				end if;
		
		 	-- Carica il risultato della somma in A e da fornisce il segnale di shift
		 	WHEN avvia_shift =>                      
				en_shift <='1';
				if(count="111") then --sei a 7, ora di uscire
					next_state <= fine;
				else
					next_state <= incr_count;
				end if;
		 	-- Esegue lo shift, abilita incremento conteggio e predispone per nuova iterazione  
		 	WHEN incr_count => 
				count_in <= '1';
				next_state <= avvia_scan;
		 	-- Fine moltiplicazione
			WHEN fine => 
				stop_cu <='1'; --segnale che ferma il CU
				next_state <= idle;
		end CASE;
		
    end process; 
 end structural;