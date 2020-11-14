library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity angle_selector is
	port (	bcd_10	:in	std_logic_vector(0 to 3);
				bcd_1		:in	std_logic_vector(0 to 3);
				neg		:in	std_logic;
				angle		:out	std_logic_vector(25 downto 0));
end entity;

architecture behavior of angle_selector is
signal tens	:std_logic_vector(25 downto 0);
signal ones	:std_logic_vector(25 downto 0);

begin
	
process (bcd_10,bcd_1) 
	begin
--		case(bcd_10) is
--			when "0000" =>
--				angle <=  std_logic_vector(to_unsigned(75000,26));
--			when "0001" =>
--				angle <=  std_logic_vector(to_unsigned(75000+5000,26));
--			when "0010" =>
--				angle <=  std_logic_vector(to_unsigned(75000+10000,26));
--			when "0011" =>
--				angle <=  std_logic_vector(to_unsigned(75000+15000,26));
--			when "0100" =>
--				angle <=  std_logic_vector(to_unsigned(75000+20000,26));
--			when "0101" =>
--				angle <=  std_logic_vector(to_unsigned(75000+25000,26));
--			when "0110" =>
--				angle <=  std_logic_vector(to_unsigned(75000+30000,26));
--			when "0111" =>
--				angle <=  std_logic_vector(to_unsigned(75000+35000,26));
--			when "1000" =>
--				angle <=  std_logic_vector(to_unsigned(75000+40000,26));
--			when "1001" =>
--				angle <=  std_logic_vector(to_unsigned(75000+45000,26));
--			when others =>
--				angle <=  std_logic_vector(to_unsigned(75000,26));
--			end case;
			case(bcd_10) is
			when "0000" =>
				tens <=  std_logic_vector(to_unsigned(0,26));
			when "0001" =>
				tens <=  std_logic_vector(to_unsigned(5000,26));
			when "0010" =>
				tens <=  std_logic_vector(to_unsigned(10000,26));
			when "0011" =>
				tens <=  std_logic_vector(to_unsigned(15000,26));
			when "0100" =>
				tens <=  std_logic_vector(to_unsigned(20000,26));
			when "0101" =>
				tens <=  std_logic_vector(to_unsigned(25000,26));
			when "0110" =>
				tens <=  std_logic_vector(to_unsigned(30000,26));
			when "0111" =>
				tens <=  std_logic_vector(to_unsigned(35000,26));
			when "1000" =>
				tens <=  std_logic_vector(to_unsigned(40000,26));
			when "1001" =>
				tens <=  std_logic_vector(to_unsigned(45000,26));
			when others =>
				tens <=  std_logic_vector(to_unsigned(0,26));
			end case;
			
			case(bcd_1) is
			when "0000" =>
				ones <=  std_logic_vector(to_unsigned(0,26));
			when "0001" =>
				ones <=  std_logic_vector(to_unsigned(500,26));
			when "0010" =>
				ones <=  std_logic_vector(to_unsigned(1000,26));
			when "0011" =>
				ones <=  std_logic_vector(to_unsigned(1500,26));
			when "0100" =>
				ones <=  std_logic_vector(to_unsigned(2000,26));
			when "0101" =>
				ones <=  std_logic_vector(to_unsigned(2500,26));
			when "0110" =>
				ones <=  std_logic_vector(to_unsigned(3000,26));
			when "0111" =>
				ones <=  std_logic_vector(to_unsigned(3500,26));
			when "1000" =>
				ones <=  std_logic_vector(to_unsigned(4000,26));
			when "1001" =>
				ones <=  std_logic_vector(to_unsigned(4500,26));
			when others =>
				ones <=  std_logic_vector(to_unsigned(0,26));
			end case;
	
			if(neg = '1') then
				angle <= "00000000010010010011111000" - tens - ones;
			else
				angle <= "00000000010010010011111000" + tens + ones;
			end if;
	end process;
	
	--angle <= "00000000010010010011111000" + tens + ones;

end behavior;