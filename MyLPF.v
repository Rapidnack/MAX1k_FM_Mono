`timescale 1ns/1ns


module MyLPF
#(
	parameter RATE = 8,
	parameter DATA_WIDTH = 16
)
(
	input wire clk,
	input wire reset_n,
	
	input wire signed [DATA_WIDTH-1:0] ast_sink_data,
	input wire ast_sink_valid,
	input wire [1:0] ast_sink_error,

	output reg signed [DATA_WIDTH-1:0] ast_source_data,
	output reg ast_source_valid,
	output wire [1:0] ast_source_error
);


	localparam NUM_TAPS = 199;
	localparam H_WIDTH = 16;
	localparam Y_WIDTH = H_WIDTH + DATA_WIDTH - 1;

	// RAM 16x256
	localparam RAM_NUM_ADDRS = 256;
	
	
	integer i;

	reg signed [H_WIDTH-1:0] h[0:NUM_TAPS-1];
	wire signed [DATA_WIDTH-1:0] x;
	reg signed [Y_WIDTH-1:0] y;
	
	wire [7:0] raddr;
	reg [7:0] waddr;
	reg [7:0] last_waddr;

	reg [8:0] cnt;
	reg [7:0] deci_cnt;

	
	// Normalized Frequency: 0.042
	initial begin
		h[0] = 7;
		h[1] = 6;
		h[2] = 4;
		h[3] = 2;
		h[4] = -1;
		h[5] = -3;
		h[6] = -6;
		h[7] = -8;
		h[8] = -10;
		h[9] = -11;
		h[10] = -12;
		h[11] = -12;
		h[12] = -11;
		h[13] = -9;
		h[14] = -7;
		h[15] = -3;
		h[16] = 2;
		h[17] = 6;
		h[18] = 11;
		h[19] = 16;
		h[20] = 20;
		h[21] = 24;
		h[22] = 25;
		h[23] = 25;
		h[24] = 23;
		h[25] = 19;
		h[26] = 13;
		h[27] = 5;
		h[28] = -4;
		h[29] = -14;
		h[30] = -25;
		h[31] = -34;
		h[32] = -43;
		h[33] = -49;
		h[34] = -51;
		h[35] = -51;
		h[36] = -46;
		h[37] = -37;
		h[38] = -24;
		h[39] = -8;
		h[40] = 10;
		h[41] = 29;
		h[42] = 49;
		h[43] = 67;
		h[44] = 81;
		h[45] = 91;
		h[46] = 95;
		h[47] = 92;
		h[48] = 82;
		h[49] = 65;
		h[50] = 42;
		h[51] = 12;
		h[52] = -21;
		h[53] = -56;
		h[54] = -89;
		h[55] = -120;
		h[56] = -144;
		h[57] = -160;
		h[58] = -166;
		h[59] = -160;
		h[60] = -141;
		h[61] = -110;
		h[62] = -67;
		h[63] = -16;
		h[64] = 42;
		h[65] = 102;
		h[66] = 160;
		h[67] = 212;
		h[68] = 253;
		h[69] = 280;
		h[70] = 288;
		h[71] = 276;
		h[72] = 242;
		h[73] = 187;
		h[74] = 111;
		h[75] = 19;
		h[76] = -85;
		h[77] = -194;
		h[78] = -302;
		h[79] = -401;
		h[80] = -482;
		h[81] = -537;
		h[82] = -559;
		h[83] = -542;
		h[84] = -481;
		h[85] = -374;
		h[86] = -220;
		h[87] = -21;
		h[88] = 218;
		h[89] = 491;
		h[90] = 789;
		h[91] = 1102;
		h[92] = 1417;
		h[93] = 1724;
		h[94] = 2009;
		h[95] = 2261;
		h[96] = 2469;
		h[97] = 2624;
		h[98] = 2720;
		h[99] = 2752;
		h[100] = 2720;
		h[101] = 2624;
		h[102] = 2469;
		h[103] = 2261;
		h[104] = 2009;
		h[105] = 1724;
		h[106] = 1417;
		h[107] = 1102;
		h[108] = 789;
		h[109] = 491;
		h[110] = 218;
		h[111] = -21;
		h[112] = -220;
		h[113] = -374;
		h[114] = -481;
		h[115] = -542;
		h[116] = -559;
		h[117] = -537;
		h[118] = -482;
		h[119] = -401;
		h[120] = -302;
		h[121] = -194;
		h[122] = -85;
		h[123] = 19;
		h[124] = 111;
		h[125] = 187;
		h[126] = 242;
		h[127] = 276;
		h[128] = 288;
		h[129] = 280;
		h[130] = 253;
		h[131] = 212;
		h[132] = 160;
		h[133] = 102;
		h[134] = 42;
		h[135] = -16;
		h[136] = -67;
		h[137] = -110;
		h[138] = -141;
		h[139] = -160;
		h[140] = -166;
		h[141] = -160;
		h[142] = -144;
		h[143] = -120;
		h[144] = -89;
		h[145] = -56;
		h[146] = -21;
		h[147] = 12;
		h[148] = 42;
		h[149] = 65;
		h[150] = 82;
		h[151] = 92;
		h[152] = 95;
		h[153] = 91;
		h[154] = 81;
		h[155] = 67;
		h[156] = 49;
		h[157] = 29;
		h[158] = 10;
		h[159] = -8;
		h[160] = -24;
		h[161] = -37;
		h[162] = -46;
		h[163] = -51;
		h[164] = -51;
		h[165] = -49;
		h[166] = -43;
		h[167] = -34;
		h[168] = -25;
		h[169] = -14;
		h[170] = -4;
		h[171] = 5;
		h[172] = 13;
		h[173] = 19;
		h[174] = 23;
		h[175] = 25;
		h[176] = 25;
		h[177] = 24;
		h[178] = 20;
		h[179] = 16;
		h[180] = 11;
		h[181] = 6;
		h[182] = 2;
		h[183] = -3;
		h[184] = -7;
		h[185] = -9;
		h[186] = -11;
		h[187] = -12;
		h[188] = -12;
		h[189] = -11;
		h[190] = -10;
		h[191] = -8;
		h[192] = -6;
		h[193] = -3;
		h[194] = -1;
		h[195] = 2;
		h[196] = 4;
		h[197] = 6;
		h[198] = 7;
	end

	
	assign ast_source_error = 2'b00;
	
	always @(posedge clk)
	begin
		if (~reset_n) begin
			waddr <= 0;
			cnt <= 0;
			
			deci_cnt <= 0;
			
			y <= 0;
			ast_source_data <= 0;
			ast_source_valid <= 1'b0;
		end
		else begin
			
			if (ast_sink_valid) begin			
				if (waddr == RAM_NUM_ADDRS-1) begin
					waddr <= 0;
				end
				else begin
					waddr <= waddr + 1;			
				end
								
				if (deci_cnt == RATE-1) begin
					deci_cnt <= 0;
					
					ast_source_data <= y[Y_WIDTH-1 -: DATA_WIDTH];
					ast_source_valid <= 1'b1;
					
					last_waddr <= waddr;
					cnt <= 0;
					y <= 0;
				end
				else begin
					deci_cnt <= deci_cnt + 1;
					
					if (cnt < NUM_TAPS) begin
						cnt <= cnt + 1;
					end
					if (cnt < NUM_TAPS) begin
						y <= y + h[cnt] * x;
					end
					ast_source_valid <= 1'b0;
				end
			end
			else begin
				if (cnt < NUM_TAPS) begin
					cnt <= cnt + 1;
				end
				if (cnt < NUM_TAPS) begin
					y <= y + h[cnt] * x;
				end
				ast_source_valid <= 1'b0;
			end
		end
	end
	
	assign raddr = (last_waddr + 1 + cnt <= RAM_NUM_ADDRS-1)
					? last_waddr + 1 + cnt
					: last_waddr + 1 + cnt - RAM_NUM_ADDRS;

	ram16x256 ram16x256_inst (
		.clock (clk),
		.data (ast_sink_data),
		.rdaddress (raddr),
		.wraddress (waddr),
		.wren (ast_sink_valid),
		.q (x)
	);


endmodule