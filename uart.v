module uart (
	input  CLK,
	input  RX,
	output TX,
  output reg [4:0] LEDS
);
  // UART part
	parameter integer BAUD_RATE = 9600;
	parameter integer CLOCK_FREQ_HZ = 12000000;
	localparam integer HALF_PERIOD = CLOCK_FREQ_HZ / (2 * BAUD_RATE);

	reg [7:0] buffer;
	reg buffer_valid;

	reg [$clog2(3*HALF_PERIOD):0] cycle_cnt;
	reg [3:0] bit_cnt = 0;
	reg recv = 0;

	always @(posedge CLK) begin
		buffer_valid <= 0;
		if (!recv) begin
			if (!RX) begin
				cycle_cnt <= HALF_PERIOD;
				bit_cnt <= 0;
				recv <= 1;
			end
		end else begin
			if (cycle_cnt == 2*HALF_PERIOD) begin
				cycle_cnt <= 0;
				bit_cnt <= bit_cnt + 1;
				if (bit_cnt == 9) begin
					buffer_valid <= 1;
					recv <= 0;
				end else begin
					buffer <= {RX, buffer[7:1]};
				end
			end else begin
				cycle_cnt <= cycle_cnt + 1;
			end
		end
	end

	always @(posedge CLK) begin
		if (buffer_valid) begin
			if (buffer == "1") LEDS[0] <= !LEDS[0];
			if (buffer == "2") LEDS[1] <= !LEDS[1];
			if (buffer == "3") LEDS[2] <= !LEDS[2];
			if (buffer == "4") LEDS[3] <= !LEDS[3];
			if (buffer == "5") LEDS[4] <= !LEDS[4];
		end
	end

	assign TX = RX;
endmodule
