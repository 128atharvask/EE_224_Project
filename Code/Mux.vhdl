library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;



package Mux is
	
component Mux22x16 is
   port(
	inp : in size22x16;
   sel : in state;
   outp : out std_logic_vector(15 downto 0)
   );
end component Mux22x16;

component Mux22x2 is
   port(
	inp : in size22x2;
   sel : in state;
   outp : out std_logic_vector(1 downto 0)
   );
end component Mux22x2;

component Mux22x3 is
   port(
	inp : in size22x3;
   sel : in state;
   outp : out std_logic_vector(2 downto 0)
   );
end component Mux22x3;


component Mux22x1 is
   port(
	inp : in std_logic_vector(21 downto 0);
   sel : in state;
   outp : out std_logic
   );
end component Mux22x1;

component Mux2x16 is
   port(
	inp : in size2x16;
   sel : in std_logic;
   outp : out std_logic_vector(15 downto 0)
   );
end component Mux2x16;

component Mux2x3 is
   port(
	inp : in size2x3;
   sel : in std_logic;
   outp : out std_logic_vector(2 downto 0)
   );
end component Mux2x3;

component Mux2x1 is
   port(
	inp : in std_logic_vector(1 downto 0);
   sel : in std_logic;
   outp : out std_logic
   );
end component Mux2x1;

end package Mux;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux22x16 is
   	port(
	inp : in size22x16;
   	sel : in state;
   	outp : out std_logic_vector(15 downto 0)
   	);
end entity Mux22x16;

architecture behave1 of Mux22x16 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
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
		when others => null;
	end case;
	end process;
end architecture behave1;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux22x3 is
   	port(
	inp : in size22x3;
   	sel : in state;
   	outp : out std_logic_vector(2 downto 0)
   	);
end entity Mux22x3;

architecture behave2 of Mux22x3 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
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
		when others => null;
	end case;
	end process;
end architecture behave2;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux22x2 is
   	port(
	inp : in size22x2;
   	sel : in state;
   	outp : out std_logic_vector(1 downto 0)
   	);
end entity Mux22x2;

architecture behave3 of Mux22x2 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
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
		when others => null;
	end case;
	end process;
end architecture behave3;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux22x1 is
   	port(
	inp : in std_logic_vector(21 downto 0);
   	sel : in state;
   	outp : out std_logic
   	);
end entity Mux22x1;

architecture behave4 of Mux22x1 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
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
		when others => null;
	end case;
	end process;
end architecture behave4;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux2x16 is
	port(
	inp : in size2x16;
   sel : in std_logic;
   outp : out std_logic_vector(15 downto 0)
   );
end entity Mux2x16;

architecture behave5 of Mux2x16 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
	case sel is
		when '0' => outp <= inp(0);
		when '1' => outp <= inp(1);
		when others => null;
	end case;
	end process;
end architecture behave5;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux2x3 is
   port(
	inp : in size2x3;
   sel : in std_logic;
   outp : out std_logic_vector(2 downto 0)
   );
end entity Mux2x3;

architecture behave6 of Mux2x3 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
	case sel is
		when '0' => outp <= inp(0);
		when '1' => outp <= inp(1);
		when others => null;
	end case;
	end process;
end architecture behave6;



library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Mux2x1 is
   port(
	inp : in std_logic_vector(1 downto 0);
   sel : in std_logic;
   outp : out std_logic
   );
end entity Mux2x1;

architecture behave7 of Mux2x1 is
begin
    -- outp <= inp(unsigned(sel));
	connection: process(inp, sel)
	begin
	case sel is
		when '0' => outp <= inp(0);
		when '1' => outp <= inp(1);
		when others => null;
	end case;
	end process;
end architecture behave7;