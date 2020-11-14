library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Test1 is
	port(	PB,NEG			:in 	STD_LOGIC; --onboard push button
			BCD0,BCD1		:in 	STD_LOGIC_VECTOR(0 to 3);
			CLK_50			:in	STD_LOGIC;		
			STB				:in	STD_LOGIC; --start push button
			HEX0,HEX1		:out 	STD_LOGIC_VECTOR(0 to 6);
			LED1,LED2,LED3	:out 	STD_LOGIC; --onboard LED
			SRV0,SRV1,LEDN	:out	STD_LOGIC); --Servo motor 0, Negative LED 
end Test1;

architecture behavior of Test1 is

component seg_display is
	port	(	BCD	:in	STD_LOGIC_VECTOR(0 to 3);
				HEX	:out	STD_LOGIC_VECTOR(0 to 6));
end component;

component angle_selector is
	port (	bcd_10	:in	std_logic_vector(0 to 3);
				bcd_1		:in	std_logic_vector(0 to 3);
				neg		:in	std_LOGIC;
				angle		:out	std_logic_vector(25 downto 0));
end component;

component pwm_clock is
	port(	clk		:in 	std_logic;
			angle_0	:in	std_logic_vector(25 downto 0);
			angle_1	:in	std_logic_vector(25 downto 0);
			servo0	:out	std_logic;
			servo1	:out	std_logic);
end component;

component sampling_clock is
	port(	clk		:in 	std_logic;
			ovf		:out	std_logic);
end component;

component delay_clock is
	port(	clk	:in 	std_logic;
			ovf	:out	std_logic);
end component;

signal ctr 				:std_logic_vector(25 downto 0);
signal ctr_ovr_flow	:std_logic;
signal angle_val_0	:std_logic_vector(25 downto 0):="00000000010010010011111000";
signal angle_val_1	:std_logic_vector(25 downto 0):="00000000010010010011111000";

type state_type is (A,B,C);
signal state_now,state_next :state_type;

signal temp_angle_0		:std_logic_vector(25 downto 0);
signal temp_angle_1		:std_logic_vector(25 downto 0);
signal angle_val_now_0	:std_logic_vector(25 downto 0);
signal angle_val_now_1	:std_logic_vector(25 downto 0);

signal sample 				:std_logic;
signal dly					:std_logic;

signal temp : std_logic:='1';

begin
	--process used to assign state
	process (STB,sample)
	begin
		if(rising_edge(sample)) then
			if(STB = '1') then
				state_now <= state_next;
			end if;
		end if;
	end process;
	
	--state transitions
	process (state_now)
	begin
		case state_now is
			when A => state_next <= B;
			when B => state_next <= C;
			when C => state_next <= A;
		end case;
	end process;
	
	--output logic
	process (state_now,dly)
	begin
		case state_now is
			when A => 
				temp_angle_0 <= angle_val_now_0;
			when B =>
				temp_angle_1 <= angle_val_now_0;
			when C =>
				if(rising_edge(dly)) then
					if(angle_val_0 < temp_angle_0) then
						--turn CW
						angle_val_0 <= angle_val_0+1;
					else
						--turn CCW
						angle_val_0 <= angle_val_0-1;
					end if;
					if(angle_val_1 < temp_angle_1) then
						--turn CW
						angle_val_1 <= angle_val_1+1;
					else
						--turn CCW
						angle_val_1 <= angle_val_1-1;
					end if;
				end if;
				
--				angle_val_0 <= temp_angle_0;
--				angle_val_1 <= temp_angle_1;
		end case;
	end process;
	
	--show state
	process (state_now)
	begin
		case state_now is
			when A => 
				LED1 <= '0';
				LED2 <= '1';
				LED3 <= '1';
			when B =>
				LED1 <= '1';
				LED2 <= '0';
				LED3 <= '1';
			when C =>
				LED1 <= '1';
				LED2 <= '1';
				LED3 <= '0';
		end case;
	end process;
	
	LEDN <= NEG;
	
	SD0: 	seg_display port map(BCD0,HEX0);
	SD1: 	seg_display port map(BCD1,HEX1);
	AS0: 	angle_selector port map(BCD0,BCD1,NEG,angle_val_now_0);
	--AS1: 	angle_selector port map(BCD0,BCD1,NEG,angle_val_now_1);
	CLK0:	pwm_clock port map(CLK_50,angle_val_0,angle_val_1,SRV0,SRV1);
	CLK1:	sampling_clock port map(CLK_50,sample);
	CLK2:	delay_clock port map(CLK_50,dly);
	
end behavior;