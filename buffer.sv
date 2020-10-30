/* File Name: buffer
	Class: EE 371
	Folder: lab6-371
	Author Name: Stella Lau, Cindy Imm
	Description: This files countains the module that contains a buffer used to store
					 N samples used for averaging.
*/
module buffer #(parameter data_width = 8, N = 4096) (clk, reset, read, data_in, buff);

	input logic clk, reset, read;
	input logic [data_width - 1: 0] data_in;
	output logic [data_width - 1 : 0] buff [0 : N - 1];
	
	integer i, j;
	always_ff @(posedge clk) begin
		if (reset) begin
			// when reset, sets the buffer to 0
			for (i=0; i<N; i++)
				buff[i] <= 0;
		end
		else if (read) begin
			// otherwise replace the first value with the new value and shifts all the other numbers in the buffer
			buff[0] <= data_in;
			for (j=1; j<N; j++)
				buff[j] <= buff[j-1];
		end
	end

endmodule

module buffer_testbench();
	
	parameter data_width = 8;
	parameter N = 12;
	logic clk, reset, read;
	logic [data_width - 1: 0] data_in;
	logic [data_width - 1 : 0] buff [0 : N - 1];
	
	buffer #(data_width, N) dut (.*);
	
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
		reset <= 1; data_in <= 10; @(posedge clk);
		reset <= 0; read <= 0; @(posedge clk);
		repeat (10) @(posedge clk);
		repeat (10) begin read <= 1; @(posedge clk); end
		data_in <= 28; @(posedge clk);
		repeat (10) @(posedge clk);
		$stop;
	end
	
endmodule
