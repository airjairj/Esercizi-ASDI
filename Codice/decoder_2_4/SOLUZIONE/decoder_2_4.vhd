library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decoder_2_4 is

	port( 	a : in STD_LOGIC_VECTOR (1 downto 0);
			y : out STD_LOGIC_VECTOR (3 downto 0)
	);
		
end decoder_2_4;


architecture dataflow of decoder_2_4 is

	begin
		y(3) <= not a(1) and not a(0);
		y(2) <= not a(1) and a(0);
		y(1) <= a(1) and not a(0);
		y(0) <= a(1) and a(0);

end dataflow;


architecture dataflow_v1 of decoder_2_4 is
	
	begin
		y 	<= 	"1000" when a="00" else
		        "0100" when a="01" else
		        "0010" when a="10" else
		        "0001" when a="11" else
		        "----";
		        	
end dataflow_v1;

architecture dataflow_v2 of decoder_2_4 is

	begin  	
	   			
	 with a select
		y   <= 
		        "1000" when "00",
				"0100" when "01" ,
				"0010" when "10",
				"0001" when "11",
				"----" when others;
				
		
		
end dataflow_v2;


architecture behavioral of decoder_2_4 is
begin
   process (a) 
   begin
	  
      case (a) is
         when "00" => 
            y <="1000";
         when "01" =>
            y <="0100";
         when "10" =>
             y <="0010";
         when "11" =>
             y <="0001";
         when others => 
             y <="----";
      end case;
   end process;
end behavioral;








