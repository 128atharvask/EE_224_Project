library ieee;
use ieee.std_logic_1164.all;

--library work;
--use work.basic.all;

entity reg is	
	port(
		E : in std_logic;
		clk : in std_logic;
		D_in : in std_logic_vector(15 downto 0);	-- input data
		D_out : out std_logic_vector(15 downto 0)	-- output data
		);
		
end entity;

architecture arch of reg is
	signal data : std_logic_vector(15 downto 0);
	
begin
	write_proc: process(E, D_in)
    begin
        if (clk'event and clk = '0' and E = '1') then  --writing at negative clock edge
				data <= D_in;
			else null;
			end if;
end process;

D_out <= data;					 
end arch;