library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.DataTypePackage.all;

-- The Arithmetic and the Logical Unit of IITB-CPU
-- See ALU Documentation in the Report for details regarding inputs and outputs of ALU

entity ALU is

	 generic(operand_width : integer:=16);

    port(
    -- inputs
        ALU_A, ALU_B:in std_logic_vector((operand_width-1) downto 0); -- operand i/p
		  clock, c_in, z_in:in std_logic; -- clock, and carry and zero flag i/p
        ALU_J, ALU_CND:in std_logic_vector(1 downto 0); -- control signals i/p

    -- outputs
		  ALU_C, ALU_Z, Z_int: out std_logic; -- carry and zero flag o/p
        ALU_S: out std_logic_vector((operand_width-1) downto 0) -- operation result
        );

end ALU;

architecture behavioural of ALU is

    -- Ripple Adder Implementation
    function add1(A: in std_logic_vector((operand_width-1) downto 0);
                 B: in std_logic_vector((operand_width-1) downto 0))
    
    return std_logic_vector is
        variable sum: std_logic_vector((operand_width-1) downto 0):= (others => '1');
        variable carry: std_logic_vector((operand_width-1) downto 0) := (others => '0');
		  
    begin
		  L1: for i in 0 to (operand_width-1) loop
			   if (i = 0) then 
				    sum(i) := A(i) xor B(i);
				    carry(i) := A(i) and B(i);
			   else
				    sum(i) := A(i) xor B(i) xor carry(i-1);
				    carry(i) := (A(i) and B(i)) or (carry(i-1) and (A(i) or B(i)));
			   end if;
		  end loop L1;
	     return carry((operand_width-1)) & sum;
    end add1;

	 
    -- Bitwise NAND implementation
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
	
begin

    -- works on the falling edge of the clock
	 clock_proc:process(clock)
    variable sum: std_logic_vector((operand_width-1) downto 0) := "0000000000000000"; -- stores the sum o/p
    variable full_add: std_logic_vector((operand_width) downto 0) := "00000000000000000"; -- stores the full adder o/p
    variable carry: std_logic := '0'; -- stores the carry o/p
    variable bitwise_nand: std_logic_vector((operand_width-1) downto 0) := "0000000000000000"; -- stores the nand o/p
	variable sz_int: std_logic := '0'; -- signal for temporarily storing Z_int
	 begin
		  if(clock='0' and clock'event) then

            -- Case Addition
            if(ALU_J = "00") then
					
                full_add := add1(ALU_A, ALU_B);
                carry := full_add((operand_width));
                sum := full_add((operand_width-1) downto 0);
                ALU_S <= sum;
                if(sum = "0000000000000000") then
                    sz_int := '1';
                else
                    sz_int := '0';
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
            
            -- Case NAND
            elsif(ALU_J = "01") then -- NAND
                bitwise_nand := nander(ALU_A, ALU_B);
                ALU_S <= bitwise_nand;
                if(bitwise_nand = "0000000000000000") then
                    sz_int := '1';
                else
                    sz_int := '0';
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

            -- For BEQ
            elsif(ALU_J = "11") then
                if(ALU_A = ALU_B) then
                    sz_int := '1';
                else
                    sz_int := '0';
                end if;
                ALU_C <= c_in;
                ALU_Z <= z_in;
            else null;
            end if;
		      Z_int <= sz_int;
        end if;
    end process;
	 
end architecture behavioural;