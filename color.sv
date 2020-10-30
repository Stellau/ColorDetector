/* File Name: color
	Class: EE 371
	Folder: lab6-371
	Author Name: Stella Lau, Cindy Imm
	Description: This files countains the module that determines the dominating color
					 on the screen.
*/
module color #(parameter data_width = 8)(red, green, blue, main);

	// declares the input and output logic
	input logic [data_width - 1 : 0] red, green, blue;
	output logic [1 : 0] main;
	
	always_comb begin
		// compares the inputs to determine primary color
		if (red > 50 || green > 50 || blue > 50) begin
			if (red > blue) begin
				if (red > green)
					main = 0;
				else 
					main = 1;
				end
			else if (blue > red) begin
				if (blue > green)
					main = 2;
				else
					main = 1;
				end
			else
				main = 3;
		end else
			main = 3;
	end

endmodule

module color_testbench();

	// declares the parameters, inputs, and outputs
	parameter data_width = 8
	logic [data_width - 1 : 0] red, green, blue;
	logic [1 : 0] main;
	
	color #(data_width) dut (.*);
	
	initial begin
		red = 128; green = 76; blue = 88; #50;
		red = 79; green = 253; blue = 28; #50;
		red = 128; green = 76; blue = 255; #50;
		$stop;
	end

endmodule
