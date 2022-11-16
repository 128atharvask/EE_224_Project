library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
        --clock
        clk : in std_logic;

        --write enable bit
        MWR: in std_logic;

        --read enable bit
        MDR: in std_logic;

        --16 bit address
        M_add : in std_logic_vector(15 downto 0);

        --data input to the memory
        M_data_in: in std_logic_vector(15 downto 0);

        --data output from the memory
        M_data_out: out std_logic_vector(15 downto 0));
    
end entity;

architecture memory_a of memory is
type memory_array is array( 0 to 65535 ) of std_logic_vector(15 downto 0);
signal data : memory_array := (0 => "0000001000000000", 1 => "0010000111001001", others => (others => '1')); --Load with Program

begin
    memory_mod: process(clk)
    begin

        if (clk'event and clk = '0') then  
            if (write_enable = '1') then
                data(to_integer(unsigned(mem_A))) <= mem_Din;
            end if;
        end if;
    end process memory_mod;
            
    mem_Dout <= data(to_integer(unsigned(mem_A)));

	 

	 
end architecture memory_a;