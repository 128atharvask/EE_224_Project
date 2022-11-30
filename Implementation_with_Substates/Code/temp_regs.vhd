library ieee;
use ieee.std_logic_1164.all;

entity temp_regs is	
	port(
		E : in std_logic; -- write enable
		D_in : in std_logic_vector(15 downto 0);	-- input data
		D_out : out std_logic_vector(15 downto 0)	-- output data
		);
end entity;

architecture arch of temp_regs is
	-- this signal is the temporary register
	signal data : std_logic_vector(15 downto 0);
	
begin
	write_proc: process(E, D_in)
    begin
        if (E = '1') then
				data <= D_in;
		  else null;
		  end if;
end process;

D_out <= data;					 
end arch;