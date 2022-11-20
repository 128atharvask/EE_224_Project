library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
        clk : in std_logic;
        MWR : in std_logic; --write enable bit
        MDR : in std_logic; --read enable bit
        reset : in std_logic; --reset bit
        M_add : in std_logic_vector(15 downto 0);--16 bit address
        M_data_in : in std_logic_vector(15 downto 0); --data input to the memory
        M_data_out : out std_logic_vector(15 downto 0));--data output from the memory
end entity;

architecture memory_arch of memory is
type mem_arr is array( 0 to 65535 ) of std_logic_vector(15 downto 0);
signal data : mem_arr := (others => (others => '0'));
begin
    mem_proc: process(MWR, MDR)
    begin
        if (clk'event and clk = '0') then   --negative clock cycle  
            if (MWR = '1') then
                data(to_integer(unsigned(M_add))) <= M_data_in;
            elsif(MDR = '1') then
                M_data_out <= data(to_integer(unsigned(M_add)));
            end if;
        end if;
    end process mem_proc;
end architecture memory_arch;