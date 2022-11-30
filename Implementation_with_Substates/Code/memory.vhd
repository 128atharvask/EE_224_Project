library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.DataTypePackage.all;

entity memory is
    port(
        clk : in std_logic; -- clock
        MWR : in std_logic; -- write enable
        MDR : in std_logic; -- read enable
        M_add : in std_logic_vector(15 downto 0);-- 16 bit address
        M_data_in : in std_logic_vector(15 downto 0); -- data input to the memory
        M_data_out : out std_logic_vector(15 downto 0));-- data output from the memory
end entity;

architecture memory_arch of memory is

-- memory is 64 units of 16 bits each
type mem_arr is array(0 to 127) of std_logic_vector(15 downto 0);

-- this signal is the memory
signal data : mem_arr := (
   0 => "1000110001000110", -- JAL, to load location of initial RF data
	1 => "0110000011111111", -- LM, to initialise RF
	
	2 => "0000010011100000", -- ADD
	3 => "0000011101100010", -- ADC
	4 => "0000011101100001", -- ADZ
	5 => "0001000000110000", -- ADI
	6 => "0000001100010010", -- ADC
	7 => "0000001100000001", -- ADZ
	8 => "0010010011010010", -- NDC
	9 => "0001010010010001", -- ADI
	10 => "0010101110000001", -- NDZ
	11 => "0010010011010000", -- NDU
	12 => "0010000011010001", -- NDZ
	13 => "0000011011010000", -- ADD
	14 => "0010010011100010", -- NDC
	15 => "0011000101010100", -- LHI
	16 => "0100000010010000", -- LW
	17 => "0101001010010000", -- SW
	18 => "0100000010010000", -- LW
	19 => "1000100000000010", -- JAL
	21 => "1100111001010100", -- BEQ
	22 => "1100000001000101", -- BEQ
	27 => "1001000010000000", -- JLR
	32 => "0110101000011111", -- LM
	33 => "0111101011111111", -- SM
	34 => "0110101001000011", -- LM
	
	35 => "1000000001011101", -- JAL, jump to 128 (end of memory)
	
	40	=> "0000000000000000", -- 0
	41	=> "0000000000000001", -- 1
	42	=> "0000000000000010", -- 2
	43	=> "0000000000000011", -- 3
	44	=> "0000000000000100", -- 4
	45	=> "0000000000000101", -- 5
	46	=> "0000000000000110", -- 6
	47	=> "0000000000000111", -- 7
	48	=> "0000000000001000", -- 8
	49	=> "1000000000000000", -- -32768
	50	=> "0100000000000000", -- 12384
	51	=> "0010000000000001", -- 8193
	52	=> "0000010000000100", -- 1028
	53	=> "0000010100000000", -- 1280
	54	=> "1110000000000100", -- -8188
	55	=> "0000000001111000", -- 120
	56	=> "0001110000000000", -- 7168
	57	=> "0000000111110000", -- 496
	58	=> "1111111000000000", -- -512
	59	=> "1100000000000011", -- -16381
	60	=> "1110000000000111", -- -8185
	61	=> "0110000000000110", -- 24582
	62	=> "1111111111111111", -- -1
	63	=> "0000000011111111", -- 255
	
	-- To load location of RF data
	70 => "0100000111001000", -- LW
	71 => "0001110110000001", -- ADI
	72 => "1001101110000000", -- JLR
	79 => "0000000001010000", -- 80, location of RF data
	
	-- Values to initialize RF with
	80 => "0000000000010000", --  16
	81 => "1111111111100110", -- -26
	82 => "0000000000001010", --  10
	83 => "0000000000010000", --  16
	84 => "0000000000000000", --   0
	85 => "0000000000101000", --  40
	86 => "0000000000001100", --  12
	87 => "0000000000000010", --   0
    others => (others => '0')); --initialised the remaining to "0000000000000000"
	 
begin
	 
	 -- process to write data to memory
	 write_proc: process(clk)
    begin
        if (clk'event and clk = '1') then   --writing at positive clock cycle  
            if (MWR = '1') then
                data(to_integer(unsigned(M_add))) <= M_data_in;
            end if;
		  end if;
    end process write_proc;
	 
	 -- process to read data from memory
	 read_proc: process(clk)
	 begin
		  if(MDR = '1') then
				M_data_out <= data(to_integer(unsigned(M_add)));
		  end if;
    end process read_proc;
	 
end architecture memory_arch;