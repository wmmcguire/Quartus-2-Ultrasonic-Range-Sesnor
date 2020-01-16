library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity trigger is
	port(clk: in std_logic;
		 trigger: out std_logic);
end trigger;

architecture Behavior of trigger is
component counter is
	generic(n: positive := 10);
	port(clk, g, rst: in std_logic;
	counter_out: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;

signal rstCounter: std_logic;
signal outCounter: std_logic_vector(23 downto 0);

begin
	trig: counter generic map(24) port map(clk, '1', rstCounter, outCounter);
	process(clk)
		constant ms250: std_logic_vector(23 downto 0) := "101111101011110000100000";
		constant ms250us100: std_logic_vector(23 downto 0) := "101111101100111110101000";
		
		begin
			if(outCounter > ms250 and outCounter < ms250us100) then
				trigger <= '1';
			else
				trigger <= '0';
			end if;
			if(outCounter = ms250us100 or outCounter = "XXXXXXXXXXXXXXXXXXXXXXXX") then
				rstCounter <= '0';
			else
				rstCounter <= '1';
			end if;
	end process;
	
end Behavior;

