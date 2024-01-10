library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity mrob_tb is
end mrob_tb;

architecture behavioural of mrob_tb is

	component molt_rob is
	  port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   --stop: out std_logic;		   
		   output_prodotto: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic);
	end component;
	signal inputx, inputy: std_logic_vector(7 downto 0);
	signal prod: std_logic_vector(15 downto 0);
	signal clk, res, start: std_logic;
	signal t_stop_cu: std_logic;
    constant clk_period : time := 20 ns;
    
    signal end_sim : std_logic := '0';
    
       
	begin
	
	uut: molt_rob port map(clk, res, start, inputx, inputy, prod, t_stop_cu);
	
	clk_process : process
     begin
        while (end_sim = '0') loop
            clk<= '1';
            wait for clk_period/2;
            clk <= '0';
            wait for clk_period/2;
        end loop;
        wait;
     end process;
   
	 

-- SIMULARE PER 9000 NS

	
	sim: process
		 begin
		 
		 wait for 100 ns;
		
		 res<='1';
		 wait for 20 ns;
		 res<='0';
		
		 -- -------------------------------------   operazione numero 1:
		 -- 15*3=45 (002D)
		 inputx<="00001111";  
		 inputy<="00000011";  
		 	 
		 -- start deve essere visto da clk_div: poichè sarà generato dal button debouncer si aggiungerà anche il clk_div
		 -- al button debouncer e il segnale di start deve durare quanto il periodo del clk rallentato
		 wait for 40 ns;
		 start<='1';
		 wait for 20 ns;
		 start<='0';
		 wait;
		 end process;
	
	
	end behavioural;