library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;
use ieee.numeric_std.all;
use work.Mux.all;

entity Main is
   port (clk: in std_logic; 
      rf_data: out array(0 to 7) of std_logic_vector(15 downto 0));
end entity;

architecture controller of Main is

-- type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21);

signal sp,sn : state := s0;
signal null_vec: std_logic_vector(15 downto 0) := (others => '0');

signal ALU_Ain, ALU_Bin, T1in, T2in, T3in, D3in, M_addin, M_data_inin : size20x16 := (others => (others => '0'));
signal ALU_Jin, ALU_CNDin : size20x2 := (others => (others => '0'));
signal A1in, A2in, A3in : size20x3 := (others => (others => '0'));
signal FCin, FZin, RF_WRin, PC_Ein, MDRin, MWRin, T1_Ein, T2_Ein, T3_Ein : std_logic_vector(19 downto 0) := (others => '0');
signal S7M1, GT1, GT2, GT3 : size2x16 := (others => (others => '0'));
signal S3M1, S3M2, S17M1, S17M2, S19M1 : std_logic_vector(1 downto 0) := (others => '0');
signal condition : std_logic := '0';

signal counter : integer := 0;

signal FC, FZ: std_logic := '0';
signal ALU_A, ALU_B, ALU_S, D1, D2, D3, M_add, M_data_in, M_data_out, T1, T2, T3, T_temp: std_logic_vector(15 downto 0) := (others => '0');
signal clock, ALU_C, ALU_Z, Z_int, RF_WR, PC_E, T1_E, T2_E, T3_E, MWR, MDR, reset: std_logic := '0';
signal ALU_J, ALU_CND: std_logic_vector(1 downto 0) := (others => '0');
signal A1, A2, A3, temp: std_logic_vector(2 downto 0) := (others => '0');

signal icode : std_logic_vector(3 downto 0); --icode is opcode
signal condcode : std_logic_vector(1 downto 0); --icode is condition code

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
      A1 : in std_logic_vector(2 downto 0);   --select lines for read
      A2 : in std_logic_vector(2 downto 0);   --select lines for read
      A3 : in std_logic_vector(2 downto 0);   --select lines for write
      D3 : in std_logic_vector(15 downto 0);  -- input data
      RF_WR : in std_logic;   --write enable
      PC_E : in std_logic;    --PC enable
      clk : in std_logic;
      D1 : out std_logic_vector(15 downto 0); --output data
      D2 : out std_logic_vector(15 downto 0)  --output data
   );
end component reg_file;

component memory is
   port(
      clk : in std_logic;
      MWR : in std_logic; --write enable bit
      MDR : in std_logic; --read enable bit
      reset : in std_logic; --reset bit
      M_add : in std_logic_vector(15 downto 0);--16 bit address
      M_data_in : in std_logic_vector(15 downto 0); --data input to the memory
      M_data_out : out std_logic_vector(15 downto 0)--data output from the memory
   );
end component memory;









--begin process of clock and state transition;

begin

--	clock <= not clock after 10ns ;
	clock <= clk;
	outp <= sp;
   M1: memory port map (clock, MWR, MDR, reset, M_add, M_data_in, M_data_out);
   ALU1: ALU port map (ALU_A, ALU_B, clock, FC, FZ, ALU_J, ALU_CND, ALU_C, ALU_Z, Z_int, ALU_S);
   RF1: reg_file port map (A1, A2, A3, D3, RF_WR, PC_E, clock, D1, D2, rf_data);

	
	
	
	
	icode <=  T1(15 downto 12);--T1 31 downto 28; 
