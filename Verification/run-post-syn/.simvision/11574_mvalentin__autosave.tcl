
# XM-Sim Command File
# TOOL:	xmsim	18.09-s001
#

set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
alias . run
alias quit exit
database -open -vcd -into dut.vcd _dut.vcd1 -timescale fs
database -open -evcd -into dut.vcd _dut.vcd -timescale fs
database -open -shm -into waves.shm waves -default
probe -create -database waves ALU_32_tb.clk ALU_32_tb.finish_simulation ALU_32_tb.counter ALU_32_tb.op_counter ALU_32_tb.ALU_OP_A ALU_32_tb.ALU_OP_B ALU_32_tb.ALU_OP_OUT ALU_32_tb.expected_result ALU_32_tb.num_errors ALU_32_tb.ALU_OVERFLOW ALU_32_tb.ALU_CARRYOUT ALU_32_tb.ALU_ZERO ALU_32_tb.ALU_CTL

simvision -input /home/mvalentin/ECE361_ALU_32/Verification/run-post-syn/.simvision/11574_mvalentin__autosave.tcl.svcf
