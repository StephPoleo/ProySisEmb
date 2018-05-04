`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers:
//  Isaac Arano Mata 
//  Francisco Marín Prado
// Create Date: 01.05.2018 11:52:03
// Design Name: 
// Module Name: AddRoundKey
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Module in charge of the AddRoundKey process
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AddRoundKey(
    input Clk,
    input Rst,
    input En,
    input [0:127] DataIn,
    input [0:127] Key,
    output [0:127] DataOut,
    output Done
    );

// Variable declaration, Temp and Temp2 go over each 8 bits of the matrix
//and the key for further XOR operation.
  reg [7:0] Temp;
  reg [7:0] Temp2;
  reg [0:127] KeyMatrix;
  reg [0:127] InputMatrix;
  reg [0:127] OutputMatrix;
  reg FinishFlag;
  reg [4:0] x;
     
  always @(posedge Clk)
  begin
// If Reset (Rst) is enabled, set all variables to 0.
    if (Rst) begin
        OutputMatrix = 0;
        InputMatrix = 0;
        Temp = 0;
        KeyMatrix = 0;
        FinishFlag=0;
        x=0;
        InputMatrix = 0;
    end
//If Reset (Rst) is off and Finish flag has not turned on, the AddRoundKey
//process begin getting the InputMatrix and making the XOR comparison
//with the given Key.
    else if (!FinishFlag) begin
                if (x==0)begin
                    InputMatrix = DataIn;
                    KeyMatrix = Key;
                end
                if(x <= 16) begin
                        Temp <= InputMatrix[0:7];
                        Temp2 <= KeyMatrix[0:7];
                        InputMatrix <= InputMatrix<<8;
                        KeyMatrix <= KeyMatrix<<8;
                        OutputMatrix <= OutputMatrix<<8;
                        OutputMatrix[120:127] <= Temp ^ Temp2;
                        x =  x+1;
                end
                else begin
                    x = 0;
                    FinishFlag=1;
                end
      end
 //If Enable(En) is on and the process has finished (FinisFlag = 1)
 //for given matrix, set reinitialize FinishFlag an InputMatrix
 //so the new matrix can star the process.
      else if(En && FinishFlag)begin
              FinishFlag=0;
              InputMatrix = 0;
      end
  end
  
  //Assign the final values for the outputs declared.
  assign DataOut = OutputMatrix;
  assign Done = FinishFlag;
    
endmodule