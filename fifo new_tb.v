`timescale 1ns / 1ps

module tb_fifo;
    // Parameters
    parameter DEPTH = 16;
    parameter WIDTH = 8;
    
    // Signals
    reg clk, rst, wr_en, rd_en;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;
    wire full, empty;
    
    integer i;
    
    // Instantiate the FIFO
    fifo dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );
    
    // Generate clock signal
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end    
    
    // Test procedure
    initial begin
        // Initialize signals
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;
        
        #20;
        rst = 0;
        
        // Write to FIFO till it gets full
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge clk);
            begin
                data_in = $random;  // writing random data
                wr_en = 1;
            end            
        end
        
        @(posedge clk);    
        wr_en = 0;      
        
        // Attempt to write when FIFO is full
        @(posedge clk);
        begin
            data_in = $random;
            wr_en = 1;
        end
        
        @(posedge clk);       
        wr_en = 0;
        
        // Read from FIFO 5 stored data 
        for (i = 0; i < 5; i = i + 1) begin
            @(posedge clk);
            rd_en = 1;
        end
        
        @(posedge clk);
        rd_en = 0;
        
        // Attempt to write again after some reading to check full and empty conditions  
        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);
            begin
                data_in = $random;  
                wr_en = 1;
            end
        end    
            
        @(posedge clk);
        wr_en = 0;
          
        // Read from FIFO again         
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge clk);
            rd_en = 1;
        end 
                    
        @(posedge clk);
        rd_en = 0;
        
        // Attempt to read when FIFO is empty
        @(posedge clk);
        rd_en = 1;
        
        @(posedge clk);
        rd_en = 0;
        
        // Test reset
        @(posedge clk);
        rst = 1;
        
        #20;
        rst = 0;
        
        #30;
        $finish;
    end
endmodule
