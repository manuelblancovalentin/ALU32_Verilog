module full_fast_adder(a, b, cin, z, cout);
	// Define single-bit inputs
	input a; // Operator A (1b)
	input b; // Operator B (1b)
	input cin; // Carry-in (1b)
	// Define single-bit outputs
	output wire z; // Result (1b)
	output wire cout; // Carry-out (1b)

	// Define internal wires
	wire p; // Propagate carry out (for carry look-ahead)
	wire g; // Generate carry out (for carry look-ahead)

	// Define result
	xor_gate z_g1 (.x(a), .y(b), .z(p));
	xor_gate z_g2 (.x(p), .y(cin), .z(z));

	// Define carry out
	and_gate cout_g1 (.x(a), .y(b), .z(g));
	
	// Use MUX 
	mux mux0 (.sel(p), .src0(g), .src1(cin), .z(cout));


endmodule