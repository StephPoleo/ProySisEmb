`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: 
//  Isaac Arano Mata 
//  Francisco Marín Prado
// Create Date: 01.05.2018 12:39:07
// Design Name: 
// Module Name: SubBytes_Decrypt_tb
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


module SubBytes_Decrypt_tb;
	// Inputs
reg Ena;
reg Clk;
reg Rst;
reg [127:0] DataIn;

// Outputs
wire Done;
wire [127:0] DataOut;

// Instantiate the Unit Under Test (UUT)
SubBytes_Decrypt uut (
    .Ena(Ena), 
    .Clk(Clk), 
    .Rst(Rst), 
    .DataIn(DataIn),
    .Done(Done),
    .DataOut(DataOut)
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
    DataIn = 128'hd42711aee0bf98f1b8b45de51e415230;
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
