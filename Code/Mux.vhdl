library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux is
   	port(
	inp : in size21x16;
   	sel : in state;
   	outp : out std_logic_vector(15 downto 0);
   	);
end entity Mux;

architecture behave of Mux is
begin
    -- outp <= inp(unsigned(sel));
	case sel is
		when s0 => outp <= inp(0);
		when s1 => outp <= inp(1);
		when s2 => outp <= inp(2);
		when s3 => outp <= inp(3);
		when s4 => outp <= inp(4);
		when s5 => outp <= inp(5);
		when s6 => outp <= inp(6);
		when s7 => outp <= inp(7);
		when s8 => outp <= inp(8);
		when s9 => outp <= inp(9);
		when s10 => outp <= inp(10);
		when s11 => outp <= inp(11);
		when s12 => outp <= inp(12);
		when s13 => outp <= inp(13);
		when s14 => outp <= inp(14);
		when s15 => outp <= inp(15);
		when s16 => outp <= inp(16);
		when s17 => outp <= inp(17);
		when s18 => outp <= inp(18);
		when s19 => outp <= inp(19);
		when s20 => outp <= inp(20);
		when s21 => outp <= inp(21);
end architecture behave;