module top (
	input  CLK,
  input [12:0] ADDR,
	output TX,
	output [7:0] DATA,
  output reg [4:0] LEDS
);

  reg uart_busy;
  reg uart_wr_i;
  reg uart_dat_i;
  reg sys_rst_i;

  // ROM simulator instance
  rom rom1(CLK, ADDR, DATA);

  // debug UART instance
  uart debug(uart_busy, TX, uart_wr_i, uart_dat_i, CLK, sys_rst_i);

endmodule
