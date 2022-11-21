-- Preliminaries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- The Arithmetic and the Logical Unit of IITB-CPU
-- See ALU Documentation in the Report for details regarding inputs and outputs of ALU

entity ALU is

    generic(
        operand_width : integer:=16
    );

	port(

    -- inputs
        ALU_A, ALU_B:in std_logic_vector((operand_width - 1) downto 0);
		clock, c_in, z_in:in std_logic;
        ALU_J, ALU_CND:in std_logic_vector(1 downto 0);

    -- outputs
		ALU_C, ALU_Z, Z_int: out std_logic;
        ALU_S: out std_logic_vector((operand_width - 1) downto 0)
        );

end ALU;

architecture behavioural of ALU is

    function add(A: in std_logic_vector((operand_width-1) downto 0);
                 B: in std_logic_vector(15 downto 0))
    
        return std_logic_vector is
            variable sum: std_logic_vector((operand_width-1) downto 0);
            variable carry: std_logic_vector((operand_width-1) downto 0);
    begin
        L1: for i in 0 to (operand_width-1) loop
                if i = 0 then 
                    sum(i) := A(i) xor B(i);
                    carry(i) := A(i) and B(i);
                else
                    sum(i) := A(i) xor B(i) xor carry(i-1);
                    carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) or B(i)));
                end if;
            end loop L1;
        return carry((operand_width-1)) & sum;
    end add;
    function nander(A: in std_logic_vector((operand_width-1) downto 0);
		B: in std_logic_vector((operand_width-1) downto 0))
	return std_logic_vector is
		variable bitwise_nand : std_logic_vector((operand_width-1) downto 0);
	begin
		L2: for i in (operand_width-1) downto 0 loop
				bitwise_nand(i) := (A(i) nand B(i));
			end loop L2;
		return bitwise_nand;
	end nander;
    
    variable sum: std_logic_vector((operand_width-1) downto 0);
    variable full_add: std_logic_vector((operand_width) downto 0);
    variable carry: std_logic;
    variable bitwise_nand: std_logic_vector((operand_width-1) downto 0);
begin

    -- works on the rising edge of the clock
    clock_proc:process(clock,ALU_J, ALU_CND, ALU_A, ALU_B, c_in, z_in)
    begin
        if(clock='1' and clock' event) then
            if(ALU_J = "00") then
                full_add <= add(ALU_A, ALU_B);
                carry := full_add((operand_width-1));
                sum := full_add((operand_width-1) downto 0);
                ALU_S <= sum;
                if(ALU_S = "0000000000000000")
                    Z_int <= '1';
                else
                    Z_int <= '0';
                end if;
                if(ALU_CND = "00") then
                    ALU_C <= carry;
                    ALU_Z <= Z_int;
                elsif(ALU_CND = "10") then
                    ALU_C <= c_in and carry;
                    ALU_Z <= (c_in and Z_int) or ((not c_in) and z_in);
                elsif(ALU_CND = "01") then
                    ALU_C <= (z_in and carry) or ((not z_in) and c_in);
                    ALU_Z <= z_in and Z_int;
                else
                    ALU_C <= c_in;
                    ALU_Z <= z_in;
            end if;
            
            if(ALU_J = "01") then
                bitwise_nand <= nander(ALU_A, ALU_B);
                ALU_S <= bitwise_nand;
                if(ALU_S = "0000000000000000")
                    Z_int <= '1';
                else
                    Z_int <= '0';
                end if;
                ALU_C <= c_in;
                if(ALU_CND = "00") then
                    ALU_Z <= Z_int;
                elsif(ALU_CND = "10") then
                    ALU_Z <= (c_in and Z_int) or ((not c_in) and z_in);
                elsif(ALU_CND = "01") then
                    ALU_Z <= z_in and Z_int;
                else
                    ALU_Z <= z_in;
            end if;

            if(ALU_J = "11") then
                if(A = B) then
                    Z_int <= '1';
                else
                    Z_int <= '0';
                end if;
                ALU_C <= c_in;
                ALU_Z <= z_in;
            end if;

            else
                null;
        end if;
    end process;
end architecture behavioural;

