module logic_unit_32(A, B, lu_ctl, z);
	input [31:0] A;
	input [31:0] B;
	input [1:0] lu_ctl;
	output wire [31:0] z;

	// Create internal wiring for and, or, xor, nor results.
	wire [31:0] and_z;
	wire [31:0] or_z;
	wire [31:0] xor_z;
	wire [31:0] nor_z;

	// AND (A & B) using and_gate_32.v
	and_gate_32 and_g1(.x(A), .y(B), .z(and_z));

	// OR (A | B) using or_gate_32.v
	or_gate_32 or_g2(.x(A), .y(B), .z(or_z));

	// XOR (A ^ B) using xor_gate_32.v
	xor_gate_32 xor_g3(.x(A), .y(B), .z(xor_z));

	// NOR ~(A | B) using nor_gate_32.v
	nor_gate_32 nor_g4(.x(A), .y(B), .z(nor_z));

	// Connect a 4to1 mux to select from AND/OR/XOR/NOR operations
	mux4to1_32 logic_unit_mux(.sel(lu_ctl), .src0(and_z), .src1(or_z), .src2(xor_z), .src3(nor_z), .z(z));

endmodule