library ieee;
use ieee.std_logic_1164.all;

entity seg_display is
	port	(	BCD	:in	STD_LOGIC_VECTOR(0 to 3);
				HEX	:out	STD_LOGIC_VECTOR(0 to 6));
end entity;

architecture behavior of seg_display is
begin
process (BCD) 
	begin
		case(BCD) is
			when "0000" =>
				HEX <=  "1111110";
			when "0001" =>
				HEX <=  "0110000";
			when "0010" =>
				HEX <=  "1101101";
			when "0011" =>
				HEX <=  "1111001";
			when "0100" =>
				HEX <=  "0110011";
			when "0101" =>
				HEX <=  "1011011";
			when "0110" =>
				HEX <=  "1011111";
			when "0111" =>
				HEX <=  "1110000";
			when "1000" =>
				HEX <=  "1111111";
			when "1001" =>
				HEX <=  "1111011";
			when others =>
				HEX <=  "0000000";
			end case;
	end process;
end behavior;