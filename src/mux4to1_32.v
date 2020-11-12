module mux4to1_32(sel, src0, src1, src2, src3, z);
  
	input [1:0] sel;
	input [31:0] src0;
	input [31:0] src1;
	input [31:0] src2;
	input [31:0] src3;

	output wire [31:0] z;

	// Internal wires 
	wire [31:0] z_m0; //Contains either src0 or src1
	wire [31:0] z_m1; //Contains either src2 or src3

	// We can create a 4to1 mux using 3 pieces of 2to1 muxes
	mux2to1_32 mux0 (.sel(sel[0]), .src0(src0), .src1(src1), .z(z_m0));
	mux2to1_32 mux1 (.sel(sel[0]), .src0(src2), .src1(src3), .z(z_m1));
	mux2to1_32 mux2 (.sel(sel[1]), .src0(z_m0), .src1(z_m1), .z(z));

endmodule
   