module ALU_32(A, B, Z, op_ctl, overflow, zero, carryout);

	// Define our inputs 
	input [31:0] A; 		// 32b Operator A
	input [31:0] B; 		// 32b Operator B
	input [10:0] op_ctl; 	// 11b control bus	

	// Define our outputs
	output wire [31:0] Z; 	// 32b Result (A op B)
	output overflow;	// 1b overflow flag, THIS IS ACTIVE WHEN
	output zero;		// 1b zero flag, THIS IS ACTIVE WHEN the result of the operation applied to A/B is zero.
	output carryout;	// 1b carryout flag, THIS IS ACTIVE WHEN the result of the operation applied to A/B requires a carry out (for further operations)

	// Split op_control into ctl and shamt
	wire [5:0] ctl; // 6b Control line, used to select the operation to be applied to A and B
	wire [4:0] shamt; // 5b Control line indicating the amount of shift to be applied (if op is shift)
	assign ctl = op_ctl[5:0];
	assign shamt = op_ctl[10:6];

	// Define internal wires for control units
	wire [1:0] lu_ctl; // Selector of the operator of the logic unit (00: AND, 01: OR, 10: XOR, 11: NOR)
	wire b_inv; // Flag to specify whether operator B should be negated or not. When this is 0, AU performs addition. When this is 1, AU performs subtraction.
	wire comb_adder_sel; // zero if we have to use the logic unit, one if we have to use the logic/comparison unit.
	wire comparison_sel; // zero if we have to select the logic_unit result, one if we have to select the comparison unit result.
	wire shift_to_right; // zero indicates shift to left, one indicates shift to right.
	wire arithm_sel; // zero indicates use shifter, one indicates use adder/comparison/logical units
	wire unsigned_ctl; // zero indicates perform comparison using signed integers, one indicates unsigned comparison

	// Define internal outputs from blocks
	wire [31:0] LU_z;
	wire [31:0] AU_z;
	wire [31:0] CU_z;
	wire [31:0] SU_z;
	wire [31:0] AC_z; // Holder for the output of the mux between the output of the arithmetic unit AU_z and the output of the comparison block CU_z
	wire [31:0] AC_L_z; // Holder for the output of the mux that chooses between arithmetic/comparison and logic units.

	// Assign controls for units
	assign lu_ctl = ctl[1:0];
	assign b_inv = ctl[1];
	assign comb_adder_sel = ctl[2];
	assign comparison_sel = ctl[3];
	assign shift_to_right = ctl[1];
	assign arithm_sel = ctl[5];
	assign unsigned_ctl = ctl[0];

	// The first and easiest thing to do is to set the Zero output. The zero output is high when the result is zero. 
	//assign zero = (Z == 32'b0);
	nor_gate_32to1 ZNOR_1 (.x(Z), .z(zero));

	// Wire-up the LOGIC UNIT 
	logic_unit_32 LU32_1 (.A(A), .B(B), .lu_ctl(lu_ctl), .z(LU_z));

	// Wire-up the ARITHMETIC UNIT
	arithmetic_unit_32 AU32_1 (.A(A), .B(B), .b_inv(b_inv), .z(AU_z), .cout(carryout), .overflow(overflow));

	// Wire-up the comparison block
	comparison_unit_32 CU32_1 (.A(A), .B(B), .sub_z(AU_z), .carryout(carryout), .unsigned_ctl(unsigned_ctl), .z(CU_z));

	// Wire-up the shifter block 
	shift_unit_32 SU32_1 (.A(A), .shamt(shamt), .shift_to_right(shift_to_right), .z(SU_z));

	// Connect the MUX to select between AU_z or CU_z depending on 
	mux2to1_32 mux_0 (.sel(comparison_sel), .src0(AU_z), .src1(CU_z), .z(AC_z));

	// Connect the MUX to select between LU and AU results using ctl[2]
	mux2to1_32 mux_1 (.sel(comb_adder_sel), .src0(AC_z), .src1(LU_z), .z(AC_L_z));

	// Connect the MUX to select between ((Arithmetic/Comparison)/Logic)/Shift units and assign to output of ALU
	mux2to1_32 mux_2 (.sel(arithm_sel), .src0(SU_z), .src1(AC_L_z), .z(Z));


endmodule