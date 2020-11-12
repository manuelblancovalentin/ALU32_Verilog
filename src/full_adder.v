module full_adder(a, b, cin, z, cout);
	// Define single-bit inputs
	input a; // Operator A (1b)
	input b; // Operator B (1b)
	input cin; // Carry-in (1b)
	// Define single-bit outputs
	output wire z; // Result (1b)
	output wire cout; // Carry-out (1b)

	// Define internal wires
	wire zout_xor;
	wire cout_and1, cout_and2;

	// Define result
	xor_gate z_g1 (.x(a), .y(b), .z(zout_xor));
	xor_gate z_g2 (.x(zout_xor), .y(cin), .z(z));

	// Define carry out
	and_gate cout_g1 (.x(a), .y(b), .z(cout_and1));
	and_gate cout_g2 (.x(zout_xor), .y(cin), .z(cout_and2));
	or_gate cout_g3 (.x(cout_and1), .y(cout_and2), .z(cout));


endmodule