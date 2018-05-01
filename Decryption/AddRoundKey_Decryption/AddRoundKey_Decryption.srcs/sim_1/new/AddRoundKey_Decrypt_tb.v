`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: 
//  Isaac Arano Mata 
//  Francisco Marín Prado
// Create Date: 01.05.2018 12:20:18
// Design Name: 
// Module Name: AddRoundKey_Decrypt_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AddRoundKey_Decrypt_tb;

// Inputs
    reg Ena;
    reg Clk;
    reg Rst;
    reg [127:0] DataIn;
    reg [127:0] Key;
    
    // Outputs
    wire Done;
    wire [127:0] DataOut;
    
    // Instantiate the Unit Under Test (UUT)
    AddRoundKey_Decrypt uut (
        .Ena(Ena), 
        .Clk(Clk), 
        .Rst(Rst), 
        .DataIn(DataIn),
        .Done(Done),
        .DataOut(DataOut),
        .Key(Key)
    );
    
    // Clock signal declaration
    always
    begin
      #10 Clk = ~Clk;
    end
    
    initial begin
        // Initialize Inputs
        Clk = 0;
        Rst = 1;
        Ena = 0;
        DataIn = 128'ha49c7ff2689f352b6b5bea43026a5049;
        Key    = 128'ha0fafe1788542cb123a339392a6c7605;
        // Wait 100 ns for global reset to finish
        #100;
        Rst = 0;
        Ena = 1;
        #50;
        Ena = 0;
        #200;
        // Add stimulus here
        

    
    end

endmodule
