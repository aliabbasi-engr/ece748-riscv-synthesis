#!/bin/bash
# check if argument supplied
if [ "$#" -eq 0 ]; then
	echo "Please enter your parameters as command line arguments"
	exit 1
fi

# create output file
echo "Param, Fmax, Area, Power" > results.csv

# loop through supplied parameters
for param in "$@"; do
	echo "parameter: $param"
	# modify testbench file to change parameter
	sed -i "s/W = [0-9]\+/W = $param/" bin2bcd.v
	# run file and scrape statistics
	clk_period=0.1
	while true; do
		echo "testing clock period: $clk_period"
		sed -i "s/^create_clock -period.*/\
create_clock -period $clk_period i_clk/" part_3.tcl
		dc_shell -f part_3.tcl > log.tmp
		max_c=$(cat log.tmp | grep 'max_capacitance' | tail -n 1 \
			| awk '{print $3}')
		max_ds=$(cat log.tmp | grep 'max_delay/setup' | tail -n 1\
			| awk '{print $3}')
		seq_clk_w=$(cat log.tmp | grep 'sequential_clock_pulse_width'\
			| tail -n 1 | awk '{print $3}')
		c_range=$(cat log.tmp | grep 'critical_range' | tail -n 1\
			| awk '{print $3}')
		if [[ "$max_c" == "(MET)"  && \
			 "$max_ds" == "(MET)" && \
			 "$seq_clk_w" == "(MET)" && \
			 "$c_range" == "(MET)" ]]; then
			# passing condition;  calculate Fmax
			echo "conditions passed, writing to file"
			#f_max=$(printf "%.0f" "echo "scale=2; (1 / $clk_period)*1000" | bc)
			f_max=$(printf "%.0f" \
				"$(echo "scale=10; (1 / $clk_period) * 1000" | bc)")
			# also get Area
			area=$(cat log.tmp | grep 'Total cell area' \
				| awk '{printf "%.2f\n", $NF}')
			# get Power
			power=$(cat log.tmp \
				| grep 'Total Dynamic Power' \
				| awk '{printf "%.2f\n", $5}')
			# print line to file
			echo "$param, $f_max, $area, $power" \
				>> results.csv
			break	
		fi
		clk_period=$(echo "$clk_period + 0.1" | bc | sed 's/^\./0./')
	done	
done
