module comparison_unit_32(A, B, sub_z, carryout, unsigned_ctl, z);
	
	// Define inputs
	input [31:0] A;
	input [31:0] B;
	input [31:0] sub_z;
	input carryout;
	input unsigned_ctl;

	// Define outputs
	output wire [31:0] z;

	// Define internal signals
	wire [31:0] less;
	wire [31:0] less_u;
	wire signs_are_different;
	wire signs_are_equal;
	wire slt_signs;
	wire slt_num;
	wire slt;
	wire sltu;

	// Assign zeros to less
	assign less[31:1] = 31'b0;
	assign less_u[31:1] = 31'b0;
    
	// If the signs are the different, we simply have to check whether A is positive or negative. 
	// If A[31] == 0, that means A is positive, and thus B is negative, which means that Less <= 0.
	// If A[31] == 1, that means A is negative, and thus B is positive, which means that Less <= 1.
	// In any case we realize that if the signs are different, Less <= A[31].
	// Checking whether the signs are different can be implemented using a XOR gate.
	xor_gate xor_g1 (.x(A[31]), .y(B[31]), .z(signs_are_different)); // signs_are_different is 0 if A == B, else 1
	and_gate and_g1 (.x(A[31]), .y(signs_are_different), .z(slt_signs)); // slt_signs is 1 when A != B and A[31] == 1

	// Now, if the signs are equal, we have to check whether the sign of the result is negative or positive. If the
	// sign of the result is negative (Res[31] == 1), it means Less <= 1. On the other hand, if the sign of the result
	// is positive (Res[31] == 0), it means Less <= 0. So basically, Less <= Res[31].
	not_gate not_g1 (.x(signs_are_different), .z(signs_are_equal)); 
	and_gate and_g2 (.x(sub_z[31]), .y(signs_are_equal), .z(slt_num));

	// Finally connect everything
	or_gate or_g2 (.x(slt_signs), .y(slt_num), .z(slt));

	// Assign last bit to less
	assign less[0] = slt;

	// Checking whether unsigned A < B is easier. If A and B are unsigned, then there is no representation
	// of negative numbers (they cannot be negative). This means that the result of (A-B) can only be 
	// positive. If the carryout of (A-B) is 1, it means the result is indeed positive (carryout high)
	// in subtraction is the normal value. However if carryout is 0, this means the result of the 
	// subtraction overflowed, which can only happen if and only if B > A. From this we conclude that
	// less_u <= not(carryout)
	not_gate not_g3 (.x(carryout), .z(sltu));
	assign less_u[0] = sltu;

	// Now wire-up a mux to decide whether we output the SLT or the SLTU result
	mux2to1_32 mux0 (.sel(unsigned_ctl), .src0(less), .src1(less_u), .z(z));

endmodule