library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;
use ieee.numeric_std.all;

entity IITB_CPU is
   port (clk: in std_logic; 
      stop_condition: out std_logic);
end entity;

architecture controller of IITB_CPU is

signal sp : state := init;
signal sn : state := s0;

signal counter : integer := 0;

signal FC, FZ: std_logic := '0';
signal ALU_A, ALU_B, ALU_S, D1, D2, D3, M_add, M_data_in, M_data_out: std_logic_vector(15 downto 0) := (others => '0');
signal clock, ALU_C, ALU_Z, Z_int, RF_WR, PC_E, T1_E, T2_E, T3_E,T4_E, MWR, MDR, reset: std_logic := '0';
signal ALU_J, ALU_CND: std_logic_vector(1 downto 0) := (others => '0');
signal A1, A2, A3: std_logic_vector(2 downto 0) := (others => '0');
signal temp : std_logic_vector(3 downto 0) := (others => '0');

signal icode : std_logic_vector(3 downto 0):= (others => '0'); 					--icode is opcode
signal condcode : std_logic_vector(1 downto 0):= (others => '0'); 				--condcode is condition code
signal T1_in, T2_in, T1_out, T2_out, T3_in, T3_out, T4_in, T4_out: std_logic_vector(15 downto 0) := (others => '0');
signal stateout: std_logic_vector(15 downto 0) := (others => '0');

component ALU is
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
end component ALU;

component reg_file is
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
end component reg_file;

component memory is
    port(
		  clk : in std_logic;
        MWR : in std_logic; --write enable bit
        MDR : in std_logic; --read enable bit
        M_add : in std_logic_vector(15 downto 0);--16 bit address
        M_data_in : in std_logic_vector(15 downto 0); --data input to the memory
        M_data_out : out std_logic_vector(15 downto 0));--data output from the memory
end component;

component temp_regs is	
	port(
		E : in std_logic;
		D_in : in std_logic_vector(15 downto 0);	-- input data
		D_out : out std_logic_vector(15 downto 0)	-- output data
		);
end component;
--begin process of clock and state transition;

begin

	clock <= clk;
	
   M1: memory port map (clock, MWR, MDR, M_add, M_data_in, M_data_out);
   ALU1: ALU port map (ALU_A, ALU_B, clock, FC, FZ, ALU_J, ALU_CND, ALU_C, ALU_Z, Z_int, ALU_S);
   RF1: reg_file port map (A1, A2, A3, D3, RF_WR, PC_E, clock, D1, D2);
	T1: temp_regs port map(T1_E, T1_in, T1_out);
	T2: temp_regs port map(T2_E, T2_in, T2_out);
	T3: temp_regs port map(T3_E, T3_in, T3_out);
	T4: temp_regs port map(T4_E, T4_in, T4_out);
	
	icode <=  T1_out(15 downto 12);
	condcode <= T1_out(1 downto 0);

	
