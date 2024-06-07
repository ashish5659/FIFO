`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:08:50 06/05/2024 
// Design Name: 
// Module Name:    fifo 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module fifo(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output 		 full,
    output 		 empty
    );
//parameters
parameter WIDTH = 8;
parameter DEPTH = 16;

// internal signal
reg [WIDTH-1:0] buffer [0:DEPTH-1];
reg [3:0] wr_ptr, rd_ptr;
reg[4:0] count;

//write logic
always@(posedge clk or posedge rst)
begin
     if (rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count <= 0;
     end else begin
        if (wr_en && ~full) begin
            buffer[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            count <= count + 1;
        end
     end
end
// read logic
always@(posedge clk or posedge rst)begin
	if (rst) begin
		data_out <= 0;
	end else begin
	if(rd_en && ~empty) begin
		data_out <= buffer[rd_en];
		rd_ptr <= rd_ptr +1;
		count <= count-1;
		end
	end
end

// Full and empty logic
//always@*begin
assign full = (count == DEPTH);
assign empty = (count == 0);
//end
endmodule

