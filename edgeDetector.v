module edgeDetector(
	input clk,
	input signalIn,
	output sigout
);
//	wire dff_out;
//	lab_DFF holdflag(.clock(clk),.data(signalIn),.Q(dff_out),.reset(1'b0),.preset(1'b0));
//	assign sigout=~dff_out&signalIn;

	reg flag;
	assign sigout=~signalIn&flag;

	always @(posedge clk) begin
		flag <= signalIn;
	end

endmodule