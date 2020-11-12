//timeunit       1ns;
//timeprecision  1fs;
`timescale 1 ns / 1 fs

// Instantiate testbench module
module ALU_32_tb;

	// Create clock registers and init parameters (NOTICE CLOCK IS JUST NECESSARY FOR THE TESTBENCH, ALU IS PURELY COMBINATIONAL)
	reg clk = 0;
	`define HALF_CLK_PERIOD 12.5

	// Create registers for simulation states
	reg finish_simulation; 

	// ALU_CTL CODES
	parameter ALU_CTL_ADD = 6'b100000;
	parameter ALU_CTL_SUB = 6'b100010;

	parameter ALU_CTL_AND = 6'b100100;
	parameter ALU_CTL_XOR = 6'b100110;
	parameter ALU_CTL_OR  = 6'b100101;
	parameter ALU_CTL_NOR = 6'b100111;

	parameter ALU_CTL_SLL = 6'b000000;
	parameter ALU_CTL_SRL = 6'b000010;
	parameter ALU_CTL_SLT = 6'b101010;
	parameter ALU_CTL_SLTU = 6'b101011;

	// Create counter register to keep track of counts
	parameter MAX_COUNT = 20;
	reg [31:0] counter;
	reg [31:0] op_counter; 

	// Create register to hold the expected value (calculated in testbench, outside DUT),
	// as well as bookeeping variables to keep track of mismatches between expect vs actual results
	reg [31:0] expected_result;
	reg [31:0] num_errors;

	// Create ALU signal registers
	reg [31:0] ALU_OP_A; //ALU operator A
	reg [31:0] ALU_OP_B; //ALU operator B
	wire [31:0] ALU_OP_OUT; //ALU operator OUT
	reg [10:0] ALU_CTL; //ALU control line
	wire ALU_OVERFLOW;
	wire ALU_ZERO; 
	wire ALU_CARRYOUT; //ALU overflow, carryout and zero flags

	// Instantiate DUT (Device under test)
	ALU_32 DUT (
		.A(ALU_OP_A),
		.B(ALU_OP_B),
		.op_ctl(ALU_CTL),
		.Z(ALU_OP_OUT),
		.overflow(ALU_OVERFLOW),
		.zero(ALU_ZERO),
		.carryout(ALU_CARRYOUT));

	// Setup trace file
	initial begin
	    $dumpfile ("dut.vcd");
	    $dumpvars;

	    // Initialize variables
	    counter = 0;
	    op_counter = 0;
	    finish_simulation = 1'b0;

	    // Initialize operators
	    ALU_OP_A = 32'b0;
	    ALU_OP_B = 32'b0;

	    // Initialize number of counted errors
	    num_errors = 0;

	end

	// Generate testbench clock
	always begin
	    #`HALF_CLK_PERIOD clk = ~clk;
	end


	// Increase operators and operation counters
	always @(posedge clk) begin

		// Perform test only if simulation not finished
		if (finish_simulation == 1'b0) begin

			// Make sure to initialize shamt to zero
			ALU_CTL[10:6] = 5'b0;

			// Now Get random values for operators
			ALU_OP_A = $random;
			ALU_OP_B = $random;

			// Run different operation depending on counter
			case (op_counter)
				0: 	begin
						ALU_CTL[5:0] = ALU_CTL_AND;
						expected_result = (ALU_OP_A & ALU_OP_B);
					end
				1: 	begin
						ALU_CTL[5:0] = ALU_CTL_OR;
						expected_result = (ALU_OP_A | ALU_OP_B);
					end
				2: 	begin
						ALU_CTL[5:0] = ALU_CTL_XOR;
						expected_result = (ALU_OP_A ^ ALU_OP_B);
					end
				3: 	begin
						ALU_CTL[5:0] = ALU_CTL_NOR;
						expected_result = ~(ALU_OP_A | ALU_OP_B);
					end
				4: 	begin
						ALU_CTL[5:0] = ALU_CTL_ADD;
						expected_result = (ALU_OP_A + ALU_OP_B);
					end
				5: 	begin
						ALU_CTL[5:0] = ALU_CTL_SUB;
						expected_result = (ALU_OP_A - ALU_OP_B);
					end
				6: 	begin
						ALU_CTL[5:0] = ALU_CTL_SLT;
						expected_result = 32'b0;
						if ($signed(ALU_OP_A) < $signed(ALU_OP_B)) expected_result[0] = 1'b1;
					end
				7: 	begin
						ALU_CTL[5:0] = ALU_CTL_SLTU;
						expected_result = 32'b0;
						if (ALU_OP_A < ALU_OP_B) expected_result[0] = 1'b1;
					end
				8:  begin
						ALU_CTL[5:0] = ALU_CTL_SLL;
						ALU_CTL[10:6] = $random;
						expected_result = (ALU_OP_A << ALU_CTL[10:6]);
					end 
				9:  begin
						ALU_CTL[5:0] = ALU_CTL_SRL;
						ALU_CTL[10:6] = $random;
						expected_result = (ALU_OP_A >> ALU_CTL[10:6]);
					end
			endcase

			// Wait certain amount of time
			#5;

			// Check if actual value is equal to value returned by the DUT
			if (ALU_OP_OUT != expected_result) begin
				$display("[%04d] - ERROR: Expected value %b but received %b", $time, expected_result, ALU_OP_OUT);
				// Increase error counter
				num_errors = num_errors + 1;
			end

			// Increase counter or stop simulation
			if (counter >= MAX_COUNT) begin
				if (op_counter >= 9) begin
					// Finish test
					finish_simulation = 1'b1;
				end else begin 
					// Reset counter and increase op_counter
					op_counter = op_counter + 1'b1;
				end
				counter = 0;
			end else begin
				// Increase counter
				counter = counter + 1;
			end

		end

	end


	// Stop testbench after 100 counts after finish_simulation signal goes high
	always @(posedge clk) begin
		if (finish_simulation == 1'b1) begin
			// Display error info before leaving
			if (num_errors == 0) begin
				$display("[%04d] - VALIDATION: PASSED with no errors. ALU WORKING!", $time);
			end else begin 
				$display("[%04d] - VALIDATION: FAILED with %d errors. ALU __NOT__ WORKING!", $time, num_errors);
			end

			$finish;
		end
	end

endmodule
