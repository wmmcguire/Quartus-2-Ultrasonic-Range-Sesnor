library ieee;
use ieee.std_logic_1164.all;

entity UltrasonicRangeSensor is
	port( echoPin, clk: in std_logic;
		  trigPin: out std_logic;
		  
		  sevSeg0, sevSeg1, sevSeg2, sevSeg3: out std_logic_vector(6 downto 0));
		  
		  
end UltrasonicRangeSensor;

architecture Behavior of UltrasonicRangeSensor is 

component sensor
	port(internalClk, echo : in std_logic; -- clock pulse and echo signal 
		 trig_out : out std_logic; -- trigger 
		 m, dm, cm : out std_logic_vector(3 downto 0));
		 ledr, ledg: out std_logic;
end component;

component ssDisplay
	port( dispA: in std_logic_vector(3 downto 0);
		  dispB: in std_logic_vector(3 downto 0);
		  dispC: in std_logic_vector(3 downto 0);
		  dispD: in std_logic_vector(3 downto 0); --4 bits to each display
		  clock: in std_logic;
		  	  
		  
		  ssd0, ssd1, ssd2, ssd3: out std_logic_vector(6 downto 0));
end component;

signal A, B, C, D: std_logic_vector(3 downto 0);
signal m_sensor, dm_sensor, cm_sensor: std_logic_vector(3 downto 0);

begin
	display : ssDisplay
		port map(A, B, C, D, clk, sevSeg0, sevSeg1, sevSeg2, sevSeg3);
	
	rangeSensor: sensor
		port map(clk, echoPin, trigPin, m_sensor, dm_sensor, cm_sensor);
		
	A <= dm_sensor;
	B <= "0000";
	C <= "0000";
	D <= "0000";
	
	if (A <= "0100") then
		ledr <= '1';
	elsif (A >= "0111") then
		ledg <= '1';
	end if;
	--each of these pieces of data take input from the sensor, then drive the displays.

end Behavior;