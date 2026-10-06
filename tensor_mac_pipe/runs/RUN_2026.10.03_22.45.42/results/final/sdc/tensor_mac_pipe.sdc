###############################################################################
# Created by write_sdc
# Sat Oct  3 22:47:10 2026
###############################################################################
current_design tensor_mac_pipe
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 4.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[0]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[1]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[2]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[3]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[4]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[5]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[6]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {activation[7]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {reset}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[0]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[1]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[2]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[3]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[4]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[5]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[6]}]
set_input_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {weight[7]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[0]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[10]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[11]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[12]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[13]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[14]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[15]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[1]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[2]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[3]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[4]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[5]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[6]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[7]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[8]}]
set_output_delay 0.8000 -clock [get_clocks {clk}] -add_delay [get_ports {accumulator[9]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {accumulator[15]}]
set_load -pin_load 0.0334 [get_ports {accumulator[14]}]
set_load -pin_load 0.0334 [get_ports {accumulator[13]}]
set_load -pin_load 0.0334 [get_ports {accumulator[12]}]
set_load -pin_load 0.0334 [get_ports {accumulator[11]}]
set_load -pin_load 0.0334 [get_ports {accumulator[10]}]
set_load -pin_load 0.0334 [get_ports {accumulator[9]}]
set_load -pin_load 0.0334 [get_ports {accumulator[8]}]
set_load -pin_load 0.0334 [get_ports {accumulator[7]}]
set_load -pin_load 0.0334 [get_ports {accumulator[6]}]
set_load -pin_load 0.0334 [get_ports {accumulator[5]}]
set_load -pin_load 0.0334 [get_ports {accumulator[4]}]
set_load -pin_load 0.0334 [get_ports {accumulator[3]}]
set_load -pin_load 0.0334 [get_ports {accumulator[2]}]
set_load -pin_load 0.0334 [get_ports {accumulator[1]}]
set_load -pin_load 0.0334 [get_ports {accumulator[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reset}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {activation[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[7]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[6]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[5]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[4]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {weight[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_fanout 10.0000 [current_design]
