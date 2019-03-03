`timescale 1ns/1ns


module MyFIR
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


	localparam NUM_TAPS = 183;
	localparam H_WIDTH = 16;
	localparam Y_WIDTH = H_WIDTH + DATA_WIDTH - 1;
	
	
	integer i;

	reg signed [H_WIDTH-1:0] h[0:NUM_TAPS-1];
	wire signed [DATA_WIDTH-1:0] x;
	reg signed [Y_WIDTH-1:0] y;
	
	wire [7:0] raddr;
	reg [7:0] waddr;
	reg [7:0] last_waddr;

	reg [8:0] cnt;
	reg [7:0] deci_cnt;

	
	// Normalized Frequency: 0.0625
	initial begin
		h[0] = -8;
		h[1] = -7;
		h[2] = -4;
		h[3] = 0;
		h[4] = 4;
		h[5] = 7;
		h[6] = 10;
		h[7] = 12;
		h[8] = 11;
		h[9] = 9;
		h[10] = 5;
		h[11] = 0;
		h[12] = -6;
		h[13] = -12;
		h[14] = -17;
		h[15] = -19;
		h[16] = -19;
		h[17] = -16;
		h[18] = -9;
		h[19] = 0;
		h[20] = 10;
		h[21] = 21;
		h[22] = 29;
		h[23] = 33;
		h[24] = 33;
		h[25] = 27;
		h[26] = 16;
		h[27] = 0;
		h[28] = -18;
		h[29] = -35;
		h[30] = -48;
		h[31] = -55;
		h[32] = -54;
		h[33] = -44;
		h[34] = -25;
		h[35] = 0;
		h[36] = 28;
		h[37] = 56;
		h[38] = 77;
		h[39] = 88;
		h[40] = 86;
		h[41] = 69;
		h[42] = 39;
		h[43] = 0;
		h[44] = -44;
		h[45] = -85;
		h[46] = -117;
		h[47] = -134;
		h[48] = -130;
		h[49] = -105;
		h[50] = -59;
		h[51] = 0;
		h[52] = 66;
		h[53] = 128;
		h[54] = 175;
		h[55] = 199;
		h[56] = 194;
		h[57] = 156;
		h[58] = 89;
		h[59] = 0;
		h[60] = -98;
		h[61] = -190;
		h[62] = -262;
		h[63] = -298;
		h[64] = -291;
		h[65] = -235;
		h[66] = -134;
		h[67] = 0;
		h[68] = 150;
		h[69] = 293;
		h[70] = 406;
		h[71] = 467;
		h[72] = 459;
		h[73] = 374;
		h[74] = 217;
		h[75] = 0;
		h[76] = -250;
		h[77] = -499;
		h[78] = -707;
		h[79] = -835;
		h[80] = -847;
		h[81] = -717;
		h[82] = -434;
		h[83] = 0;
		h[84] = 563;
		h[85] = 1217;
		h[86] = 1914;
		h[87] = 2596;
		h[88] = 3204;
		h[89] = 3684;
		h[90] = 3990;
		h[91] = 4096;
		h[92] = 3990;
		h[93] = 3684;
		h[94] = 3204;
		h[95] = 2596;
		h[96] = 1914;
		h[97] = 1217;
		h[98] = 563;
		h[99] = 0;
		h[100] = -434;
		h[101] = -717;
		h[102] = -847;
		h[103] = -835;
		h[104] = -707;
		h[105] = -499;
		h[106] = -250;
		h[107] = 0;
		h[108] = 217;
		h[109] = 374;
		h[110] = 459;
		h[111] = 467;
		h[112] = 406;
		h[113] = 293;
		h[114] = 150;
		h[115] = 0;
		h[116] = -134;
		h[117] = -235;
		h[118] = -291;
		h[119] = -298;
		h[120] = -262;
		h[121] = -190;
		h[122] = -98;
		h[123] = 0;
		h[124] = 89;
		h[125] = 156;
		h[126] = 194;
		h[127] = 199;
		h[128] = 175;
		h[129] = 128;
		h[130] = 66;
		h[131] = 0;
		h[132] = -59;
		h[133] = -105;
		h[134] = -130;
		h[135] = -134;
		h[136] = -117;
		h[137] = -85;
		h[138] = -44;
		h[139] = 0;
		h[140] = 39;
		h[141] = 69;
		h[142] = 86;
		h[143] = 88;
		h[144] = 77;
		h[145] = 56;
		h[146] = 28;
		h[147] = 0;
		h[148] = -25;
		h[149] = -44;
		h[150] = -54;
		h[151] = -55;
		h[152] = -48;
		h[153] = -35;
		h[154] = -18;
		h[155] = 0;
		h[156] = 16;
		h[157] = 27;
		h[158] = 33;
		h[159] = 33;
		h[160] = 29;
		h[161] = 21;
		h[162] = 10;
		h[163] = 0;
		h[164] = -9;
		h[165] = -16;
		h[166] = -19;
		h[167] = -19;
		h[168] = -17;
		h[169] = -12;
		h[170] = -6;
		h[171] = 0;
		h[172] = 5;
		h[173] = 9;
		h[174] = 11;
		h[175] = 12;
		h[176] = 10;
		h[177] = 7;
		h[178] = 4;
		h[179] = 0;
		h[180] = -4;
		h[181] = -7;
		h[182] = -8;
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
				if (waddr == NUM_TAPS-1) begin
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
	
	assign raddr = (last_waddr + 1 + cnt <= NUM_TAPS-1)
					? last_waddr + 1 + cnt
					: last_waddr + 1 + cnt - NUM_TAPS;

	ram16x256 ram16x256_inst (
		.clock (clk),
		.data (ast_sink_data),
		.rdaddress (raddr),
		.wraddress (waddr),
		.wren (ast_sink_valid),
		.q (x)
	);


endmodule