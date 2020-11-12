module arithmetic_unit_32(A, B, b_inv, z, cout, overflow);
	
	// Define inputs
	input [31:0] A; // 32-bit operator A
	input [31:0] B; // 32-bit operator B
	input b_inv; // 1-bit control b_inv (add/sub). If true, invert B

	// Define outputs 
	output wire [31:0] z; // output 32-bit result of add/sub
	output wire cout; // 1-bit output carry
	output wire overflow; // 1-bit output overflow flag

	// b_inv basically controls whether the operation we have to perform is add (b_inv == 0) or subtraction (b_inv == 1)
	// If we need to perform a subtraction then we have to calculate the 2-complement. Remember that (A-B) = A + (-B) = A + (!B + 1)
	// Thus, if we have to subtract B from A, we need to invert B and add one. 
	// The trick here is to notice that we can perform that by using XOR gates. Remember that (x NOR y) = (xy' + x'y), thus if
	// we set x-> B_i and y-> b_inv, if b_inv == 0, then we just input B_i to the adder, while if b_inv is 1, we invert B_i, which
	// is exactly what we want. At the same time, that "1" we have to add in the case of the subtraction can be added if we set 
	// the carry_in of the first adder in the chain to b_inv. If b_inv is zero (perform addition), then this carry will be zero.
	// But if we are performing a subtraction (b_inv == 1), then we will invert all B inputs (by the XOR gates) and adding one 
	// (by setting the carry_in of the first adder to b_inv, which in this case is one).

	// Internal xor outputs
	wire b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15;
	wire b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31;

	// Internal carries between adders
	wire cout0, cout1, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10, cout11, cout12, cout13, cout14, cout15;
	wire cout16, cout17, cout18, cout19, cout20, cout21, cout22, cout23, cout24, cout25, cout26, cout27, cout28, cout29, cout30;

	// Internal wires for overflow decection
	wire and_of1;
	wire nor_of1;
	wire not_of1;
	wire and_of2;
	wire and_of3;

	// CHAIN OF ADDERS

	// First adder has b_inv as carry_in input
	xor_gate xor_b0 (.x(B[0]), .y(b_inv), .z(b0));
	full_fast_adder FA_0 (.a(A[0]), .b(b0), .cin(b_inv), .z(z[0]), .cout(cout0));

	// Now we can just go on until adder 31

	// ADDER 1
	xor_gate xor_b1 (.x(B[1]), .y(b_inv), .z(b1));
	full_fast_adder FA_1 (.a(A[1]), .b(b1), .cin(cout0), .z(z[1]), .cout(cout1));
	// ADDER 2
	xor_gate xor_b2 (.x(B[2]), .y(b_inv), .z(b2));
	full_fast_adder FA_2 (.a(A[2]), .b(b2), .cin(cout1), .z(z[2]), .cout(cout2));
	// ADDER 3
	xor_gate xor_b3 (.x(B[3]), .y(b_inv), .z(b3));
	full_fast_adder FA_3 (.a(A[3]), .b(b3), .cin(cout2), .z(z[3]), .cout(cout3));
	// ADDER 4
	xor_gate xor_b4 (.x(B[4]), .y(b_inv), .z(b4));
	full_fast_adder FA_4 (.a(A[4]), .b(b4), .cin(cout3), .z(z[4]), .cout(cout4));
	// ADDER 5
	xor_gate xor_b5 (.x(B[5]), .y(b_inv), .z(b5));
	full_fast_adder FA_5 (.a(A[5]), .b(b5), .cin(cout4), .z(z[5]), .cout(cout5));
	// ADDER 6
	xor_gate xor_b6 (.x(B[6]), .y(b_inv), .z(b6));
	full_fast_adder FA_6 (.a(A[6]), .b(b6), .cin(cout5), .z(z[6]), .cout(cout6));
	// ADDER 7
	xor_gate xor_b7 (.x(B[7]), .y(b_inv), .z(b7));
	full_fast_adder FA_7 (.a(A[7]), .b(b7), .cin(cout6), .z(z[7]), .cout(cout7));
	// ADDER 8
	xor_gate xor_b8 (.x(B[8]), .y(b_inv), .z(b8));
	full_fast_adder FA_8 (.a(A[8]), .b(b8), .cin(cout7), .z(z[8]), .cout(cout8));
	// ADDER 9
	xor_gate xor_b9 (.x(B[9]), .y(b_inv), .z(b9));
	full_fast_adder FA_9 (.a(A[9]), .b(b9), .cin(cout8), .z(z[9]), .cout(cout9));
	// ADDER 10
	xor_gate xor_b10 (.x(B[10]), .y(b_inv), .z(b10));
	full_fast_adder FA_10 (.a(A[10]), .b(b10), .cin(cout9), .z(z[10]), .cout(cout10));
	// ADDER 11
	xor_gate xor_b11 (.x(B[11]), .y(b_inv), .z(b11));
	full_fast_adder FA_11 (.a(A[11]), .b(b11), .cin(cout10), .z(z[11]), .cout(cout11));
	// ADDER 12
	xor_gate xor_b12 (.x(B[12]), .y(b_inv), .z(b12));
	full_fast_adder FA_12 (.a(A[12]), .b(b12), .cin(cout11), .z(z[12]), .cout(cout12));
	// ADDER 13
	xor_gate xor_b13 (.x(B[13]), .y(b_inv), .z(b13));
	full_fast_adder FA_13 (.a(A[13]), .b(b13), .cin(cout12), .z(z[13]), .cout(cout13));
	// ADDER 14
	xor_gate xor_b14 (.x(B[14]), .y(b_inv), .z(b14));
	full_fast_adder FA_14 (.a(A[14]), .b(b14), .cin(cout13), .z(z[14]), .cout(cout14));
	// ADDER 15
	xor_gate xor_b15 (.x(B[15]), .y(b_inv), .z(b15));
	full_fast_adder FA_15 (.a(A[15]), .b(b15), .cin(cout14), .z(z[15]), .cout(cout15));
	// ADDER 16
	xor_gate xor_b16 (.x(B[16]), .y(b_inv), .z(b16));
	full_fast_adder FA_16 (.a(A[16]), .b(b16), .cin(cout15), .z(z[16]), .cout(cout16));
	// ADDER 17
	xor_gate xor_b17 (.x(B[17]), .y(b_inv), .z(b17));
	full_fast_adder FA_17 (.a(A[17]), .b(b17), .cin(cout16), .z(z[17]), .cout(cout17));
	// ADDER 18
	xor_gate xor_b18 (.x(B[18]), .y(b_inv), .z(b18));
	full_fast_adder FA_18 (.a(A[18]), .b(b18), .cin(cout17), .z(z[18]), .cout(cout18));
	// ADDER 19
	xor_gate xor_b19 (.x(B[19]), .y(b_inv), .z(b19));
	full_fast_adder FA_19 (.a(A[19]), .b(b19), .cin(cout18), .z(z[19]), .cout(cout19));
	// ADDER 20
	xor_gate xor_b20 (.x(B[20]), .y(b_inv), .z(b20));
	full_fast_adder FA_20 (.a(A[20]), .b(b20), .cin(cout19), .z(z[20]), .cout(cout20));
	// ADDER 21
	xor_gate xor_b21 (.x(B[21]), .y(b_inv), .z(b21));
	full_fast_adder FA_21 (.a(A[21]), .b(b21), .cin(cout20), .z(z[21]), .cout(cout21));
	// ADDER 22
	xor_gate xor_b22 (.x(B[22]), .y(b_inv), .z(b22));
	full_fast_adder FA_22 (.a(A[22]), .b(b22), .cin(cout21), .z(z[22]), .cout(cout22));
	// ADDER 23
	xor_gate xor_b23 (.x(B[23]), .y(b_inv), .z(b23));
	full_fast_adder FA_23 (.a(A[23]), .b(b23), .cin(cout22), .z(z[23]), .cout(cout23));
	// ADDER 24
	xor_gate xor_b24 (.x(B[24]), .y(b_inv), .z(b24));
	full_fast_adder FA_24 (.a(A[24]), .b(b24), .cin(cout23), .z(z[24]), .cout(cout24));
	// ADDER 25
	xor_gate xor_b25 (.x(B[25]), .y(b_inv), .z(b25));
	full_fast_adder FA_25 (.a(A[25]), .b(b25), .cin(cout24), .z(z[25]), .cout(cout25));
	// ADDER 26
	xor_gate xor_b26 (.x(B[26]), .y(b_inv), .z(b26));
	full_fast_adder FA_26 (.a(A[26]), .b(b26), .cin(cout25), .z(z[26]), .cout(cout26));
	// ADDER 27
	xor_gate xor_b27 (.x(B[27]), .y(b_inv), .z(b27));
	full_fast_adder FA_27 (.a(A[27]), .b(b27), .cin(cout26), .z(z[27]), .cout(cout27));
	// ADDER 28
	xor_gate xor_b28 (.x(B[28]), .y(b_inv), .z(b28));
	full_fast_adder FA_28 (.a(A[28]), .b(b28), .cin(cout27), .z(z[28]), .cout(cout28));
	// ADDER 29
	xor_gate xor_b29 (.x(B[29]), .y(b_inv), .z(b29));
	full_fast_adder FA_29 (.a(A[29]), .b(b29), .cin(cout28), .z(z[29]), .cout(cout29));
	// ADDER 30
	xor_gate xor_b30 (.x(B[30]), .y(b_inv), .z(b30));
	full_fast_adder FA_30 (.a(A[30]), .b(b30), .cin(cout29), .z(z[30]), .cout(cout30));
	// ADDER 31
	xor_gate xor_b31 (.x(B[31]), .y(b_inv), .z(b31));
	full_fast_adder FA_31 (.a(A[31]), .b(b31), .cin(cout30), .z(z[31]), .cout(cout));

	// Now we must calculate the overflow. Overflow arises when the sign of the result of the operation (add/sub) is not
	// the same as the signs of the original operators.
	and_gate and_g1 (.x(b31), .y(A[31]), .z(and_of1));
	nor_gate nor_g1 (.x(b31), .y(A[31]), .z(nor_of1));
	not_gate not_g1 (.x(z[31]), .z(not_of1));

	and_gate and_g2 (.x(nor_of1), .y(z[31]), .z(and_of2));
	and_gate and_g3 (.x(and_of1), .y(not_of1), .z(and_of3));

	or_gate or_g1 (.x(and_of2), .y(and_of3), .z(overflow));

endmodule