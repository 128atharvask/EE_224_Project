library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux is
   	port(
	inp : in mux_in;
   	sel : in std_logic_vector(4 downto 0);
   	outp : out std_logic_vector(15 downto 0);
   	);
end entity Mux;

architecture behave of Mux is
begin
    outp <= inp(sel);
end architecture behave;