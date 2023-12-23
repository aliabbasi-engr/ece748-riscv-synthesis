# source Synopsys Design Compiler
# source /CMC/scripts/synopsys.syn.2022.12.csh
# 
# run dc_shell on command line with this tcl script passed
# dc_shell -f dc_shell_syn_sky130.tcl
# if dc_shell is already running
# source dc_shell_syn_sky130.tcl

# specify libraries
set target_library "./skywater/stdcells.db ./pdk_files/SRAM_32x64_1rw_TT_1p1V_25C.db"
set symbol_library "generic.sdb"
set synthetic_library "dw_foundation.sldb standard.sldb"
set link_library "./skywater/stdcells.db ./pdk_files/SRAM_32x64_1rw_TT_1p1V_25C.db  dw_foundation.sldb standard.sldb"

# read design
# analysis and elaboration are done automatically
read_file {./rtl/sources_1} -autoread -format verilog -top Single_Cycle_Top

# set design environment
set_operating_conditions "typical"
set_wire_load_model top
set_drive 0.01 [all_inputs]
set_load 0.01 [all_outputs]

# set clock constraints
create_clock -period 6 clk
set_clock_latency 0.01 clk
set_input_delay 0.02 -clock clk [all_inputs]
set_output_delay 0.01 -clock clk [all_outputs]

# set design constraints
set_max_transition 2000 [get_designs Single_Cycle_Top]
set_max_fanout 100 [all_inputs]
set_fanout_load 0.001 [all_outputs]
set high_fanout_net_threshold 100
set_max_capacitance 50000 [all_outputs]
set_max_area 250000

# resolve multiple refenreces
uniquify

# compile
compile

# check design for errors/warnings
# uplevel #0 check_design

# check all i/o properties
# report_port

# report design metrics
report_area
report_timing
report_power
report_constraint

# generate sdc file
write_sdc ./Single_Cycle_Top_syn.sdc -version 1.8

# generate sdf file
write_sdf -version 2.1 -context verilog -load_delay cell ./Single_Cycle_Top_syn.sdf

# generate verilog netlist
write -hierarchy -format verilog -output ./Single_Cycle_Top_syn.v
