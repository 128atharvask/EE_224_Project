-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "11/24/2022 20:28:31"

-- 
-- Device: Altera 10M25SCE144C8G Package EQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_16,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_18,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_19,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_126,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_129,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_136,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_138,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Main IS
    PORT (
	clk : IN std_logic;
	\outp.s0\ : OUT std_logic;
	\outp.s1\ : OUT std_logic;
	\outp.s2\ : OUT std_logic;
	\outp.s3\ : OUT std_logic;
	\outp.s4\ : OUT std_logic;
	\outp.s5\ : OUT std_logic;
	\outp.s6\ : OUT std_logic;
	\outp.s7\ : OUT std_logic;
	\outp.s8\ : OUT std_logic;
	\outp.s9\ : OUT std_logic;
	\outp.s10\ : OUT std_logic;
	\outp.s11\ : OUT std_logic;
	\outp.s12\ : OUT std_logic;
	\outp.s13\ : OUT std_logic;
	\outp.s14\ : OUT std_logic;
	\outp.s15\ : OUT std_logic;
	\outp.s16\ : OUT std_logic;
	\outp.s17\ : OUT std_logic;
	\outp.s18\ : OUT std_logic;
	\outp.s19\ : OUT std_logic;
	\outp.s20\ : OUT std_logic;
	\outp.s21\ : OUT std_logic
	);
END Main;

-- Design Ports Information
-- clk	=>  Location: PIN_141,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s0	=>  Location: PIN_48,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s1	=>  Location: PIN_91,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s2	=>  Location: PIN_54,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s3	=>  Location: PIN_24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s4	=>  Location: PIN_61,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s5	=>  Location: PIN_135,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s6	=>  Location: PIN_118,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s7	=>  Location: PIN_111,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s8	=>  Location: PIN_120,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s9	=>  Location: PIN_30,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s10	=>  Location: PIN_25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s11	=>  Location: PIN_66,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s12	=>  Location: PIN_45,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s13	=>  Location: PIN_62,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s14	=>  Location: PIN_56,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s15	=>  Location: PIN_98,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s16	=>  Location: PIN_86,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s17	=>  Location: PIN_57,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s18	=>  Location: PIN_44,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s19	=>  Location: PIN_64,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s20	=>  Location: PIN_22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- outp.s21	=>  Location: PIN_110,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Main IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL \ww_outp.s0\ : std_logic;
SIGNAL \ww_outp.s1\ : std_logic;
SIGNAL \ww_outp.s2\ : std_logic;
SIGNAL \ww_outp.s3\ : std_logic;
SIGNAL \ww_outp.s4\ : std_logic;
SIGNAL \ww_outp.s5\ : std_logic;
SIGNAL \ww_outp.s6\ : std_logic;
SIGNAL \ww_outp.s7\ : std_logic;
SIGNAL \ww_outp.s8\ : std_logic;
SIGNAL \ww_outp.s9\ : std_logic;
SIGNAL \ww_outp.s10\ : std_logic;
SIGNAL \ww_outp.s11\ : std_logic;
SIGNAL \ww_outp.s12\ : std_logic;
SIGNAL \ww_outp.s13\ : std_logic;
SIGNAL \ww_outp.s14\ : std_logic;
SIGNAL \ww_outp.s15\ : std_logic;
SIGNAL \ww_outp.s16\ : std_logic;
SIGNAL \ww_outp.s17\ : std_logic;
SIGNAL \ww_outp.s18\ : std_logic;
SIGNAL \ww_outp.s19\ : std_logic;
SIGNAL \ww_outp.s20\ : std_logic;
SIGNAL \ww_outp.s21\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \outp.s0~output_o\ : std_logic;
SIGNAL \outp.s1~output_o\ : std_logic;
SIGNAL \outp.s2~output_o\ : std_logic;
SIGNAL \outp.s3~output_o\ : std_logic;
SIGNAL \outp.s4~output_o\ : std_logic;
SIGNAL \outp.s5~output_o\ : std_logic;
SIGNAL \outp.s6~output_o\ : std_logic;
SIGNAL \outp.s7~output_o\ : std_logic;
SIGNAL \outp.s8~output_o\ : std_logic;
SIGNAL \outp.s9~output_o\ : std_logic;
SIGNAL \outp.s10~output_o\ : std_logic;
SIGNAL \outp.s11~output_o\ : std_logic;
SIGNAL \outp.s12~output_o\ : std_logic;
SIGNAL \outp.s13~output_o\ : std_logic;
SIGNAL \outp.s14~output_o\ : std_logic;
SIGNAL \outp.s15~output_o\ : std_logic;
SIGNAL \outp.s16~output_o\ : std_logic;
SIGNAL \outp.s17~output_o\ : std_logic;
SIGNAL \outp.s18~output_o\ : std_logic;
SIGNAL \outp.s19~output_o\ : std_logic;
SIGNAL \outp.s20~output_o\ : std_logic;
SIGNAL \outp.s21~output_o\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clk <= clk;
\outp.s0\ <= \ww_outp.s0\;
\outp.s1\ <= \ww_outp.s1\;
\outp.s2\ <= \ww_outp.s2\;
\outp.s3\ <= \ww_outp.s3\;
\outp.s4\ <= \ww_outp.s4\;
\outp.s5\ <= \ww_outp.s5\;
\outp.s6\ <= \ww_outp.s6\;
\outp.s7\ <= \ww_outp.s7\;
\outp.s8\ <= \ww_outp.s8\;
\outp.s9\ <= \ww_outp.s9\;
\outp.s10\ <= \ww_outp.s10\;
\outp.s11\ <= \ww_outp.s11\;
\outp.s12\ <= \ww_outp.s12\;
\outp.s13\ <= \ww_outp.s13\;
\outp.s14\ <= \ww_outp.s14\;
\outp.s15\ <= \ww_outp.s15\;
\outp.s16\ <= \ww_outp.s16\;
\outp.s17\ <= \ww_outp.s17\;
\outp.s18\ <= \ww_outp.s18\;
\outp.s19\ <= \ww_outp.s19\;
\outp.s20\ <= \ww_outp.s20\;
\outp.s21\ <= \ww_outp.s21\;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X26_Y34_N8
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X16_Y0_N30
\outp.s0~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \outp.s0~output_o\);

