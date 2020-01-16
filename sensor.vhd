library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--This Portion controls the Echo Sensor

entity sensor is
	port(internalClk, echo : in std_logic; -- clock pulse and echo signal 
		 trig_out : out std_logic; -- trigger 
		 m, cm, dm : out std_logic_vector(3 downto 0)); -- variables to convert to distance from time
	
end sensor;

architecture Behavior of sensor is 
component trigger is 
	port(
		clk: in std_logic;
		trigger: out std_logic
	);
end component; 
	
component distance_calc is
	port(  clk : in STD_LOGIC;
		   calc_rst : in STD_LOGIC;
		   pulse : in STD_LOGIC;
		   distance : out STD_LOGIC_VECTOR(8 downto 0));
end component;
	
component bcdconv is
  port(
	dist_input : in std_logic_vector(8 downto 0);
	hundreds, tens, ones: out std_logic_vector(3 downto 0)
  );
end component;

	
	signal distance_out: std_logic_vector(8 downto 0); -- to calculate into meters
	
	signal trigger_out: std_logic; -- not to be confused with trig_out
	
begin
	trig_out <= trigger_out;

	trig: trigger port map(internalClk, trigger_out);
	dist1: distance_calc port map(internalClk, trigger_out, echo, distance_out);
	BCD_conv: bcdconv port map(distance_out, m, dm,	cm);
end Behavior;