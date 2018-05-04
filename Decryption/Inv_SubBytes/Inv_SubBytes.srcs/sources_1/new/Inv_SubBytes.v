`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: 
//  Isaac Arano Mata 
//  Francisco Marín Prado
// Create Date: 01.05.2018 12:38:21
// Design Name: 
// Module Name: Inv_SubBytes
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Module in charge of inverse SubBytes process
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Inv_SubBytes(
    input Clk,
    input Rst,
    input En,
    input  [0:127] DataIn,
    output [0:127] DataOut,
    output Done
    
    );
    
  // Registers initialization
  reg [7:0] rom [0:255];
  reg [7:0] Addr;
  reg [0:127] InputMatrix;
  reg [0:127] OutputMatrix;
  reg FinishFlag;
  reg [4:0] x;
  
  // Import de inverse S-Box to rom register 
  initial $readmemh("SBoxInv.data", rom,0,255);
     
  always @(posedge Clk)
  begin
  //Synchronous Reset
    if (Rst) begin
        OutputMatrix = 0;
        InputMatrix = 0;
        Addr = 0;
        FinishFlag=0;
        x=0;
        InputMatrix = 0;
    end
    else if (!FinishFlag) begin
                //First assign input to register
                if (x==0)
                    InputMatrix = DataIn;
                if(x <= 16) begin
                        // get address from input matrix
                        Addr <= InputMatrix[0:7];
                        // shift to the next byte
                        InputMatrix <= InputMatrix<<8;
                        // shift the previous output to be ready for the next one
                        OutputMatrix <= OutputMatrix<<8;
                        // Assign the new value to the output  for inverse S Box
                        OutputMatrix[120:127] <= rom[Addr];
                        x =  x+1;
                end
                else begin
                // Finish Flag high when done
                    x = 0;
                    FinishFlag=1;
                end
      end
      else if(En && FinishFlag)begin
              FinishFlag=0;
              InputMatrix = 0;
      end
  end
  //output assigns
  assign DataOut = OutputMatrix;
  assign Done = FinishFlag;
    
endmodule