condcode <= T1(1 downto 0);--T1 1 downto 0;

	
clock_proc:process(clock)
begin

	if(clock='1' and clock' event) then
	sp <= sn;
	else null;
	end if;
	
end process clock_proc;

	
	
--sp,sn 



--counter needs to be defined somewhere
state_transition_proc : process (sp,counter) --make sure whether counter is really needed.
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


   
   
   ALU_Ain(1) <= D1; --PC read
   ALU_Ain(7) <= D1; --PC read
   ALU_Ain(9) <= D1; --PC read
   ALU_Ain(3) <= T2;
   ALU_Ain(6) <= T2;
   ALU_Ain(18) <= T2;
   ALU_Ain(12) <= T3;
   ALU_Ain(17) <= T3;
   ALU_Ain(19) <= T3;

   ALU_Bin(1) <= "0000000000000001";--"0000000000010000";
--	S7_1: if (T2(0)='0') generate
--      ALU_Bin(7) <= "0000000000000001";--"0000000000010000";
--	end generate S7_1;
--	S7_2: if (T2(0)='1') generate	
--      ALU_Bin(7) <= "0000000000"&T1(5 downto 0);
--   end generate S7_2;
	S7M1(0) <= "0000000000000001";--"0000000000010000";
	S7M1(1) <= "0000000000"&T1(5 downto 0);
	S7: Mux2x16 port map (S7M1, T2(0), ALU_Bin(7));
   ALU_Bin(19) <= "0000000000000001";--"0000000000010000";
   ALU_Bin(9) <= "0000000"&T1(8 downto 0);
   ALU_Bin(12) <= "0000000000"&T1(5 downto 0);
   ALU_Bin(17) <= "0000000000000001";--"0000000000010000";
   ALU_Bin(18) <= "0000000000000001";
   ALU_Bin(3) <= T3;
   ALU_Bin(6) <= T3;

   ALU_Jin(1) <= "00";
   ALU_Jin(7) <= "00";
   ALU_Jin(9) <= "00";
   ALU_Jin(12) <= "00";
   ALU_Jin(17) <= "00";
   ALU_Jin(18) <= "00";
   ALU_Jin(19) <= "00";
   ALU_Jin(6) <= "11";
   ALU_Jin(3) <= T1(14 downto 13);

   ALU_CNDin(6) <= "00";
   ALU_CNDin(1) <= "11";
   ALU_CNDin(7) <= "11";
   ALU_CNDin(9) <= "11";
   ALU_CNDin(12) <= "11";
   ALU_CNDin(17) <= "11";
   ALU_CNDin(18) <= "11";
   ALU_CNDin(19) <= "11";
   ALU_CNDin(3) <= T1(1 downto 0);



   -- T1in(0) <= M_data_out;

   T2in(2) <= D1;
   T2in(5) <= D1;
   T2in(3) <= ALU_S;
   T2in(18) <= ALU_S;
   T2in(6) <= "000000000000000"&Z_int;
   T2in(14) <= M_data_out;
   T2in(16) <= "0000000000000000";

   T3in(2) <= D2;
   T3in(16) <= D2;
   T3in(5) <= "0000000000"&T1(5 downto 0);
   T3in(12) <= ALU_S;
	temp <= T2(2 downto 0);
   counter <= to_integer(unsigned(temp));
--   S17_1: if (T1(counter)='1') generate
--      T3in(17) <= ALU_S;
--	end generate S17_1;
--   S17_2: if (T1(counter)='0') generate
--      null;
--	end generate S17_2;
--	S17M1(0) <= T3;
--	S17M1(1) <= ALU_S;
--	S17: Mux2x16 port map (S17M1, T1(counter), T3in(17));
	T3in(17) <= ALU_S;
--   S20_1: if (T1(counter)='1') generate
--      T3in(20) <= ALU_S;
--	end generate S20_1;
--   S20_2: if (T1(counter)='0') generate
--      null;
--	end generate S20_2;
--	S20M1(0) <= T3;
--	S20M1(1) <= ALU_S;
--	S20: Mux2x16 port map (S20M1, T1(counter), T3in(20));
	T3in(19) <= ALU_S;

   A1in(0) <= "111"; --for PC read
   A1in(1) <= "111"; --for PC read
   A1in(7) <= "111"; --for PC read
   A1in(9) <= "111"; --for PC read
   A1in(8) <= "111"; --for PC read
   A1in(2) <= T1(11 downto 9);
   A1in(5) <= T1(11 downto 9);
   A1in(10) <= T1(8 downto 6);
--   S17_3: if (T1(counter)='1') generate
--      A1in(17) <= T2(2 downto 0);
--	end generate S17_3;
--	S17_4: if (T1(counter)='0') generate
--		null;
--	end generate S17_4;
	A1in(17) <= T2(2 downto 0);

   A2in(2) <= T1(8 downto 6);
   A2in(16) <= T1(11 downto 9);

   A3in(1) <= "111"; --for PC write
   A3in(7) <= "111"; --for PC write
   A3in(9) <= "111"; --for PC write
   A3in(10) <= "111"; --for PC write
   A3in(4) <= T1(8 downto 6);
   A3in(8) <= T1(11 downto 9);
   A3in(11) <= T1(11 downto 9);
   A3in(15) <= T1(11 downto 9);
   A3in(19) <= T2(2 downto 0);

   D3in(1) <= ALU_S; --PC write
   D3in(7) <= ALU_S; --PC write
   D3in(9) <= ALU_S; --PC write
   D3in(10) <= D1; --PC write
   D3in(4) <= T2;
   D3in(15) <= T2;
   D3in(8) <= D1; --PC read
   D3in(11) <= "0000000"&T1(8 downto 0);
   D3in(19) <= M_data_out;



   M_addin(0) <= D1; --PC read
   M_addin(13) <= T3;
   M_addin(14) <= T3;
--   S17_5: if (T1(counter)='1') generate
--      M_addin(17) <= T3;
--   end generate S17_5;
--	S17_6: if (T1(counter)='1') generate
--		null;
--   end generate S17_6;
	M_addin(17) <= T3;
   M_addin(19) <= T3;
   
   M_data_inin(13) <= T2;
--   S17_7: if (T1(counter)='1') generate
--      M_data_inin(17) <= D1;
--   end generate S17_7;
--   S17_8: if (T1(counter)='0') generate
--      null;
--   end generate S17_8;
	M_data_inin(17) <= D1;


   PC_Ein(1) <= '1';
   PC_Ein(7) <= '1';
   PC_Ein(10) <= '1';

   T1_Ein(0) <= '1';

   T2_Ein(2) <= '1';
   T2_Ein(3) <= '1';
   T2_Ein(5) <= '1';
   T2_Ein(6) <= '1';
   T2_Ein(14) <= '1';
   T2_Ein(16) <= '1';
   T2_Ein(18) <= '1';

   T3_Ein(2) <= '1';
   T3_Ein(5) <= '1';
   T3_Ein(12) <= '1';
   T3_Ein(16) <= '1';
--   T3_Ein(17) <= '1';
	S17M1(0) <= '0';
	S17M1(1) <= '1';
	S17_1: Mux2x1 port map (S17M1, T1(counter), T3_Ein(17));
	
--   T3_Ein(19) <= '1';
	S19M1(0) <= '0';
	S19M1(1) <= '1';
	S19_1: Mux2x1 port map (S19M1, T1(counter), T3_Ein(19));


--   S3_1: if (sp = s3) generate
--      FC <= ALU_C;
--   end generate S3_1;
--	S3_2: if (sp /= s3) generate
--	null; -- FC <= FC
--   end generate S3_2;
	S3M1(0) <= FC;
	S3M1(1) <= ALU_C;
	c_proc: process(sp)
	begin
		if(sp = s3) then
			condition <= '1';
		else
			condition <= '0';
		end if;
	end process;
	S3_1: Mux2x1 port map (S3M1, condition, FC);
	

--   S3_3: if (sp = s3) generate
--      FZ <= ALU_Z;
--   end generate S3_3;
--	S3_4: if (sp /= s3) generate
--      null; -- FZ <= FZ
--   end generate S3_4;
	S3M2(0) <= FZ;
	S3M2(1) <= ALU_Z;
	S3_2: Mux2x1 port map (S3M2, condition, FZ);
   
   RF_WRin(4) <= '1';
   RF_WRin(8) <= '1';
   RF_WRin(11) <= '1';
   RF_WRin(15) <= '1';
   RF_WRin(19) <= T1(counter);

   MDRin(0) <= '1';
   MDRin(14) <= '1';
   MDRin(19) <= '1';

   MWRin(13) <= '1';
--   MWRin(17) <= '1';
	
	S17M2(0) <= '0';
	S17M2(1) <= '1';
	S17_2: Mux2x1 port map (S17M2, T1(counter), MWRin(17));


   
   MuxALU_A : Mux20x16 port map (ALU_Ain, sp, ALU_A);
   MuxALU_B : Mux20x16 port map (ALU_Bin, sp, ALU_B);
   MuxALU_J : Mux20x2 port map (ALU_Jin, sp, ALU_J);
   MuxALU_CND : Mux20x2 port map (ALU_CNDin, sp, ALU_CND);

   -- MuxT1 : Mux port map (T1in, sp, T1);

   MuxT1_E : Mux20x1 port map (T1_Ein, sp, T1_E);
   MuxT2_E : Mux20x1 port map (T2_Ein, sp, T2_E);
   MuxT3_E : Mux20x1 port map (T3_Ein, sp, T3_E);

--   G_T1_1: if (T1_E = '1') generate
--      T1 <= M_data_out;
--	end generate G_T1_1;
--   G_T1_2: if (T1_E = '0') generate
--      null;
--	end generate G_T1_2;
	GT1(0) <= T1;
	GT1(1) <= M_data_out;
	GT1_1: Mux2x16 port map (GT1, T1_E, T1);
	
	
--   G_T2_1: if (T2_E = '1') generate
--      MuxT2 : Mux20x16 port map (T2in, sp, T2);
--	end generate G_T2_1;
--   G_T2_2: if (T2_E = '0') generate
--      null;
--	end generate G_T2_2;
	MuxT2: Mux20x16 port map (T2in, sp, GT2(1));
	GT2(0) <= T2;
	GT2_1: Mux2x16 port map (GT2, T2_E, T2);
	
	
--   G_T3_1: if (T3_E = '1') generate
--      MuxT3 : Mux20x16 port map (T3in, sp, T3);
--	end generate G_T3_1;
--   G_T3_2: if (T3_E = '0') generate
--      null;
--	end generate G_T3_2;
	MuxT3 : Mux20x16 port map (T3in, sp, GT3(1));
	GT3(0) <= T3;
	GT3_1: Mux2x16 port map (GT3, T3_E, T3);

   MuxA1 : Mux20x3 port map (A1in, sp, A1);
   MuxA2 : Mux20x3 port map (A2in, sp, A2);
   MuxA3 : Mux20x3 port map (A3in, sp, A3);
   MuxD3 : Mux20x16 port map (D3in, sp, D3);

   MuxM_add : Mux20x16 port map (M_addin, sp, M_add);
   MuxM_datain : Mux20x16 port map (M_data_inin, sp, M_data_in);

   MuxPC_E : Mux20x1 port map (PC_Ein, sp, PC_E);
   MuxRF_WR : Mux20x1 port map (RF_WRin, sp, RF_WR);
   MuxMDR : Mux20x1 port map (MDRin, sp, MDR);
   MuxMWR : Mux20x1 port map (MWRin, sp, MWR);

end architecture;