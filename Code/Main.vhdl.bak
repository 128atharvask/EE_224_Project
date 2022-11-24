library ieee;
use ieee.std_logic_1164.all;
use work.DataTypePackage.all;

entity Main is
   port ();
end entity;

architecture controller of Main is

-- type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21);

signal sp,sn: state := s0;
signal null_vec: std_logic_vector(15 downto 0) := (others => '0');

signal ALU_Ain, ALU_Bin, T1in, T2in, T3in, D3in, M_addin, M_data_inin : size22x16 := (others => (others => '0'));
signal ALU_Jin, ALU_CNDin : size22x2 := (others => (others => '0'));
signal A1in, A2in, A3in : size22x3 := (others => (others => '0'));
signal FCin, FZin, RF_WRin, PC_Ein, MDRin, MWRin, T1_Ein, T2_Ein, T3_Ein : std_logic_vector(21 downto 0) := (others => '0');

variable counter : integer := 0;

signal FC, FZ: std_logic := '0';
signal ALU_A, ALU_B, ALU_S, D1, D2, D3, M_add, M_data_in, M_data_out, T1, T2, T3, T_temp: std_logic_vector(15 downto 0) := (others => '0');
signal clock, ALU_C, ALU_Z, Z_int, RF_WR, PC_E, T1_E, T2_E, T3_E, MWR, MDR, reset: std_logic := '0';
signal ALU_J, ALU_CND: std_logic_vector(1 downto 0) := (others => '0');
signal A1, A2, A3, t1_A, t2_A, t3_A: std_logic_vector(2 downto 0) := (others => '0');

