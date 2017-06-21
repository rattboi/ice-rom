module top (
	input  CLK,
	input  RX,
  input [12:0] ADDR,
	output TX,
	output [7:0] DATA,
  output reg [4:0] LEDS
);

  // ROM simulator instance
  rom rom1(CLK, ADDR, DATA);

  // UART instance
  uart debug(CLK, RX, TX, LEDS);

endmodule
