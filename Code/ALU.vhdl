-- Preliminaries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- The Arithmetic and the Logical Unit of IITB-CPU
-- See ALU Documentation in the Report for details regarding inputs and outputs of ALU

entity ALU is

	port(

    -- inputs
        ALU_A,ALU_B:in std_logic_vector(2 downto 0);
		c_in,z_in,clock:in std_logic;
        ALU_J,ALU_CND:in std_logic_vector(1 downto 0);

    -- outputs
		ALU_C, ALU_Z, Z_int: out std_logic;
        ALU_S: out std_logic_vector(2 downto 0)
        );

end ALU;

architecture behavioural of ALU is
begin

    -- works on the rising edge of the clock
    if(clock='1' and clock' event) then
        -- write code
    end if;

end architecture behavioural;