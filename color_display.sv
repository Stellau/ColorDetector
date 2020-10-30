/* File Name: color_display
	Class: EE 371
	Folder: lab6-371
	Author Name: Stella Lau, Cindy Imm
	Description: This file displays the dominant color on the screen on the hex display
*/
module color_display (main, h0, h1, h2, h3, h4, h5);

	// declares the inputs and outputs
	input logic [1:0] main;
	output logic [6:0] h0, h1, h2, h3, h4, h5;
	
	// controls the displays
	always_comb begin
		case(main)
			// red
			0: begin
					h5 = 7'b1001110;
					h4 = 7'b0000100;
					h3 = 7'b0100001;
					h2 = 7'b0111111;
					h1 = 7'b0111111;
					h0 = 7'b0111111;
				end
			// green
			1: begin
					h5 = 7'b0010000;
					h4 = 7'b1001110;
					h3 = 7'b0000100;
					h2 = 7'b0000100;
					h1 = 7'b0101011;
					h0 = 7'b0111111;
				end
			// blue
			2: begin
					h5 = 7'b0000011;
					h4 = 7'b1111001;
					h4 = 7'b1001111;
					h3 = 7'b1100011;
					h2 = 7'b0000100;
					h1 = 7'b0111111;
					h0 = 7'b0111111;
				end
			
			default: begin
					h5 = 7'b1111111;
					h4 = 7'b1111111;
					h3 = 7'b1111111;
					h2 = 7'b1111111;
					h1 = 7'b1111111;
					h0 = 7'b1111111;
				end
		endcase
	end

endmodule

module color_display_testbench();
	
	// declares the inputs and outputs
	logic [1:0] main;
	logic [6:0] h0, h1, h2, h3, h4, h5;
	
	// instantiates the module
	color_display dut (.*);
	
	initial begin
		main = 0; #50;
		main = 1; #50;
		main = 2; #50;
		main = 3; #50;
		$stop;
	end
	
endmodule
