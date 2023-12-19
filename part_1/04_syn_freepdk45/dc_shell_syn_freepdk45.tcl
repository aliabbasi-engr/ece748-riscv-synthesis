# source Synopsys Design Compiler
# source /CMC/scripts/synopsys.syn.2022.12.csh
# 
# run dc_shell on command line with this tcl script passed
# dc_shell -f dc_shell_syn_freepdk45.tcl

# specify libraries
set target_library "/home/v60304/mydata/04_syn_freepdk45/pdk_files/SRAM_32x64_1rw_TT_1p1V_25C.db /home/v60304/mydata/04_syn_freepdk45/pdk_files/gscl45nm.db"
set symbol_library "generic.sdb"
set synthetic_library "dw_foundation.sldb standard.sldb"
set link_library "/home/v60304/mydata/04_syn_freepdk45/pdk_files/SRAM_32x64_1rw_TT_1p1V_25C.db /home/v60304/mydata/04_syn_freepdk45/pdk_files/gscl45nm.db dw_foundation.sldb standard.sldb"

# read design
# analysis and elaboration are done automatically
read_file {./rtl/sources_1} -autoread -format verilog -top Single_Cycle_Top

# set design environment
set_operating_conditions "typical"
set_drive 0.1 [all_inputs]
set_load 0.1 [all_outputs]

# set clock constraints
create_clock -period 15 clk
set_clock_latency 0.1 clk
set_input_delay 1.2 -clock clk [all_inputs]
set_output_delay 1.65 -clock clk [all_outputs]

# set design constraints
set_max_transition 200 [get_designs Single_Cycle_Top]
set_max_fanout 10 [all_inputs]
set_fanout_load 8 [all_outputs]
set high_fanout_net_threshold 10
set_max_capacitance 4000 [all_outputs]
set_max_area 40000

# compile
compile

# check design for errors/warnings
# uplevel #0 check_design

# check all i/o properties
# report_port

# report design metrics
# report_area
# report_timing
# report_power
report_constraint

# generate sdc file
# write_sdc ./Single_Cycle_Top_syn.sdc -version 1.8

# generate sdf file
# write_sdf -version 2.1 -context verilog -load_delay cell ./Single_Cycle_Top_syn.sdf

# generate verilog  netlist
# write -hierarchy -format verilog -output ./Single_Cycle_Top_syn.v



