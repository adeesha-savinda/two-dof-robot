library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity delay_clock is
	port(	clk	:in 	std_logic;
			ovf	:out	std_logic);
end entity;

architecture behavior of delay_clock is

signal ctr 				:std_logic_vector(25 downto 0);

begin
	process(CLK)
	begin
		--10111110101111000010000000 for 1 sec
		--00010011000100101101000000 for 1/10 sec
		--00000011110100001001000000 for 20ms
		--00000000011000011010100000 for 2 ms
		--00000000001100001101010000 for 1 ms
		--00000000000001001110001000 for 100 us
		--00000000000000000111110100 for 10 us
		--00000000000000001111101000
		if(ctr =  "00000000000000001111101000") then
			ctr <= "00000000000000000000000000";
			ovf <= '1';
		elsif(rising_edge(CLK)) then
			ctr <= ctr+1;
			ovf <= '0';
		end if;
	end process;
end behavior;