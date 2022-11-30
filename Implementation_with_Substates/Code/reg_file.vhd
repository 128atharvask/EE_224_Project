library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity reg_file is 
    port(
        A1 : in std_logic_vector(2 downto 0);	-- select lines for read
        A2 : in std_logic_vector(2 downto 0);	-- select lines for read
        A3 : in std_logic_vector(2 downto 0);	-- select lines for write
        D3 : in std_logic_vector(15 downto 0);	-- input data
        RF_WR : in std_logic;   -- write enable
		  PC_E : in std_logic;    -- PC enable
        clk : in std_logic;     -- clock
        D1 : out std_logic_vector(15 downto 0);	-- output data
        D2 : out std_logic_vector(15 downto 0)	-- output data
    );
end entity;

architecture rf of reg_file is

	 -- these signals are the registers in this register file
    signal R0 : std_logic_vector(15 downto 0) := "0000000000000000";    -- 6401
    signal R1 : std_logic_vector(15 downto 0) := "0000000000000000";    -- -6432 	
    signal R2 : std_logic_vector(15 downto 0) := "0000000000000000";    -- 192
    signal R3 : std_logic_vector(15 downto 0) := "0000000000000000";    -- 3584
    signal R4 : std_logic_vector(15 downto 0) := "0000000000000000";    -- 16424
    signal R5 : std_logic_vector(15 downto 0) := "0000000000000000";    -- -32496
    signal R6 : std_logic_vector(15 downto 0) := "0000000000000000";    -- -6
    signal R7 : std_logic_vector(15 downto 0) := "0000000000000000";    --PC
begin
    --writing to register when RF_WR is set
    write_proc: process(A3,RF_WR,PC_E,clk)
    begin
        if (clk'event and clk = '1') then  --writing at positive clock edge
            if(RF_WR = '1') then
                if(A3 = "000") then
                    R0 <= D3;
					 end if;
                if(A3 = "001") then
                    R1 <= D3;
					 end if;
                if(A3 = "010") then
                    R2 <= D3;
					 end if;
                if(A3 = "011") then
                    R3 <= D3;
					 end if;
                if(A3 = "100") then
                    R4 <= D3;
					 end if;
                if(A3 = "101") then
                    R5 <= D3;
					 end if;
                if(A3 = "110") then
                    R6 <= D3;
					 end if;
					 if(A3 = "111") then
                    R7 <= D3;
                end if;
            end if;
				if(PC_E = '1' and A3 = "111") then
					R7 <= D3;
				end if;
        end if;
    end process write_proc;

    --reading from the registers
    read_proc: process(A1,A2,RF_WR,PC_E)
    begin
        if(A1 = "000") then
            D1 <= R0;
		  end if;
        if(A1 = "001") then
            D1 <= R1;
		  end if;
        if(A1 = "010") then
            D1 <= R2;
		  end if;
        if(A1 = "011") then
            D1 <= R3;
		  end if;
        if(A1 = "100") then
            D1 <= R4;
		  end if;
        if(A1 = "101") then
            D1 <= R5;
		  end if;
        if(A1 = "110") then
            D1 <= R6;
		  end if;
        if(A1 = "111") then
            D1 <= R7;
        end if;
        --Address 2
        if(A2 = "000") then
            D2 <= R0;
		  end if;
        if(A2 = "001") then
            D2 <= R1;
		  end if;
        if(A2 = "010") then
            D2 <= R2;
		  end if;
        if(A2 = "011") then
            D2 <= R3;
		  end if;
        if(A2 = "100") then
            D2 <= R4;
		  end if;
        if(A2 = "101") then
            D2 <= R5;
		  end if;
        if(A2 = "110") then
            D2 <= R6;
		  end if;
        if(A2 = "111") then
            D2 <= R7;
        end if;
    end process read_proc;
end rf;