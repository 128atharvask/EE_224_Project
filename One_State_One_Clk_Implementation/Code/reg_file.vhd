library ieee;
use ieee.std_logic_1164.all;

entity reg_file is 
    port(
        A1 : in std_logic_vector(2 downto 0);	--select lines for read
        A2 : in std_logic_vector(2 downto 0);	--select lines for read
        A3 : in std_logic_vector(2 downto 0);	--select lines for write
        D3 : in std_logic_vector(15 downto 0);	-- input data
        RF_WR : in std_logic;   --write enable
		  PC_E : in std_logic;
        clk : in std_logic;
        D1 : out std_logic_vector(15 downto 0);	--output data
        D2 : out std_logic_vector(15 downto 0)	--output data
    );
end entity;

architecture rf of reg_file is    
    signal R0 : std_logic_vector(15 downto 0) := "0000000000000000";    
    signal R1 : std_logic_vector(15 downto 0) := "0000000000000001";    
    signal R2 : std_logic_vector(15 downto 0) := "0000000000000010";    
    signal R3 : std_logic_vector(15 downto 0) := "0000000000000011";    
    signal R4 : std_logic_vector(15 downto 0) := "0000000000000100";    
    signal R5 : std_logic_vector(15 downto 0) := "0000000000000101";    
    signal R6 : std_logic_vector(15 downto 0) := "0000000000000110";    
    signal R7 : std_logic_vector(15 downto 0) := "0000000000000000";  --PC
begin
    --writing to register when RF_WR is set
    write_proc: process(clk)
    begin
        if (clk'event and clk = '1') then  --writing at positive clock edge
            if(RF_WR = '1') then
                if(A3 = "000") then
                    R0 <= D3;
                elsif(A3 = "001") then
                    R1 <= D3;
                elsif(A3 = "010") then
                    R2 <= D3;
                elsif(A3 = "011") then
                    R3 <= D3;
                elsif(A3 = "100") then
                    R4 <= D3;
                elsif(A3 = "101") then
                    R5 <= D3;
                elsif(A3 = "110") then
                    R6 <= D3;
				else null;
                end if;
            else null;
            end if;
				if(PC_E = '1' and A3 = "111") then
					R7 <= D3;
                else null;
				end if;
        end if;
    end process write_proc;

    --reading from the registers
    read_proc: process(A1,A2,R0,R1,R2,R3,R4,R5,R6,R7)
    begin
        if(A1 = "000") then
            D1 <= R0;
        elsif(A1 = "001") then
            D1 <= R1;
        elsif(A1 = "010") then
            D1 <= R2;
        elsif(A1 = "011") then
            D1 <= R3;	
        elsif(A1 = "100") then
            D1 <= R4;
        elsif(A1 = "101") then
            D1 <= R5;
        elsif(A1 = "110") then
            D1 <= R6;
        elsif(A1 = "111") then
            D1 <= R7;
        else null;
        end if;
        --Address 2
        if(A2 = "000") then
            D2 <= R0;
        elsif(A2 = "001") then
            D2 <= R1;
        elsif(A2 = "010") then
            D2 <= R2;
        elsif(A2 = "011") then
            D2 <= R3;
        elsif(A2 = "100") then
            D2 <= R4;
        elsif(A2 = "101") then
            D2 <= R5;
        elsif(A2 = "110") then
            D2 <= R6;
        elsif(A2 = "111") then
            D2 <= R7;
        else null;
        end if;
    end process read_proc;
	 
end rf;