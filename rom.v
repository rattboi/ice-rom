module rom (
	input  CLK,
  input [12:0] ADDR,
	output reg [7:0] DATA,
);

  // ROM simulator part
  reg [7:0] ROM [0:2047];
  initial begin
    $readmemh("rom.hex", ROM);
  end

  always @(posedge CLK)
    DATA <= ADDR[11] ? ROM[ADDR[10:0]] : 8'bXXXXXXXX;

endmodule