clock_proc:process(clock)
begin

	if(clock='1' and clock' event) then
	sp <= sn;
	end if;
	
end process clock_proc;

state_transition_proc : process (sp,icode,condcode) --make sure whether counter is really needed.
begin

case sp is


	when s0 =>
	if icode = "1100" then
	sn <= s2;

	elsif icode = "1000" then
	sn <= s8;

	elsif icode = "1001" then
	sn <= s8;

	else 
	sn <= s1;
	end if;



	when s1 =>
	if icode = "0001" then
	sn <= s5;

	elsif icode = "0011" then
	sn <= s11;

	elsif icode = "0111" then
	sn <= s16;

	elsif icode = "0110" then
	sn <= s16;

	else
	sn <= s2;
	end if;


	when s2 =>
	if icode = "0100" then
	sn <= s12;

	elsif icode = "0101" then
	sn <= s12;

	elsif icode = "1100" then
	sn <= s6;

	else --main else

	if condcode = "00" then --inner else
	sn <= s3;

	elsif (FC='1') then		--FC is the value of flag register
	if(condcode = "10") then
	sn <= s3;					
	else
	sn <= s0;
	end if;

	elsif (FZ='1') then		--FZ is the value of zero register
	if(condcode = "01") then
	sn <= s3;					
	else
	sn <= s0;
	end if;
					
	else
	sn <= s0;
	end if;--inner if ended
	end if;--main if ended

	when s3 =>
	sn <= s4;

	when s4 =>
	sn <= s0;

	when s5 =>
	sn <= s3;

	when s6 =>
	sn <= s7;

	when s7 =>
	sn <= s0;

	when s8 =>
	if icode = "1000" then
	sn <= s9;

	else
	sn <= s10;
	end if;
	
	when s9 =>
	sn <= s0;

	when s10 =>
	sn <= s0;

	when s11 =>
	sn <= s0;

	when s12 =>
	if icode = "0100" then
	sn <= s14;

	else
	sn <= s13;
	end if;



	when s13 =>
	sn <= s0;

	when s14 =>
	sn <= s15;

	when s15 =>
	sn <= s0;

	when s16 =>
	sn <= set;
	
	when set =>
	if icode = "0111" then 
	sn <= s17;
	else 
	sn <= s19;
	end if;
	
	when s17 =>
	sn <= s18;

	when s18 =>
	if(counter < 8) then
		if icode="0111" then
		sn <= s17;
		else
		sn <= s19;
		end if;
	
	else
	sn <= s0;
	end if;

	when s19 =>
	sn <= s18;

	when others=>
	sn<= s0;
end case;

end process;

	
	--end process of clock and state transition;

	-- this is the process for Data Path;
   connections: process(sp,FC,FZ,D1,A1,T1_E,ALU_S,T1_out,T1_in,T2_in,T3_in,D2,T2_out,T3_out,T4_out,ALU_C,ALU_Z,T2_E,Z_int,M_data_out) 
	begin 
		
		case sp is
		when s0 =>
			PC_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			A1 <= "111";
			M_add <= D1;
			MDR <= '1';
			T1_E <= '1';
			T1_in <= M_data_out;

		when s1 =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= "111";
			ALU_A <= D1;
			ALU_B <= "0000000000000001";
			ALU_J <= "00";
			ALU_CND <= "11";
			A3 <= "111";
			D3 <= ALU_S;
	   
		when s2 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '1';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			A1 <= T1_out(11 downto 9);
			A2 <= T1_out(8 downto 6);
			T2_in <= D1;
			T3_in <= D2;
	   
		when s3 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			ALU_A <= T2_out;
			ALU_B <= T3_out;
			ALU_J <= T1_out(14 downto 13);
			ALU_CND <= T1_out(1 downto 0);
			T4_in <= ALU_S;
			FC <= ALU_C;
			FZ <= ALU_Z;
	   
		when s4 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			if(icode = "0001") then
			A3 <= T1_out(8 downto 6);
			else
			A3 <= T1_out(5 downto 3);
			end if;
			D3 <= T4_out;
	   
		when s5 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '1';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			A1 <= T1_out(11 downto 9);
			T2_in <= D1;
			if (T1_out(5) = '0') then T3_in <= "0000000000"&T1_out(5 downto 0);
			else T3_in <= "1111111111"&T1_out(5 downto 0);
			end if;
	   
		when s6 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			ALU_A <= T2_out;
			ALU_B <= T3_out;
			ALU_J <= "11";
			ALU_CND <= "00";
			T4_in <= "000000000000000"&Z_int;
	   
		when s7 =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			A1 <= "111";
			ALU_A <= D1;
			
			if (T4_out(0) = '0') then ALU_B <= "0000000000000001";
			elsif (T1_out(5) = '0') then ALU_B <= "0000000000"&T1_out(5 downto 0);
			else ALU_B <= "1111111111"&T1_out(5 downto 0);
			end if;
			
			ALU_J <= "00";
			ALU_CND <= "11";
			A3 <= "111";
			D3 <= ALU_S;

		when s8 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			A1 <= "111";
			A3 <= T1_out(11 downto 9);
			D3 <= D1;
	   
		when s9 =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			A1 <= "111";
			ALU_A <= D1;
			if (T1_out(8) = '0') then ALU_B <= "0000000"&T1_out(8 downto 0);
			else ALU_B <= "1111111"&T1_out(8 downto 0);
			end if;
			ALU_J <= "00";
			ALU_CND <= "11";
			A3 <= "111";
			D3 <= ALU_S;
	   
		when s10 =>
			PC_E <= '1';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			A1 <= T1_out(8 downto 6);
			A3 <= "111";
			D3 <= D1;
			
		when s11 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			A3 <= T1_out(11 downto 9);
			D3 <= T1_out(8 downto 0)&"0000000"; --Pad Zeros
	   
		when s12 =>
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
			T4_E <= '1';			--we're using T4 instead of feeding back to T3 in LW and SW
			T4_in <= ALU_S;
	   
		when s13 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '1';
			MDR <= '0';
			M_add <= T4_out;
			M_data_in <= T2_out;
	   
		when s14 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '1';
			M_add <= T4_out;
			T2_in <= M_data_out;
	   
		when s15 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '1';
			MWR <= '0';
			MDR <= '0';
			A3 <= T1_out(11 downto 9);
			D3 <= T2_out;
	   
		when s16 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '1';
			T3_E <= '1';
			T4_E <= '1';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			T2_in <= "0000000000000000";				--T2 is counter
			temp <= T2_out(3 downto 0);
			counter <= to_integer(unsigned(temp));
			
			A2 <= T1_out(11 downto 9);
			T3_in <= D2;									--T3 is memory pointer
			
		when set =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			A1 <= "111";
		   A2 <= "111";
	   
		when s17 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			
			RF_WR <= '0';
			MWR <= '1';
			MDR <= '0';
			
			
			if((counter mod 2) = 0) then			
					T4_E <= '1';
					T3_E <= '0';
					ALU_A <= T3_out;
					ALU_B <= "0000000000000001";
					ALU_J <= "00";
					ALU_CND <= "11";
					if (T1_out(counter)='1') then
						M_add <= T3_out;
						A1 <= std_logic_vector(to_unsigned(counter, 3));
						M_data_in <= D1;
						T4_in <= ALU_S;
					else null;
					end if;
			
			else
					T4_E <= '0';
					T3_E <= '1';
					ALU_A <= T4_out;
					ALU_B <= "0000000000000001";
					ALU_J <= "00";
					ALU_CND <= "11";
					if (T1_out(counter)='1') then
						M_add <= T4_out;
						A1 <= std_logic_vector(to_unsigned(counter, 3));
						M_data_in <= D1;
						T3_in <= ALU_S;
					else null;
					end if;
			end if;
			
			
		when s18 =>
			PC_E <= '0';
			T1_E <= '0';
			T2_E <= '0';
			T3_E <= '0';
			T4_E <= '0';
			RF_WR <= '0';
			MWR <= '0';
			MDR <= '0';
			
			counter <= counter + 1;
			
		when s19 =>

			T1_E <= '0';
			T2_E <= '0';

			RF_WR <= T1_out(counter);
			MWR <= '0';
			MDR <= '1';
			
		
			if(counter = 7 and T1_out(counter) = '1') then
				PC_E <= '1';
			else
				PC_E <= '0';
			end if;
			
			if((counter mod 2) = 0) then
					T3_E <= '0';
					T4_E <= '1';										--T2 will store even values of mem loc; T4 will store odd values
					M_add <= T3_out;
					A3 <= std_logic_vector(to_unsigned(counter, 3));
					D3 <= M_data_out;
					ALU_A <= T3_out;
					ALU_B <= "0000000000000001";
					ALU_J <= "00";
					ALU_CND <= "11";
					if (T1_out(counter) = '1') then
						T4_in <= ALU_S;
					else null;
					end if;
					
			else
					T3_E <= '1';
					T4_E <= '0';										--T2 will store even values of mem loc; T4 will store odd values
					M_add <= T4_out;
					A3 <= std_logic_vector(to_unsigned(counter, 3));
					D3 <= M_data_out;
					ALU_A <= T4_out;
					ALU_B <= "0000000000000001";
					ALU_J <= "00";
					ALU_CND <= "11";
					if (T1_out(counter) = '1') then
						T3_in <= ALU_S;
					else null;
					end if;			
			
			end if;
				
		when others => null;
		end case;
		
	end process;
	
	
	
	-- the process to stop RTL simulation automatically on reaching the last memory location
	stop_proc: process(M_add)
	begin
		if (unsigned(M_add) = 128) then
			stop_condition <= '1';
		end if;
	end process;
	
	
	
end architecture;