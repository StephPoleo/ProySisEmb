`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: 
//  Isaac Arano Mata 
//  Francisco Marín Prado
// Create Date: 01.05.2018 12:38:21
// Design Name: 
// Module Name: SubBytes_Decrypt
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


module SubBytes_Decrypt(
    input Clk,
    input Rst,
    input Ena,
    input [127:0] DataIn,
    output Done,
    output [127:0] DataOut
    );
    
  reg [7:0] rom [0:255];
  reg [7:0] Addr;
  reg [127:0] InputMatrix;
  reg [127:0] OutputMatrix;
  reg FinishFlag;
  reg [4:0] x;
   
  initial $readmemh("SBoxInv.data", rom,0,255);
     
  always @(posedge Clk)
  begin
    if (Rst) begin
        OutputMatrix = 0;
        InputMatrix = 0;
        Addr = 0;
        FinishFlag=0;
        x=0;
        InputMatrix = 0;
    end
    else if (!FinishFlag) begin
                if (x==0)
                    InputMatrix = DataIn;
                if(x <= 16) begin
                        Addr <= InputMatrix[7:0];
                        InputMatrix <= InputMatrix>>8;
                        OutputMatrix <= OutputMatrix>>8;
                        OutputMatrix[127:120] <= rom[Addr];
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
