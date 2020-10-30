/* File Name: shift
	Class: EE 371
	Folder: lab6-371
	Author Name: Stella Lau, Cindy Imm
	Description: This files shifts a N-bit number by sn number of bits
*/
module shift #(parameter N=20, sn = 12) (data_in, data_out);

	// declares the input and outputs
	input logic [N-1:0] data_in;
	output logic [N-1:0] data_out;
	
	// assign the output
	assign data_out = {{sn{data_in[N-1]}}, data_in[N-1:sn]};

endmodule

module shift_testbench();

	// declares the parameters and logics required by the module
	parameter N = 20;
	parameter sn = 12;
	logic [N-1:0] data_in, data_out;
	
	// instantiates the module
	shift #(N, sn) s (.*);
	
	initial begin
		data_in = 25; #50;
		data_in = 80; #50;
		$stop;
	end

endmodule