-- Location: IOOBUF_X60_Y14_N16
\outp.s1~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s1~output_o\);

-- Location: IOOBUF_X19_Y0_N23
\outp.s2~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s2~output_o\);

-- Location: IOOBUF_X0_Y15_N16
\outp.s3~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s3~output_o\);

-- Location: IOOBUF_X36_Y0_N30
\outp.s4~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s4~output_o\);

-- Location: IOOBUF_X10_Y21_N16
\outp.s5~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s5~output_o\);

-- Location: IOOBUF_X28_Y36_N2
\outp.s6~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s6~output_o\);

-- Location: IOOBUF_X58_Y36_N9
\outp.s7~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s7~output_o\);

-- Location: IOOBUF_X19_Y21_N23
\outp.s8~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s8~output_o\);

-- Location: IOOBUF_X0_Y10_N2
\outp.s9~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s9~output_o\);

-- Location: IOOBUF_X0_Y15_N23
\outp.s10~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s10~output_o\);

-- Location: IOOBUF_X40_Y0_N2
\outp.s11~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s11~output_o\);

-- Location: IOOBUF_X8_Y0_N9
\outp.s12~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s12~output_o\);

-- Location: IOOBUF_X36_Y0_N9
\outp.s13~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s13~output_o\);

-- Location: IOOBUF_X21_Y0_N23
\outp.s14~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s14~output_o\);

-- Location: IOOBUF_X60_Y22_N16
\outp.s15~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s15~output_o\);

-- Location: IOOBUF_X60_Y10_N2
\outp.s16~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s16~output_o\);

-- Location: IOOBUF_X21_Y0_N2
\outp.s17~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s17~output_o\);

-- Location: IOOBUF_X8_Y0_N16
\outp.s18~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s18~output_o\);

-- Location: IOOBUF_X40_Y0_N30
\outp.s19~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s19~output_o\);

-- Location: IOOBUF_X0_Y16_N23
\outp.s20~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s20~output_o\);

-- Location: IOOBUF_X58_Y36_N2
\outp.s21~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \outp.s21~output_o\);

-- Location: IOIBUF_X8_Y21_N22
\clk~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: UNVM_X0_Y22_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X25_Y34_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X25_Y33_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

\ww_outp.s0\ <= \outp.s0~output_o\;

\ww_outp.s1\ <= \outp.s1~output_o\;

\ww_outp.s2\ <= \outp.s2~output_o\;

\ww_outp.s3\ <= \outp.s3~output_o\;

\ww_outp.s4\ <= \outp.s4~output_o\;

\ww_outp.s5\ <= \outp.s5~output_o\;

\ww_outp.s6\ <= \outp.s6~output_o\;

\ww_outp.s7\ <= \outp.s7~output_o\;

\ww_outp.s8\ <= \outp.s8~output_o\;

\ww_outp.s9\ <= \outp.s9~output_o\;

\ww_outp.s10\ <= \outp.s10~output_o\;

\ww_outp.s11\ <= \outp.s11~output_o\;

\ww_outp.s12\ <= \outp.s12~output_o\;

\ww_outp.s13\ <= \outp.s13~output_o\;

\ww_outp.s14\ <= \outp.s14~output_o\;

\ww_outp.s15\ <= \outp.s15~output_o\;

\ww_outp.s16\ <= \outp.s16~output_o\;

\ww_outp.s17\ <= \outp.s17~output_o\;

\ww_outp.s18\ <= \outp.s18~output_o\;

\ww_outp.s19\ <= \outp.s19~output_o\;

\ww_outp.s20\ <= \outp.s20~output_o\;

\ww_outp.s21\ <= \outp.s21~output_o\;
END structure;


