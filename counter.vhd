library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-----------------------------------------------------------------------
-- Module to divide the clock 
-----------------------------------------------------------------------
entity counter is
	generic(n: positive := 10);
    Port(clk, g, rst : in std_logic;
        counter_out: out STD_LOGIC_VECTOR(n-1 downto 0));
end counter;

architecture Behavior of counter is
signal count: std_logic_vector(n-1 downto 0);
begin
process (clk, rst, g)
	begin
	if (rst = '0') then
		count <= (others => '0');
	elsif (clk'event and clk = '1') then
		if (g = '1') then
			count <= count + 1;
		end if;
	end if;
end process;

counter_out <= count;
	
end Behavior;

