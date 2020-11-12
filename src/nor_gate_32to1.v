module nor_gate_32to1(x, z);
	
	// Define inputs
	input [31:0] x;

	// Define outputs
	output wire z;

	// Define output
	assign z = ~(|x);

endmodule