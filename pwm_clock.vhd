library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pwm_clock is
	port(	clk		:in 	std_logic;
			angle_0	:in	std_logic_vector(25 downto 0);
			angle_1	:in	std_logic_vector(25 downto 0);
			servo0	:out	std_logic;
			servo1	:out	std_logic);
end entity;

architecture behavior of pwm_clock is

signal ctr 				:std_logic_vector(25 downto 0);

begin
	process(CLK)
	begin
		--10111110101111000010000000 for 1 sec
		--00010011000100101101000000 for 1/10 sec
		--00000011110100001001000000 for 20ms
		--00000000011000011010100000 for 2 ms
		--00000000001100001101010000 for 1 ms		
		if(ctr =  "00000011110100001001000000") then
			ctr <= "00000000000000000000000000";
			servo0 <= '1';
			servo1 <= '1';
		elsif(rising_edge(CLK)) then
			ctr <= ctr+1;
		end if;
		
		if(ctr = angle_0) then
			servo0 <= '0';
		end if;
		
		if(ctr = angle_1) then
			servo1 <= '0';
		end if;
		
	end process;
end behavior;