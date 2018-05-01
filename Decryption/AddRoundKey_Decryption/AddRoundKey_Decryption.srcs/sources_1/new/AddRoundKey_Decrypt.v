`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers:
//  Isaac Arano Mata 
//  Francisco Marín Prado
// Create Date: 01.05.2018 11:52:03
// Design Name: 
// Module Name: AddRoundKey_Decrypt
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


module AddRoundKey_Decrypt(
    input Clk,
    input Rst,
    input Ena,
    input [127:0] DataIn,
    input [127:0] Key,
    output [127:0] DataOut,
    output Done
    );

  reg [7:0] Temp;
  reg [7:0] Temp2;
  reg [1277:0] KeyMatrix;
  reg [127:0] InputMatrix;
  reg [127:0] OutputMatrix;
  reg FinishFlag;
  reg [4:0] x;
     
  always @(posedge Clk)
  begin
    if (Rst) begin
        OutputMatrix = 0;
        InputMatrix = 0;
        Temp = 0;
        KeyMatrix = 0;
        FinishFlag=0;
        x=0;
        InputMatrix = 0;
    end
    else if (!FinishFlag) begin
                if (x==0)begin
                    InputMatrix = DataIn;
                    KeyMatrix = Key;
                end
                if(x <= 16) begin
                        Temp <= InputMatrix[7:0];
                        Temp2 <= KeyMatrix[7:0];
                        InputMatrix <= InputMatrix>>8;
                        KeyMatrix <= KeyMatrix>>8;
                        OutputMatrix <= OutputMatrix>>8;
                        OutputMatrix[127:120] <= Temp ^ Temp2;
                        x =  x+1;
                end
                else begin
                    x = 0;
                    FinishFlag=1;
                end
      end
      else if(Ena && FinishFlag)begin
              FinishFlag=0;
              InputMatrix = 0;
      end
  end
  assign DataOut = OutputMatrix;
  assign Done = FinishFlag;
    
endmodule








