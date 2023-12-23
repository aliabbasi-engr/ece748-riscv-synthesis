# specify libraries 
set target_library "./gscl45nm.db" 
set symbol_library "generic.sdb" 
set synthetic_library "dw_foundation.sldb standard.sldb" 
set link_library "./gscl45nm.db dw_foundation.sldb standard.sldb" 

# read design 
# analysis and elaboration are done automatically 
read_file {./binary_to_bcd/sources_1/bin2bcd.v} -autoread -format verilog -top bin2bcd

# set design environment 
set_operating_conditions "typical" 

# set clock constraints 
create_clock -period 0.9 i_clk

# set design constraints
set_max_capacitance 100000 [all_outputs]

# compile 
compile 

# report design metrics 
report_area 
report_timing 
report_power 
report_constraint

exit
