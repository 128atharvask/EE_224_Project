library ieee;
use ieee.std_logic_1164.all;

package DataTypePackage is
   type size20x16 is array(0 to 19) of std_logic_vector(15 downto 0);
	type size20x2 is array(0 to 19) of std_logic_vector(1 downto 0);
	type size20x3 is array(0 to 19) of std_logic_vector(2 downto 0);
	type size2x16 is array(0 to 1) of std_logic_vector(15 downto 0);
	type size2x3 is array(0 to 1) of std_logic_vector(2 downto 0);
	type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,
		s10,s11,s12,s13,s14,s15,s16,s17,s18,s19);
end package;