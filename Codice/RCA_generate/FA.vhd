----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2023 19:45:42
-- Design Name: 
-- Module Name: FA - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFA is
	port(
		OP_A: in std_logic;
		OP_B: in std_logic;
		CIN: in std_logic;
	
		S: out std_logic;
		COUT: out std_logic
	);
end myFA;

architecture dataflow of myFA is
begin
	S <= (OP_A xor OP_B) xor CIN;
	COUT <= (OP_A and OP_B) or (CIN and(OP_A or OP_B));
end dataflow;

