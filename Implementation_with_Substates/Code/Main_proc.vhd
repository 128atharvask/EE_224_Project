library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;
use ieee.numeric_std.all;

entity Main_proc is
   port (clock: in std_logic; 
      stop_condition: out std_logic);
end entity;

architecture controller of Main_proc is

-- state type signals
signal sp : state := init; -- present state signal
signal sn : state := s0a; -- next state signal

-- integer type signal
signal counter : integer := 0; -- counter for LM and SM instructions

-- 1 bit signals
signal ALU_C, ALU_Z, Z_int: std_logic := '0'; --ALU secondary o/p
signal RF_WR, PC_E, T1_E, T2_E, T3_E, MWR, MDR: std_logic := '0'; -- control signals

-- 2 bit signals
signal ALU_J, ALU_CND: std_logic_vector(1 downto 0) := (others => '0'); -- ALU condition inputs
signal condcode : std_logic_vector(1 downto 0):= (others => '0'); -- stores condition code

-- 3 bit signals
signal A1, A2, A3: std_logic_vector(2 downto 0) := (others => '0'); -- Address i/p of RF

-- 4 bit signal
signal temp : std_logic_vector(3 downto 0) := (others => '0'); -- stores value temporarily for counter
signal icode : std_logic_vector(3 downto 0):= (others => '0'); -- stores opcode

-- 16 bit signal vectors
signal FC, FZ: std_logic := '0'; -- Carry and Zero Flags
signal ALU_A, ALU_B, ALU_S: std_logic_vector(15 downto 0) := (others => '0'); -- ALU Main i/p and o/p
signal M_add, M_data_in, M_data_out: std_logic_vector(15 downto 0) := (others => '0'); -- Memory i/p and o/p
signal T1_in, T1_out, T2_in, T2_out, T3_in, T3_out:
					std_logic_vector(15 downto 0):= (others => '0'); -- Temporary Register i/p and o/p
signal D1, D2, D3: std_logic_vector(15 downto 0) := (others => '0'); -- Data i/p and o/p of RF


component ALU is
   generic(operand_width : integer:=16);

	port(
    -- inputs
        ALU_A, ALU_B:in std_logic_vector((operand_width - 1) downto 0);
		  clock, c_in, z_in:in std_logic;
        ALU_J, ALU_CND:in std_logic_vector(1 downto 0);

    -- outputs
		  ALU_C, ALU_Z, Z_int: out std_logic;
        ALU_S: out std_logic_vector((operand_width - 1) downto 0)
        );
end component ALU;

component reg_file is
   port(
        A1 : in std_logic_vector(2 downto 0);	-- select lines for read
        A2 : in std_logic_vector(2 downto 0);	-- select lines for read
        A3 : in std_logic_vector(2 downto 0);	-- select lines for write
        D3 : in std_logic_vector(15 downto 0);	-- input data
        RF_WR : in std_logic;      -- write enable
		  PC_E : in std_logic;       -- PC enable
        clk : in std_logic;        -- clock
        D1 : out std_logic_vector(15 downto 0);	-- output data
        D2 : out std_logic_vector(15 downto 0)	-- output data
    );
end component reg_file;

component memory is
   port(
      clk : in std_logic; -- clock
      MWR : in std_logic; -- write enable
      MDR : in std_logic; -- read enable
      M_add : in std_logic_vector(15 downto 0); -- 16 bit address
      M_data_in : in std_logic_vector(15 downto 0); -- data input to the memory
      M_data_out : out std_logic_vector(15 downto 0) -- data output from the memory
   );
end component memory;

component temp_regs is	
	port(
		E : in std_logic; -- write enable
		D_in : in std_logic_vector(15 downto 0);	-- input data
		D_out : out std_logic_vector(15 downto 0)	-- output data
		);
end component temp_regs;


begin
	
	-- component instantiations
   M1: memory port map (clock, MWR, MDR, M_add, M_data_in, M_data_out);
   ALU1: ALU port map (ALU_A, ALU_B, clock, FC, FZ, ALU_J, ALU_CND, ALU_C, ALU_Z, Z_int, ALU_S);
   RF1: reg_file port map (A1, A2, A3, D3, RF_WR, PC_E, clock, D1, D2);
	T1: temp_regs port map (T1_E, T1_in, T1_out);
	T2: temp_regs port map (T2_E, T2_in, T2_out);
	T3: temp_regs port map (T3_E, T3_in, T3_out);
	
	
	icode <= T1_out(15 downto 12);
condcode <= T1_out(1 downto 0);


