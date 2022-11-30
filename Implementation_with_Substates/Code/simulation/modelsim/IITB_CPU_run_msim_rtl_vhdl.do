transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/SCI/Desktop/EE_224_Project-master/Code/temp_regs.vhd}
vcom -93 -work work {C:/Users/SCI/Desktop/EE_224_Project-master/Code/DataTypePackage.vhdl}
vcom -93 -work work {C:/Users/SCI/Desktop/EE_224_Project-master/Code/Main_proc.vhd}
vcom -93 -work work {C:/Users/SCI/Desktop/EE_224_Project-master/Code/ALU.vhdl}
vcom -93 -work work {C:/Users/SCI/Desktop/EE_224_Project-master/Code/memory.vhd}
vcom -93 -work work {C:/Users/SCI/Desktop/EE_224_Project-master/Code/reg_file.vhd}

