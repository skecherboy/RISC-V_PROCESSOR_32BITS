module data_path #(
parameter PC_W = 8 , // Program Counter
parameter INS_W = 32 , // Instruction Width
parameter RF_ADDRESS = 5 , // Register File Address
parameter DATA_W = 32 , // Data WriteData
parameter DM_ADDRESS = 9 , // Data Memory Address
parameter ALU_CC_W = 4 // ALU Control Code Width
)(
input clk , // CLK in Datapath figure
input reset , // Reset in Datapath figure
input reg_write , // RegWrite in Datapath figure
input mem2reg , // MemtoReg in Datapath figure
input alu_src , // ALUSrc in Datapath figure
input mem_write , // MemWrite in Datapath Figure
input mem_read , // MemRead in Datapath Figure
input [ ALU_CC_W -1 : 0 ] alu_cc , // ALUCC in Datapath Figure
output [ 6 : 0 ] opcode , // opcode in Datapath Figure
output [ 6 : 0 ] funct7 , // Funct7 in Datapath Figure
output [ 2 : 0 ] funct3 , // Func3 in Datapath Figure
output wire[ DATA_W -1 : 0 ] alu_result // Datapath_Result in Datapath Figure
);
 wire              dpCarryOut, dpZero, dpOverflow;
 wire  [PC_W-1:0] sumDpPcCount, dpPcCount;
 wire [INS_W-1:0] dpInstruct, dpWriteData, 
                  dpAluA, dpAluB, 
                  dpReg2, dpImmOut, 
                  dpMemData;

// Look at datapath in lab
// This is basically a "written" schematics
// Connect all the modules together using the wires
// and module instantiations 

FlipFlop ff(.clk(clk), .reset(reset), .d(sumDpPcCount), .q(dpPcCount));

assign sumDpPcCount = dpPcCount + 4;

InstMem im(.addr(dpPcCount), .instruction(dpInstruct));

RegFile rg(.clk(clk), .reset(reset), .rg_wrt_en(reg_write), 
           .rg_wrt_addr(dpInstruct[11:7]), 
           .rg_rd_addr1(dpInstruct[19:15]),
           .rg_rd_addr2 (dpInstruct[24:20]),
           .rg_wrt_data(dpWriteData), .rg_rd_data1(dpAluA),
           .rg_rd_data2(dpReg2) );

MUX21  mux1(.D0(dpReg2), .D1(dpImmOut), .S(alu_src), .Y(dpAluB));
    
ImmGen ig1(.InstCode(dpInstruct), .ImmOut(dpImmOut)); 

alu_32 alu(.A_in(dpAluA), .B_in(dpAluB), .ALU_Sel(alu_cc), 
           .ALU_Out(alu_result), 
           .Carry_Out(dpCarryOut), .Zero(dpZero), 
           .Overflow(dpOverflow) );


DataMem dm(.MemRead(mem_read), .MemWrite(mem_write), 
           .addr(alu_result[DM_ADDRESS-1:0]), 
           .write_data(dpReg2), .read_data(dpMemData));

MUX21 mux2(.D0(alu_result),.D1(dpMemData),.S(mem2reg),
           .Y(dpWriteData));

assign opcode = dpInstruct[6:0];
assign funct7 = dpInstruct[31:25];
assign funct3 = dpInstruct[14:12];
     
endmodule // Datapath