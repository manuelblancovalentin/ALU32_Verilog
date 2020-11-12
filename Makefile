TOP_MODULE = ALU_tb

WORK_LIB = work

XRUN = xrun
XGEN = genus
COMPILER = iverilog #xmverilog

PROJ_DIR = /home/mvalentin/ECE361_ALU_32
BASE_DIR = $(PROJ_DIR)/src
LIB_DIR = $(BASE_DIR)/eecs361lib_alu_Verilog/lib
GENUS_TCL = $(PROJ_DIR)/genus_synthesis.tcl

VPATH :=
VPATH += $(BASE_DIR)
VPATH += $(LIB_DIR)

V_SOURCES :=
V_SOURCES += $(BASE_DIR)/ALU_tb.v
V_SOURCES += $(BASE_DIR)/logic_unit_32.v
V_SOURCES += $(BASE_DIR)/full_fast_adder.v
V_SOURCES += $(BASE_DIR)/comparison_unit_32.v
V_SOURCES += $(BASE_DIR)/arithmetic_unit_32.v
V_SOURCES += $(BASE_DIR)/shift_unit_32.v
V_SOURCES += $(BASE_DIR)/mux4to1_32.v
V_SOURCES += $(BASE_DIR)/mux2to1_32.v
V_SOURCES += $(BASE_DIR)/nor_gate_32to1.v

V_SOURCES += $(LIB_DIR)/and_gate_32.v
V_SOURCES += $(LIB_DIR)/or_gate_32.v
V_SOURCES += $(LIB_DIR)/nor_gate_32.v
V_SOURCES += $(LIB_DIR)/not_gate_32.v
V_SOURCES += $(LIB_DIR)/xor_gate_32.v
V_SOURCES += $(LIB_DIR)/xor_gate.v
V_SOURCES += $(LIB_DIR)/and_gate.v
V_SOURCES += $(LIB_DIR)/nor_gate.v
V_SOURCES += $(LIB_DIR)/or_gate.v
V_SOURCES += $(LIB_DIR)/not_gate.v
V_SOURCES += $(LIB_DIR)/mux_32.v
V_SOURCES += $(LIB_DIR)/mux.v

V_HLS := $(V_SOURCES)
V_HLS += $(BASE_DIR)/ALU_32.v

V_SYN := $(V_SOURCES)
V_SYN += $(PROJ_DIR)/Synthesis/ALU_32_syn.v
V_SYN += $(BASE_DIR)/cad/NangateOpenCellLibrary.v


CAD_LIB = /cad/library/TSMC/TSMC65_LP/Base_PDK/digital/Front_End/verilog/tcbn65lp_200a/tcbn65lp.v


.SUFFIXES: .v .sv

setup: $(WORK_LIB)


run-synthesis: 
	$(XGEN) -files $(GENUS_TCL) $^
.PHONY: run-synthesis


run-post-hls: $(V_HLS)
	$(XRUN) -access rwc -gui $^
.PHONY: run-post-hls

run-post-syn: $(V_SYN)
	$(XRUN) -access rwc -gui $^
.PHONY: run-post-syn

clean:
	rm -rf xcelium.d xrun* *.vcd waves.shm *.diag *.err *.log* *.cmd* fv*
.PHONY: clean