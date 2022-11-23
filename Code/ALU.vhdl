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
	 signal sz_int: std_logic;
begin

    -- works on the rising edge of the clock
    clock_proc:process(clock,ALU_J, ALU_CND, ALU_A, ALU_B, c_in, z_in)
    begin
        if(clock='1' and clock' event) then
            if(ALU_J = "00") then
                full_add := add(ALU_A, ALU_B);
                carry := full_add((operand_width-1));
                sum := full_add((operand_width-1) downto 0);
                ALU_S <= sum;
                if(sum = "0000000000000000") then
                    sz_int <= '1';
                else
                    sz_int <= '0';
                end if;
                if(ALU_CND = "00") then
                    ALU_C <= carry;
                    ALU_Z <= sz_int;
                elsif(ALU_CND = "10") then
                    ALU_C <= c_in and carry;
                    ALU_Z <= (c_in and sz_int) or ((not c_in) and z_in);
                elsif(ALU_CND = "01") then
                    ALU_C <= (z_in and carry) or ((not z_in) and c_in);
                    ALU_Z <= z_in and sz_int;
                else
                    ALU_C <= c_in;
                    ALU_Z <= z_in;
                end if;
            
            elsif(ALU_J = "01") then
                bitwise_nand := nander(ALU_A, ALU_B);
                ALU_S <= bitwise_nand;
                if(bitwise_nand = "0000000000000000") then
                    sz_int <= '1';
                else
                    sz_int <= '0';
                end if;
                ALU_C <= c_in;
                if(ALU_CND = "00") then
                    ALU_Z <= sz_int;
                elsif(ALU_CND = "10") then
                    ALU_Z <= (c_in and sz_int) or ((not c_in) and z_in);
                elsif(ALU_CND = "01") then
                    ALU_Z <= z_in and sz_int;
                else
                    ALU_Z <= z_in;
                end if;

            elsif(ALU_J = "11") then
                if(ALU_A = ALU_B) then
                    sz_int <= '1';
                else
                    sz_int <= '0';
                end if;
                ALU_C <= c_in;
                ALU_Z <= z_in;
            end if;

        else
            null;
		Z_int <= sz_int;
        end if;
    end process;
end architecture behavioural;


-- Details for MUX:
-- ALU_A : PC: S1, S7, S9
--         T2: S3, S6, S18, S21
--         T3: S12, S17, S20

-- ALU_B : 1: S1, S7, S20
--         T3: S3, S6
--         T1_8-0( with SE9): S9
--         T1_5-0( with SE6): S7
--         1 bit: S18, S21

-- ALU_J : 00: S1, S7, S9, S12, S17, S18, S20, S21
--         11: S6
--         T1_14-13: S3

-- ALU_CND : 00: S6, S20
--           11: S1, S7, S9, S12, S17, S18, S20, S21
--           T1_1-0: S3, 

-- Remember: Modify S12 and S14