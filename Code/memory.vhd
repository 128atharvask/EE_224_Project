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
type mem_arr is array( 0 to 63 ) of std_logic_vector(15 downto 0);
signal data : mem_arr := (
    -- 0 => "0000010011100000",
    -- 1 => "0000011101100010",
    -- 2 => "0000011101100001",
    -- 3 => "0000101110000000",
    -- 4 => "0000000001001010",
    -- 5 => "0000000010000001",
    
    -- 1000 => "0000000000000000",
    -- 1001 => "0000000000000001",
    -- 1002 => "0000000000000010",
    -- 1003 => "0000000000000011",
    -- 1004 => "0000000000000100",
    -- 1005 => "0000000000000101",
    -- 1006 => "0000000000000110",
    -- 1007 => "0000000000000111",
    -- 1008 => "0000000000001000",
    -- 1009 => "1000000000000000",
    -- 1010 => "0100000000000000",
    -- 1011 => "0010000000000001",
    -- 1012 => "0000010000000100",
    -- 1013 => "0000010100000000",
    -- 1014 => "1110000000000100",
    -- 1015 => "0000000001111000",
    -- 1016 => "0001110000000000",
    -- 1017 => "0000000111110000",
    -- 1018 => "1111111000000000",
    -- 1019 => "1100000000000011",
    -- 1020 => "1110000000000111",
    -- 1021 => "0110000000000110",
    -- 1022 => "1111111111111111",
    -- 1023 => "0000000011111111",
    others => (others => '0'));
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