# TODO: Register all inputs and outputs of the BCD2bin 

#source Synopsys Design Compiler 

# source /CMC/scripts/synopsys.syn.2022.12.csh 

#  

# run dc_shell on command line with this tcl script passed 
# dc_shell -f dc_shell_syn_freepdk45.tcl 
# if dc_shell is already running 
# source dc_shell_syn_freepdk45.tcl 

# specify libraries 

set target_library "~/mydata/04_syn_freepdk45/pdk_files/gscl45nm.db" 

set symbol_library "generic.sdb" 

set synthetic_library "dw_foundation.sldb standard.sldb" 

set link_library "~/mydata/04_syn_freepdk45/pdk_files/gscl45nm.db dw_foundation.sldb standard.sldb" 

# read design 
# analysis and elaboration are done automatically 

read_file {./bin2bcd.v} -autoread -format verilog -top bin2bcd

# set design environment 

set_operating_conditions "typical" 
#set_wire_load_model top 
#set_drive default [all_inputs] 
#set_load default [all_outputs] 

# set clock constraints 

create_clock -period 0.9 i_clk
#set_clock_latency default clk 
#set_input_delay default -clock clk [all_inputs] 
#set_output_delay default -clock clk [all_outputs] 

# set design constraints 

#set_max_transition default [get_designs Single_Cycle_Top] 
#set_max_fanout default [all_inputs] 
#set_fanout_load default [all_outputs] 
set_max_capacitance 100000 [all_outputs] 
#set_max_area default


# compile 

compile 

# report design metrics 

report_area 
report_timing 
report_power 
report_constraint

exit
