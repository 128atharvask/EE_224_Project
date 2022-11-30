library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
		  clk : in std_logic;
        MWR : in std_logic; --write enable bit
        MDR : in std_logic; --read enable bit
        M_add : in std_logic_vector(15 downto 0);--16 bit address
        M_data_in : in std_logic_vector(15 downto 0); --data input to the memory
        M_data_out : out std_logic_vector(15 downto 0));--data output from the memory
end entity;

architecture memory_arch of memory is
type mem_arr is array( 0 to 63 ) of std_logic_vector(15 downto 0);
signal data : mem_arr := (
    0 => "0111100000001111",
	 1 => "0110100001111111",
    others => (others => '0'));
begin
    write_proc: process(clk, M_add) 
    begin
		  if (clk'event and clk = '1') then   --positive clock cycle  
			if((not(M_add(15)) and not(M_add(14)) and not(M_add(13)) and not(M_add(12)) and not(M_add(11)) and not(M_add(10)) and not(M_add(9)) and not(M_add(8)) and not(M_add(7)) and not(M_add(6))) = '1') then
            if (MWR = '1') then
                data(to_integer(unsigned(M_add))) <= M_data_in;
            end if;
			else null;
			end if;
		  end if;
    end process write_proc;
	 
	 read_proc: process(MDR, M_add)
	 begin
	 	if((not(M_add(15)) and not(M_add(14)) and not(M_add(13)) and not(M_add(12)) and not(M_add(11)) and not(M_add(10)) and not(M_add(9)) and not(M_add(8)) and not(M_add(7)) and not(M_add(6))) = '1') then
		  if(MDR = '1') then
				M_data_out <= data(to_integer(unsigned(M_add)));
		  end if;
		else null;
		end if;
    end process read_proc;
end architecture memory_arch;