component ALU is

   generic(
      operand_width : integer:=16
   );

   port(

   -- inputs
      ALU_A, ALU_B:in std_logic_vector((operand_width - 1) downto 0);
      clk, c_in, z_in:in std_logic;
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

component Mux is
   port(
	inp : in size22x16;
   sel : in state;
   outp : out std_logic_vector(15 downto 0);
   );
end component Mux;

begin

   M1: memory port map (clk, MWR, MDR, reset, M_add, M_data_in, M_data_out);
   ALU1: ALU port map (ALU_A, ALU_B, clock, FC, FZ, ALU_J, ALU_CND, ALU_C, ALU_Z, Z_int, ALU_S);
   RF1: reg_file port map (A1, A2, A3, D3, RF_WR, PC_E, clk, D1, D2);

   
   
   ALU_Ain(1) <= D1; --PC read
   ALU_Ain(7) <= D1; --PC read
   ALU_Ain(9) <= D1; --PC read
   ALU_Ain(3) <= T2;
   ALU_Ain(6) <= T2;
   ALU_Ain(18) <= T2;
   ALU_Ain(21) <= T2;
   ALU_Ain(12) <= T3;
   ALU_Ain(17) <= T3;
   ALU_Ain(20) <= T3;

   ALU_Bin(1) <= "0000000000000001";--"0000000000010000";
   if (T2(0)=0) generate
      ALU_Bin(7) <= "0000000000000001";--"0000000000010000";
   else
      ALU_Bin(7) <= "0000000000"&T1(5 downto 0);
   end if;
   ALU_Bin(20) <= "0000000000000001";--"0000000000010000";
   ALU_Bin(9) <= "0000000"&T1(8 downto 0);
   ALU_Bin(12) <= "0000000000"&T1(5 downto 0);
   ALU_Bin(17) <= "0000000000000001";--"0000000000010000";
   ALU_Bin(18) <= "0000000000000001";
   ALU_Bin(21) <= "0000000000000001";
   ALU_Bin(3) <= T3;
   ALU_Bin(6) <= T3;

   ALU_Jin(1) <= "00";
   ALU_Jin(7) <= "00";
   ALU_Jin(9) <= "00";
   ALU_Jin(12) <= "00";
   ALU_Jin(17) <= "00";
   ALU_Jin(18) <= "00";
   ALU_Jin(20) <= "00";
   ALU_Jin(21) <= "00";
   ALU_Jin(6) <= "11";
   ALU_Jin(3) <= T1(14 downto 13);

   ALU_CNDin(6) <= "00";
   ALU_CNDin(1) <= "11";
   ALU_CNDin(7) <= "11";
   ALU_CNDin(9) <= "11";
   ALU_CNDin(12) <= "11";
   ALU_CNDin(17) <= "11";
   ALU_CNDin(18) <= "11";
   ALU_CNDin(20) <= "11";
   ALU_CNDin(21) <= "11";
   ALU_CNDin(3) <= T1(1 downto 0);



   -- T1in(0) <= M_data_out;

   T2in(2) <= D1;
   T2in(5) <= D1;
   T2in(3) <= ALU_S;
   T2in(18) <= ALU_S;
   T2in(21) <= ALU_S;
   T2in(6) <= "000000000000000"&Z_int;
   T2in(14) <= M_data_out;
   T2in(16) <= "0000000000000000";
   T2in(19) <= "0000000000000000";

   T3in(2) <= D2;
   T3in(16) <= D2;
   T3in(5) <= "0000000000"&T1(5 downto 0);
   T3in(12) <= ALU_S;
   counter := unsigned(T2(2 downto 0));
   if (T1(counter)=1) generate
      T3in(17) <= ALU_S;
   else
      null;
   end if;
   T3in(19) <= D3;
   if (T1(counter)=1) generate
      T3in(20) <= ALU_S;
   else
      null;
   end if;

   A1in(0) <= "111"; --for PC read
   A1in(1) <= "111"; --for PC read
   A1in(7) <= "111"; --for PC read
   A1in(9) <= "111"; --for PC read
   A1in(8) <= "111"; --for PC read
   A1in(2) <= T1(11 downto 9);
   A1in(5) <= T1(11 downto 9);
   A1in(10) <= T1(8 downto 6);
   if (T1(counter)=1) generate
      A1in(17) <= T1(2 downto 0);
   end if;

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
   A3in(19) <= T1(11 downto 9);
   A3in(20) <= T2(2 downto 0);

   D3in(1) <= ALU_S; --PC write
   D3in(7) <= ALU_S; --PC write
   D3in(9) <= ALU_S; --PC write
   D3in(10) <= D1; --PC write
   D3in(4) <= T2;
   D3in(15) <= T2;
   D3in(8) <= D1; --PC read
   D3in(11) <= "0000000"&T1(8 downto 0);
   D3in(20) <= M_data_out;



   M_addin(0) <= D1; --PC read
   M_addin(13) <= T3;
   M_addin(14) <= T3;
   if (T1(counter)=1) generate
      M_addin(17) <= T3;
   else
      null;
   end if;
   M_addin(20) <= T3;
   
   M_data_inin(13) <= T2;
   if (T1(counter)=1) generate
      M_data_inin(17) <= D1;
   else
      null;
   end if;


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
   T2_Ein(19) <= '1';
   T2_Ein(21) <= '1';

   T3_Ein(2) <= '1';
   T3_Ein(5) <= '1';
   T3_Ein(12) <= '1';
   T3_Ein(16) <= '1';
   T3_Ein(17) <= '1';
   T3_Ein(19) <= '1';
   T3_Ein(20) <= '1';


   if (sp = s3) generate
      FC <= ALU_C;
   else
      null; -- FC <= FC
   end if;

   if (sp = s3) generate
      FZ <= ALU_Z;
   else
      null; -- FZ <= FZ
   end if;
   
   RF_WRin(4) <= '1';
   RF_WRin(8) <= '1';
   RF_WRin(11) <= '1';
   RF_WRin(15) <= '1';
   RF_WRin(20) <= T1(counter);

   MDRin(0) <= '1';
   MDRin(14) <= '1';
   MDRin(20) <= '1';

   MWRin(13) <= '1';
   MWRin(17) <= '1';


   
   MuxALU_A : Mux port map (ALU_Ain, sp, ALU_A);
   MuxALU_B : Mux port map (ALU_Bin, sp, ALU_B);
   MuxALU_J : Mux port map (ALU_Jin, sp, ALU_J);
   MuxALU_CND : Mux port map (ALU_CNDin, sp, ALU_CND);

   -- MuxT1 : Mux port map (T1in, sp, T1);

   MuxT1_E : Mux port map (T1_Ein, sp, T1_E);
   MuxT2_E : Mux port map (T2_Ein, sp, T2_E);
   MuxT3_E : Mux port map (T3_Ein, sp, T3_E);

   if (T1_E = 1) generate
      T1 <= M_data_out;
   else
      null;
   end if;
   if (T2_E = 1) generate
      MuxT2 : Mux port map (T2_in, sp, T2);
   else
      null;
   end if;
   if (T3_E = 1) generate
      MuxT3 : Mux port map (T3_in, sp, T3);
   else
      null;
   end if;

   MuxA1 : Mux port map (A1in, sp, A1);
   MuxA2 : Mux port map (A2in, sp, A2);
   MuxA3 : Mux port map (A3in, sp, A3);
   MuxD3 : Mux port map (D3in, sp, D3);

   MuxM_add : Mux port map (M_addin, sp, M_add);
   MuxM_datain : Mux port map (M_data_inin, sp, M_data_in);

   MuxPC_E : Mux port map (PC_Ein, sp, PC_E);
   MuxRF_WR : Mux port map (RF_WRin, sp, RF_WR);
   MuxMDR : Mux port map (MDRin, sp, MDR);
   MuxMWR : Mux port map (MWRin, sp, MWR);
   
   -- connections: process()

   -- begin
