library ieee;
use ieee.std_logic_1164.all;

entity Main is
   port ();
end entity;

architecture controller of Main is

type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,s21);

signal sp,sn: state := s0;

signal FC, FC: std_logic := '0';

signal ALU_A, ALU_B, ALU_S, D1, D2, D3, M_add, M_data_in, M_data_out, t1_Din, t1_Dout t2_Din, t2_Dout, t3_Din, t3_Dout: std_logic_vector(15 downto 0);
signal clock, ALU_C, ALU_Z, Z_int, RF_WR, PC_E, MWR, MDR, reset: std_logic;
signal ALU_J, ALU_CND: std_logic_vector(1 downto 0);
signal A1, A2, A3, t1_A, t2_A, t3_A: std_logic_vector(2 downto 0);

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

end ALU;

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
end reg_file;

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
end memory;

component t_star is
   port(
      A : in std_logic_vector(2 downto 0);   --select lines for read
      D_in : in std_logic_vector(15 downto 0);  -- input data
      T_en : in std_logic;   --write enable
      D_out : out std_logic_vector(15 downto 0); --output data
   );
end reg_file;


begin

   M1: memory port map ();
   ALU1: ALU port map ();
   RF1: reg_file port map ();
   T1: t_star port map ();
   T2: t_star port map ();
   T3: t_star port map ();

