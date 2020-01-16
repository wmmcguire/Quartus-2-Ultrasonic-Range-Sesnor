library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ssDisplay is
	port(
		clk, ssd_reset : in std_logic; -- Clock, Display Reset
		d0, d1, d2 : in std_logic_vector(3 downto 0); -- Decoder inputs
  		S : out std_logic_vector(2 downto 0); -- Multiplexer
  		ssd : out std_logic_vector (6 downto 0) -- Seven-Segment Display Outputs
	);
end ssDisplay;

architecture Behavior of ssDisplay is
component Counter is
	generic(
		n: POSITIVE := 10
	);
	port(
		clk: in std_logic;
		enable: in std_logic;
		reset: in std_logic;
		count_out: out std_logic_vector(n-1 downto 0)
	);
end component;
	
	
	signal out_display : std_logic_vector (19 downto 0);
 	signal M : std_logic_vector( 1 downto 0); -- Selector for Multiplexor
 	signal mux_out : std_logic_vector (3 downto 0); --
begin
	counter_disp : counter generic map(20) port map(clk, '1', not Display_reset, out_display);
	-- Seleciona os ultimos valores do vetor, com o fim de retardar a variacao dos digitos
    	S <= std_logic_vector(out_display(19 downto 18));
    	process(s, d0, d1, d2)
    		begin
      		case M is
        		when "00" => S <= "001";
        			mux_out <= d0;
        		when "01" => S <= "010";
        			mux_out <= d1;
 	      		when others => S <= "100";
    			    mux_out <= d2;
      			end case;
    		end process;
    		
		
   	   		ssd<= "1111110" when mux_out="0000" else -- 0 
				  "0110000" when mux_out="0001" else -- 1
		 		  "1101101" when mux_out="0010" else -- 2
				  "1111001" when mux_out="0011" else -- 3
				  "0110011" when mux_out="0100" else -- 4 
				  "1011011" when mux_out="0101" else -- 5 
				  "1011111" when mux_out="0110" else -- 6 
				  "1110000" when mux_out="0111" else -- 7 
				  "1111111" when mux_out="1000" else -- 8 
				  "1111011" when mux_out="1001" else -- 9 
				  "1111111"; -- blank
				
end Behavior;