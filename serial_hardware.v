
module serial_hardware(
	input [9:0] SW,
	input [3:0] KEY,
	output [9:0] LEDR,
	input HPS_UART_RX,
	output HPS_UART_TX,
	input CLOCK_50
);
	reg tx;
	assign HPS_UART_TX = tx;

	// debug clock with a button
	wire baud_button;
	edgeDetector clockButton(.clk(CLOCK_50),.signalIn(~KEY[0]),.sigout(baud_button));
	reg tx_testblink;
	assign LEDR[9] = tx;

	// baud rate generator 
	wire baud;
	baudgenerator bgen(.clk(CLOCK_50),.baudOut(baud));

	// enable button
	
	parameter idle = 4'h0;
	parameter start = 4'h1;
	parameter bit0 = 4'h2;
	parameter bit1 = 4'h3;
	parameter bit2 = 4'h4;
	parameter bit3 = 4'h5;
	parameter bit4 = 4'h6;
	parameter bit5 = 4'h7;
	parameter bit6 = 4'h8;
	parameter bit7 = 4'h9;
	parameter stop = 4'hA;
	
	reg [3:0] state;
	reg [3:0] oldstate;
	assign LEDR[3:0] = oldstate;
	
	
	always @(posedge baud_button) begin
	
		oldstate <= state;
	
		case(state) 
			idle: begin // 0
				tx <= 1'b1;
				state <= start;
			end
			start: begin // 1
				tx <= 1'b0;
				state <= bit0;
			end
			bit0: begin // 2
				tx <= 1'b1;
				state <= bit1;
			end
			bit1: begin // 3
				tx <= 1'b1;
				state <= bit2;
			end
			bit2: begin // 4
				tx <= 1'b1;
				state <= bit3;
			end
			bit3: begin // 5
				tx <= 1'b1;
				state <= bit4;
			end
			bit4: begin // 6
				tx <= 1'b0;
				state <= bit5;
			end
			bit5: begin // 7
				tx <=1'b1;
				state <= bit6;
			end
			bit6: begin // 8
				tx <= 1'b1;
				state <= bit7;
			end
			bit7: begin // 9
				tx <= 1'b0;
				state <= stop;
			end
			stop: begin // 10
				tx <= 1'b1;
				state <= idle;
			end
		endcase
	
	end
	

	
endmodule