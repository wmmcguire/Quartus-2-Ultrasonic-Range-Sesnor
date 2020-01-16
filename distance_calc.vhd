Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;



entity distance_calc is
	Port ( clk : in STD_LOGIC;
		   calc_rst : in STD_LOGIC;
		   pulse : in STD_LOGIC;
		   distance : out STD_LOGIC_VECTOR (8 downto 0) );
end distance_calc;


architecture Behavior of distance_calc is
component counter is
	generic(n: positive := 10);
	port(clk, g, rst: in std_logic;
	counter_out: out STD_LOGIC_VECTOR(n-1 downto 0));
end component;

signal pulseWidth : STD_LOGIC_VECTOR(21 downto 0);

begin
CouterPulse : counter generic map(22) port map(clk, pulse, not calc_rst, pulseWidth);

distance_calc : process(pulse)
				variable Result : integer;
				variable multiplier : STD_LOGIC_VECTOR(23 downto 0);	
		begin
				if(pulse = '0') then
					multiplier := pulseWidth * "11";
					Result := to_integer(unsigned(multiplier(23 downto 13))); --converts bit value to decimal
						if(Result > 450) then
							distance <= "111111111";
						else
							distance <= STD_LOGIC_VECTOR(to_unsigned(Result,9));
						end if;
				end if;
		end process distance_calc;
end Behavior;