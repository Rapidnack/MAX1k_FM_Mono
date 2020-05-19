`timescale 1 ps / 1 ps

module top
(
	input wire CLK,
		
	input wire SPI_SCLK,
	input wire SPI_NSS,
	input wire SPI_MOSI,
	output wire SPI_MISO,
	
	input wire [7:0] ADC,
	output wire ENCODE,

	output wire I2S_SCK,
	output wire I2S_BCK,
	output wire I2S_LRCK,
	output wire I2S_DATA,
	
	output reg [6:0] DACA,
	output reg [6:0] DACB,
	
	output wire [7:0] LED
);

	localparam CIC_WIDTH = 19;
	localparam FIR_WIDTH = 16;
	localparam PI = 17'sb0011_0010_0100_0011_1; // pi = 0011 . 0010 0100 0011 1111 0110 1010

	wire [31:0] pio0;
	wire [31:0] pio1;
	
	wire clk; // 73.728M (actual 73.714286M)
	
	wire [3:0] gain;
	wire [3:0] volume;

	reg [7:0] uadc_r;
	wire signed [7:0] adc;
	
	wire signed [11:0] sin;
	wire signed [11:0] cos;
	
	reg signed [CIC_WIDTH-1:0] i;
	reg signed [CIC_WIDTH-1:0] q;

	wire signed [CIC_WIDTH-1:0] icic;
	wire icic_valid;
	wire signed [CIC_WIDTH-1:0] qcic;
	wire qcic_valid;

	wire signed [FIR_WIDTH-1:0] ifir;
	wire ifir_valid;
	wire signed [FIR_WIDTH-1:0] qfir;
	wire qfir_valid;

	wire signed [FIR_WIDTH-1:0] phase;
	reg signed [FIR_WIDTH-1:0] phase_r;
	wire signed [FIR_WIDTH:0] phase_diff;
	reg signed [FIR_WIDTH:0] freq;
	
	wire signed [FIR_WIDTH-1:0] freq_LPR;
	wire freq_LPR_valid;
	wire signed [FIR_WIDTH-1:0] freq_LPRD;
	wire freq_LPRD_valid;
	
	wire signed [6:0] daca;
	wire signed [6:0] dacb;

	pll	pll_inst (
		.inclk0 (CLK),
		.c0 (clk)
	);
	
	QsysCore u0 (
		.clk_clk                                                                                         (clk),
		.reset_reset_n                                                                                   (1'b1),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_mosi_to_the_spislave_inst_for_spichain          (SPI_MOSI),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_nss_to_the_spislave_inst_for_spichain           (SPI_NSS),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_miso_to_and_from_the_spislave_inst_for_spichain (SPI_MISO),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_sclk_to_the_spislave_inst_for_spichain          (SPI_SCLK),
		.pio_0_external_connection_export                                                                (pio0),
		.pio_1_external_connection_export                                                                (pio1)
	);

	assign LED = pio0[7:0];
	assign gain = 3;
	assign volume = pio0[3:0];

	always @(posedge clk) begin
		uadc_r <= ADC;
	end
	assign ENCODE = clk;
	assign adc = (uadc_r[7] == 0) ? uadc_r + 8'h80 : uadc_r - 8'h80;

	MyNCO #(
		.OUT_WIDTH(12)
	) nco_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.clken     (1'b1),
		.phi_inc_i (pio1),
		.fsin_o    (sin),
		.fcos_o    (cos),
		.out_valid ()
	);

	always @(posedge clk) begin
		i <= adc * cos;
		q <= adc * -sin;
	end
	
	MyCIC #(
		.DATA_WIDTH(CIC_WIDTH)
	) cic_inst_i (
		.clk       (clk),
		.reset_n   (1'b1),
		.in_error  (2'b00),
		.in_valid  (1'b1),
		.in_ready  (),
		.in_data   (i),
		.out_data  (icic),
		.out_error (),
		.out_valid (icic_valid),
		.out_ready (1'b1)
	);

	MyCIC #(
		.DATA_WIDTH(CIC_WIDTH)
	) cic_inst_q (
		.clk       (clk),
		.reset_n   (1'b1),
		.in_error  (2'b00),
		.in_valid  (1'b1),
		.in_ready  (),
		.in_data   (q),
		.out_data  (qcic),
		.out_error (),
		.out_valid (qcic_valid),
		.out_ready (1'b1)
	);
  
	MyFIR #(
		.DATA_WIDTH(FIR_WIDTH)
	) fir8_inst_i (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (icic[CIC_WIDTH-1 -gain -: FIR_WIDTH]),
		.ast_sink_valid (icic_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (ifir),
		.ast_source_valid (ifir_valid),
		.ast_source_error ()
	);
 
	MyFIR #(
		.DATA_WIDTH(FIR_WIDTH)
	) fir8_inst_q (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (qcic[CIC_WIDTH-1 -gain -: FIR_WIDTH]),
		.ast_sink_valid (qcic_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (qfir),
		.ast_source_valid (qfir_valid),
		.ast_source_error ()
	);
 
	vectran vectran_inst (
		.clk    (clk),
		.areset (1'b0),
		.x      (ifir),
		.y      (qfir),
		.q      (phase),
		.r      (),
		.en     (ifir_valid)
	);

	always @(posedge clk) begin
		if (ifir_valid) begin
			phase_r <= phase;
			
			if (phase_diff > PI) begin
				freq <= phase_diff - (PI <<< 1);
			end
			else if (phase_diff < -PI) begin
				freq <= phase_diff + (PI <<< 1);
			end
			else begin
				freq <= phase_diff;
			end
		end
	end
	assign phase_diff = phase - phase_r;
  
	MyLPF #(
		.DATA_WIDTH(FIR_WIDTH)
	) lpf8_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (freq[FIR_WIDTH-1 -: FIR_WIDTH]),
		.ast_sink_valid (ifir_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (freq_LPR),
		.ast_source_valid (freq_LPR_valid),
		.ast_source_error ()
	);

	MyDeEmphasis #(
		.DATA_WIDTH(FIR_WIDTH)
	) MyDeEmphasis_inst (
		.clk (clk),
		.reset_n (1'b1),
		.in_data (freq_LPR),
		.in_valid (freq_LPR_valid),
		.out_data (freq_LPRD),
		.out_valid (freq_LPRD_valid)
	);
	
	MyI2S #(
		.IN_WIDTH(FIR_WIDTH)
	) MyI2S_inst (
		.clk (clk),
		.reset_n (1'b1),	
		.volume (4'b1111 - volume),
		.in_left (freq_LPRD),
		.in_right (freq_LPRD),
		.in_valid (freq_LPRD_valid),
		.SCK (I2S_SCK),
		.BCK (I2S_BCK),
		.LRCK (I2S_LRCK),
		.DATA (I2S_DATA)
	);


//	assign daca = sin[11 -: 7];
//	assign dacb = cos[11 -: 7];	
//	assign daca = i[CIC_WIDTH-1 -: 7];
//	assign dacb = q[CIC_WIDTH-1 -: 7];
//	assign daca = icic[CIC_WIDTH-1 -: 7]; // icic_valid
//	assign dacb = qcic[CIC_WIDTH-1 -: 7]; // qcic_valid
//	assign daca = ifir[FIR_WIDTH-1 -: 7]; // ifir_valid
//	assign dacb = qfir[FIR_WIDTH-1 -: 7]; // qfir_valid
//	assign daca = phase[FIR_WIDTH-1 -: 7]; // ifir_valid
//	assign dacb = freq[FIR_WIDTH -: 7]; // ifir_valid
//	assign daca = freq_LPR[FIR_WIDTH-1 -: 7]; // freq_LPR_valid
//	assign dacb = freq_LPRD[FIR_WIDTH-1 -: 7]; // freq_LPRD_valid

	assign daca = i[CIC_WIDTH-1 -: 7];
	assign dacb = ifir[FIR_WIDTH-1 -: 7];
	always @(posedge clk) begin
		DACA <= (daca[6] == 0) ? daca + 7'h40 : daca - 7'h40;
		if (ifir_valid)
			DACB <= (dacb[6] == 0) ? dacb + 7'h40 : dacb - 7'h40;
	end
 	
endmodule