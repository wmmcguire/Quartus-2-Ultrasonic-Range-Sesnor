Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity bcdconv is
	port( dist_input : in std_logic_vector(8 downto 0);
		  hundreds, tens, ones: out std_logic_vector(3 downto 0));
end bcdconv;

architecture Behavior of bcdconv is
begin
process(dist_input)
	variable I : integer :=0;
	variable bcd : std_logic_vector(20 downto 0);
	
	begin
		bcd := (others => '0');
		bcd(8 downto 0) := dist_input;

	for I in 0 to 8 loop
		bcd(19 downto 0) := bcd(18 downto 0) & '0';
		
		if( I < 8 and bcd(12 downto 9) > "0100") then
			bcd(12 downto 9) := bcd(12 downto 9) + "0011";
		end if;
		
		if(I < 8 and bcd(16 downto 13) > "0100") then
			bcd(16 downto 13) := bcd(16 downto 13) + "0011";
		end if;		

		if(I < 8 and bcd(20 downto 17) > "0100") then
			bcd(20 downto 17) := bcd(20 downto 17) + "0011";
		end if;	

	end loop;

	hundreds <= bcd(20 downto 17);
	tens <= bcd(16 downto 13);
	ones <= bcd(12 downto 9);
end process;

end Behavior;