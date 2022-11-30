-- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(0 downto 0);
       	output_vector: out std_logic_vector(127 downto 0));
end entity;

architecture DutWrap of DUT is
   component Main is
   port (clk: in std_logic; 
      rf_data0: out std_logic_vector(15 downto 0);
		rf_data1: out std_logic_vector(15 downto 0);
		rf_data2: out std_logic_vector(15 downto 0);
		rf_data3: out std_logic_vector(15 downto 0);
		rf_data4: out std_logic_vector(15 downto 0);
		rf_data5: out std_logic_vector(15 downto 0);
		rf_data6: out std_logic_vector(15 downto 0);
		rf_data7: out std_logic_vector(15 downto 0));
end component;

begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: Main 
			port map (
					-- order of inputs
					clk => input_vector(0),
               -- order of output
					rf_data0 => output_vector(127 downto 112),
					rf_data1 => output_vector(111 downto 96),
					rf_data2 => output_vector(95 downto 80),
					rf_data3 => output_vector(79 downto 64),
					rf_data4 => output_vector(63 downto 48),
					rf_data5 => output_vector(47 downto 32),
					rf_data6 => output_vector(31 downto 16),
					rf_data7 => output_vector(15 downto 0));
end DutWrap;