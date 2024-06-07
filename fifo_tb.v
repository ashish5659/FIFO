`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:11:49 06/06/2024
// Design Name:   fifo
// Module Name:   /home/ise/fifo/fif0_tb.v
// Project Name:  fifo
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fif0_tb;

	// Inputs
	reg clk;
	reg rst;
	reg wr_en;
	reg rd_en;
	reg [7:0] data_in;

	// Outputs
	wire [7:0] data_out;
	wire full;
	wire empty;

	// Instantiate the Unit Under Test (UUT)
	fifo uut (
		.clk(clk), 
		.rst(rst), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.data_in(data_in), 
		.data_out(data_out), 
		.full(full), 
		.empty(empty)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		wr_en = 0;
		rd_en = 0;
		data_in = 0;
      //#10 rst_n = 1;
		
 $random();
 
    // Drive some data into the FIFO
    repeat (7) begin
      #10;
      wr_en = 1;
      data_in = $random;
    end

    // Remove some data from the FIFO
    repeat (5) begin
      #10;
      rd_en = 1;
    end

    #100;
    $finish;


	end
      
endmodule