-- clock process for state transition
clock_proc:process(clock)
begin

	if(clock='1' and clock' event) then
	sp <= sn;
	end if;
	
end process clock_proc;

-- state transition process to decide the next state
state_transition_proc : process (sp,condcode,icode)
begin


case sp is

	when s0a =>
	sn <= s0b;

	when s0b =>
	sn <= s0c;
 
	when s0c =>
	if icode = "1100" then
	sn <= s2a;

	elsif icode = "1000" then
	sn <= s8a;

	elsif icode = "1001" then
	sn <= s8a;

	else 
	sn <= s1a;
	end if;

	when s1a =>
	sn <= s1b;

	when s1b =>
	if icode = "0001" then
	sn <= s5a;

	elsif icode = "0011" then
	sn <= s11;

	elsif icode = "0111" then
	sn <= s16a;

	elsif icode = "0110" then
	sn <= s16a;

	else
	sn <= s2a;
	end if;

	when s2a =>
	sn <= s2b;

	when s2b =>
	if icode = "0100" then
	sn <= s12a;

	elsif icode = "0101" then
	sn <= s12a;

	elsif icode = "1100" then
	sn <= s6a;

	else

		if condcode = "00" then
		sn <= s3a;

		elsif (FC='1') then		--FC is the value of flag register
			if(condcode = "10") then
			sn <= s3a;					
			else
			sn <= s0a;
			end if;
		
		elsif (FZ='1') then		--FZ is the value of zero register
			if(condcode = "01") then
			sn <= s3a;					
			else
			sn <= s0a;
			end if;
					
		else
		sn <= s0a;
		end if;
	end if;
	
	when s3a =>
	sn <= s3b;

	when s3b =>
	sn <= s4;

	when s4 =>
	sn <= s0a;

	when s5a =>
	sn <= s5b;

	when s5b =>
	sn <= s3a;
	
	when s6a =>
	sn <= s6b;	

	when s6b =>
	sn <= s7a;

	when s7a =>
	sn <= s7b;

	when s7b =>
	sn <= s7c;

	when s7c =>
	sn <= s0a;
	
	when s8a =>
	sn <= s8b;

	when s8b =>
	if icode = "1000" then
	sn <= s9a;

	else
	sn <= s10a;
	end if;
	
	when s9a =>
	sn <= s9b;
	
	when s9b=>
	sn <= s9c;
	
	when s9c =>
	sn <= s0a;
	
	when s10a=>
	sn <= s10b;
	
	when s10b =>
	sn <= s0a;

	when s11 =>
	sn <= s0a;
	
	when s12a =>
	sn <= s12b;
	
	when s12b =>
	if icode = "0100" then
	sn <= s14a;

	else
	sn <= s13;
	end if;



	when s13 =>
	sn <= s0a;
	
	when s14a =>
	sn <= s14b;

	when s14b =>
	sn <= s15;

	when s15 =>
	sn <= s0a;
	
	when s16a =>
	sn <= s16b;
	
	when s16b =>
	if icode = "0111" then 
	sn <= s17a;
	else 
	sn <= s19a;
	end if;

	when s17a =>
	sn <= s17b;
	
	when s17b =>
	sn <= s18a;
	
	when s18a =>
	sn <= s18b;

	when s18b =>
	if(counter < 8) then
		if icode="0111" then
		sn <= s17a;
		else
		sn <= s19a;
	end if;
	
	else
	sn <= s0a;
	end if;
	
	when s19a =>
	sn <= s19b;
	
	when s19b =>
	sn <= s18a;

	when others=>
	sn<= s0a;
end case;

end process;


	-- connections process for datapath based on present state
   connections: process(sp,clock)
	begin
		case sp is
		
		when s0a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= "111";
			
		when s0b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '1';
		
			M_add <= D1;
			
		when s0c =>
			PC_E <= '0';
			T1_E <= '1';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T1_in <= M_data_out;
			
		when s1a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= "111";
			ALU_A <= D1;
			ALU_B <= "0000000000000001";
			ALU_J <= "00";
			ALU_CND <= "11";
			
		when s1b =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= "111";
			D3 <= ALU_S;
			
		when s2a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= T1_out(11 downto 9);
			A2 <= T1_out(8 downto 6);
			
		when s2b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T2_in <= D1;
			T3_in <= D2;
			
		when s3a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= T2_out;
			ALU_B <= T3_out;
			ALU_J <= T1_out(14 downto 13);
			ALU_CND <= T1_out(1 downto 0);
		
		when s3b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T2_in <= ALU_S;
			FC <= ALU_C;
			FZ <= ALU_Z;
	   
		when s4 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			
			if (icode = "0001") then A3 <= T1_out(8 downto 6);
			else A3 <= T1_out(5 downto 3);
			end if;
			
			D3 <= T2_out;
			
		when s5a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= T1_out(11 downto 9);
			
		when s5b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T2_in <= D1;
			
			if (T1_out(5) = '0') then T3_in <= "0000000000"&T1_out(5 downto 0);
			else T3_in <= "1111111111"&T1_out(5 downto 0);
			end if;
			
		when s6a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= T2_out;
			ALU_B <= T3_out;
			ALU_J <= "11";
			ALU_CND <= "00";
			
		when s6b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
		
			T2_in <= "000000000000000"&Z_int;
			
		when s7a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';

			A1 <= "111";
			
		when s7b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= D1;
			
			if (T2_out(0) = '0') then ALU_B <= "0000000000000001";
			elsif (T1_out(5) = '0') then ALU_B <= "0000000000"&T1_out(5 downto 0);
			else ALU_B <= "1111111111"&T1_out(5 downto 0);
			end if;
			
			ALU_J <= "00";
			ALU_CND <= "11";
			
		when s7c =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= "111";
			D3 <= ALU_S;
			
		when s8a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= "111";
			
		when s8b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= T1_out(11 downto 9);
			D3 <= D1;
			
		when s9a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= "111";
			
		when s9b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= D1;
			if (T1_out(8) = '0') then ALU_B <= "0000000"&T1_out(8 downto 0);
			else ALU_B <= "1111111"&T1_out(8 downto 0);
			end if;
			ALU_J <= "00";
			ALU_CND <= "11";
			
		when s9c =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= "111";
			D3 <= ALU_S;
			
		when s10a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= T1_out(8 downto 6);
			
		when s10b =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= "111";
			D3 <= D1;
			
		when s11 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= T1_out(11 downto 9);
			D3 <= T1_out(8 downto 0)&"0000000"; --Pad Zeros
			
		when s12a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= T3_out;
			
			if (T1_out(5) = '0') then ALU_B <= "0000000000"&T1_out(5 downto 0);
			else ALU_B <= "1111111111"&T1_out(5 downto 0);
			end if;
			
			ALU_J <= "00";
			ALU_CND <= "11";
			
		when s12b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T3_in <= ALU_S;
			
		when s13 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '1';
			MDR <= '0';
			
			M_add <= T3_out;
			M_data_in <= T2_out;
			
		when s14a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '1';
			
			M_add <= T3_out;
			
		when s14b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T2_in <= M_data_out;
			
		when s15 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			
			A3 <= T1_out(11 downto 9);
			D3 <= T2_out;
			
		when s16a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T2_in <= "0000000000000000";
			A2 <= T1_out(11 downto 9);
			temp <= T2_out(3 downto 0);
			
		when s16b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T3_in <= D2;
			counter <= to_integer(unsigned(temp));
			
		when s17a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= T3_out;
			ALU_B <= "0000000000000001";
			ALU_J <= "00";
			ALU_CND <= "11";
			
			A1 <= T2_out(2 downto 0);
			M_add <= T3_out;
			
		when s17b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= T1_out(counter);
			RF_WR <= '0';
			MWR <= T1_out(counter);
			MDR <= '0';
			
			M_data_in <= D1;
			T3_in <= ALU_S;
			
		when s18a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= T2_out;
			ALU_B <= "0000000000000001";
			ALU_J <= "00";
			ALU_CND <= "11";
			
		when s18b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			T2_in <= ALU_S;
			temp <= T2_out(3 downto 0);
			counter <= to_integer(unsigned(temp));
			
		when s19a =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '1';
			
			M_add <= T3_out;
			ALU_A <= T3_out;
			ALU_B <= "0000000000000001";
			ALU_J <= "00";
			ALU_CND <= "11";
			
		when s19b =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= T1_out(counter);
			RF_WR <= T1_out(counter);
			MWR <= '0';
			MDR <= '0';
			
			A3 <= T2_out(2 downto 0);
			D3 <= M_data_out;
			
			T3_in <= ALU_S;
			
		when others =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
		
		end case;
		
	end process;
	
	-- process to stop simulation when the memory address reaches 64 which is the size of memory
	stop_proc: process(M_add)
	begin
		if (unsigned(M_add) = 128) then
			stop_condition <= '1';
		end if;
	end process;
	
end architecture;