read_hdl ../src/ALU_32.v
read_hdl ../src/arithmetic_unit_32.v
read_hdl ../src/comparison_unit_32.v
read_hdl ../src/full_adder.v
read_hdl ../src/full_fast_adder.v
read_hdl ../src/logic_unit_32.v
read_hdl ../src/mux2to1_32.v
read_hdl ../src/mux4to1_32.v
read_hdl ../src/nor_gate_32to1.v
read_hdl ../src/shift_unit_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/and_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/and_gate.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/mux_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/mux.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/nand_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/nand_gate.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/nor_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/nor_gate.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/not_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/not_gate.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/or_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/or_gate.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/xnor_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/xnor_gate.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/xor_gate_32.v
read_hdl ../src/eecs361lib_alu_Verilog/lib/xor_gate.v
set_db library ../src/cad/NangateOpenCellLibrary_typical.lib
set_db lef_library ../src/cad/NangateOpenCellLibrary.lef
elaborate
current_design ALU_32
read_sdc ../src/ALU_32.sdc
syn_generic
syn_map
syn_opt
report_timing > ALU_32_timing.rpt
report_area > ALU_32_area.rpt
write_hdl > ALU_32_syn.v
quit
