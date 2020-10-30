/* File Name: average
	Class: EE 371
	Folder: lab6-371
	Author Name: Stella Lau, Cindy Imm
	Description: This files countains the module that takes the average of N samples
					 stored in a buffer
*/
module average #(parameter data_width = 8, N = 4096) (clk, read, reset, data_in, data_out);

	// declares the inputs and outputs
	input logic clk, read, reset;
	input logic [data_width - 1 : 0] data_in;
	output logic [data_width - 1 : 0] data_out;
	
	// take base 2 log of the number to decided the number of bits to shift
	parameter bits = $clog2(N);
	// determines the number of bits required to store the sum of all samples
	parameter append = data_width + bits;
	// declares the temporary module required for the instantiation of the submodules
	logic [data_width - 1 : 0] buff [0 : N - 1];
	logic [append - 1 : 0] temp [0 : N - 1];
	logic [append - 1 : 0] out;
	// assign temp[0] to the first value stored in the buffer
	assign temp[0] = buff[0];
	
	// instantiates the buffer module
	buffer #(data_width, N) b (.clk, .reset, .read, .data_in, .buff);
	
	// uses generate to obtain the sum
	genvar i;
	generate
		for(i=1; i<N; i++) begin : Summing
			assign temp[i] = temp[i-1] + buff[i];
		end
	endgenerate
	
	// divides the sum by the number of samples there are
	shift #(append, bits) s (.data_in(temp[N-1]), .data_out(out));
	
	// assigns data_out to the average
	assign data_out = out[data_width - 1 : 0];

endmodule

module average_testbench();

	// declares the logics and the parameters required to instantiate the module
	parameter data_width = 8, N = 4096;
	logic clk, read, reset;
	logic [data_width - 1 : 0] data_in, data_out;

	// instantiates the module
	average #(data_width, N) dut (.*);
	
	// declares the constant CLOCK_PERIOD as 100
	parameter CLOCK_PERIOD = 100;
	
	// initializes the clock
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2)
			// toggles the clock
			clk <= ~clk;
	end
	
	initial begin
		reset <= 1; data_in <= 8; @(posedge clk);
		reset <= 0; read <= 1; @(posedge clk);
		data_in <= 16; @(posedge clk);
		data_in <= 24; @(posedge clk);
		data_in <= 64; @(posedge clk);
		data_in <= 16; @(posedge clk);
		data_in <= 8; @(posedge clk);		
		repeat (4100) @(posedge clk);
		read <= 0; @(posedge clk);
		repeat (10); @(posedge clk);
		read <= 1; @(posedge clk);
		data_in <= 16; @(posedge clk);
		data_in <= 24; @(posedge clk);
		data_in <= 64; @(posedge clk);
		data_in <= 16; @(posedge clk);
		data_in <= 8; @(posedge clk);
		repeat (4100) @(posedge clk); 	
		$stop;
	end

endmodule
