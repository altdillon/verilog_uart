
module baudgenerator(
	input clk,
	output baudOut
);

	//parameter ClkFrequency = 25000000; // 25 MHz
	parameter ClkFrequency = 50000000; // 50 MHz 
	parameter Baud = 115200;
	parameter BaudGeneratorAccWidth = 16;
	//parameter BaudGeneratorInc = (Baud<<BaudGeneratorAccWidth)/ClkFrequency;
	parameter BaudGeneratorInc = ((Baud<<(BaudGeneratorAccWidth-4))+(ClkFrequency>>5))/(ClkFrequency>>4);
	
	reg [BaudGeneratorAccWidth:0] BaudGeneratorAcc;
	always @(posedge clk) begin
		BaudGeneratorAcc <= BaudGeneratorAcc[BaudGeneratorAccWidth-1:0] + BaudGeneratorInc;
	end
		
	wire BaudTick = BaudGeneratorAcc[BaudGeneratorAccWidth];
	assign baudOut=BaudTick;
	
	endmodule