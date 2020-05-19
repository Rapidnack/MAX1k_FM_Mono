// QsysCore.v

// Generated using ACDS version 18.1 625

`timescale 1 ps / 1 ps
module QsysCore (
		input  wire        clk_clk,                                                                                         //                                             clk.clk
		output wire [31:0] pio_0_external_connection_export,                                                                //                       pio_0_external_connection.export
		output wire [31:0] pio_1_external_connection_export,                                                                //                       pio_1_external_connection.export
		input  wire        reset_reset_n,                                                                                   //                                           reset.reset_n
		input  wire        spi_slave_to_avalon_mm_master_bridge_0_export_0_mosi_to_the_spislave_inst_for_spichain,          // spi_slave_to_avalon_mm_master_bridge_0_export_0.mosi_to_the_spislave_inst_for_spichain
		input  wire        spi_slave_to_avalon_mm_master_bridge_0_export_0_nss_to_the_spislave_inst_for_spichain,           //                                                .nss_to_the_spislave_inst_for_spichain
		inout  wire        spi_slave_to_avalon_mm_master_bridge_0_export_0_miso_to_and_from_the_spislave_inst_for_spichain, //                                                .miso_to_and_from_the_spislave_inst_for_spichain
		input  wire        spi_slave_to_avalon_mm_master_bridge_0_export_0_sclk_to_the_spislave_inst_for_spichain           //                                                .sclk_to_the_spislave_inst_for_spichain
	);

	wire  [31:0] spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdata;      // mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdata -> spi_slave_to_avalon_mm_master_bridge_0:readdata_to_the_altera_avalon_packets_to_master_inst_for_spichain
	wire         spi_slave_to_avalon_mm_master_bridge_0_avalon_master_waitrequest;   // mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_waitrequest -> spi_slave_to_avalon_mm_master_bridge_0:waitrequest_to_the_altera_avalon_packets_to_master_inst_for_spichain
	wire  [31:0] spi_slave_to_avalon_mm_master_bridge_0_avalon_master_address;       // spi_slave_to_avalon_mm_master_bridge_0:address_from_the_altera_avalon_packets_to_master_inst_for_spichain -> mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_address
	wire   [3:0] spi_slave_to_avalon_mm_master_bridge_0_avalon_master_byteenable;    // spi_slave_to_avalon_mm_master_bridge_0:byteenable_from_the_altera_avalon_packets_to_master_inst_for_spichain -> mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_byteenable
	wire         spi_slave_to_avalon_mm_master_bridge_0_avalon_master_read;          // spi_slave_to_avalon_mm_master_bridge_0:read_from_the_altera_avalon_packets_to_master_inst_for_spichain -> mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_read
	wire         spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdatavalid; // mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdatavalid -> spi_slave_to_avalon_mm_master_bridge_0:readdatavalid_to_the_altera_avalon_packets_to_master_inst_for_spichain
	wire         spi_slave_to_avalon_mm_master_bridge_0_avalon_master_write;         // spi_slave_to_avalon_mm_master_bridge_0:write_from_the_altera_avalon_packets_to_master_inst_for_spichain -> mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_write
	wire  [31:0] spi_slave_to_avalon_mm_master_bridge_0_avalon_master_writedata;     // spi_slave_to_avalon_mm_master_bridge_0:writedata_from_the_altera_avalon_packets_to_master_inst_for_spichain -> mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_avalon_master_writedata
	wire         mm_interconnect_0_pio_0_s1_chipselect;                              // mm_interconnect_0:pio_0_s1_chipselect -> pio_0:chipselect
	wire  [31:0] mm_interconnect_0_pio_0_s1_readdata;                                // pio_0:readdata -> mm_interconnect_0:pio_0_s1_readdata
	wire   [1:0] mm_interconnect_0_pio_0_s1_address;                                 // mm_interconnect_0:pio_0_s1_address -> pio_0:address
	wire         mm_interconnect_0_pio_0_s1_write;                                   // mm_interconnect_0:pio_0_s1_write -> pio_0:write_n
	wire  [31:0] mm_interconnect_0_pio_0_s1_writedata;                               // mm_interconnect_0:pio_0_s1_writedata -> pio_0:writedata
	wire         mm_interconnect_0_pio_1_s1_chipselect;                              // mm_interconnect_0:pio_1_s1_chipselect -> pio_1:chipselect
	wire  [31:0] mm_interconnect_0_pio_1_s1_readdata;                                // pio_1:readdata -> mm_interconnect_0:pio_1_s1_readdata
	wire   [1:0] mm_interconnect_0_pio_1_s1_address;                                 // mm_interconnect_0:pio_1_s1_address -> pio_1:address
	wire         mm_interconnect_0_pio_1_s1_write;                                   // mm_interconnect_0:pio_1_s1_write -> pio_1:write_n
	wire  [31:0] mm_interconnect_0_pio_1_s1_writedata;                               // mm_interconnect_0:pio_1_s1_writedata -> pio_1:writedata
	wire         rst_controller_reset_out_reset;                                     // rst_controller:reset_out -> [mm_interconnect_0:spi_slave_to_avalon_mm_master_bridge_0_clk_reset_reset_bridge_in_reset_reset, pio_0:reset_n, pio_1:reset_n, spi_slave_to_avalon_mm_master_bridge_0:reset_n]

	QsysCore_pio_0 pio_0 (
		.clk        (clk_clk),                               //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),       //               reset.reset_n
		.address    (mm_interconnect_0_pio_0_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_pio_0_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_pio_0_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_pio_0_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_pio_0_s1_readdata),   //                    .readdata
		.out_port   (pio_0_external_connection_export)       // external_connection.export
	);

	QsysCore_pio_0 pio_1 (
		.clk        (clk_clk),                               //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),       //               reset.reset_n
		.address    (mm_interconnect_0_pio_1_s1_address),    //                  s1.address
		.write_n    (~mm_interconnect_0_pio_1_s1_write),     //                    .write_n
		.writedata  (mm_interconnect_0_pio_1_s1_writedata),  //                    .writedata
		.chipselect (mm_interconnect_0_pio_1_s1_chipselect), //                    .chipselect
		.readdata   (mm_interconnect_0_pio_1_s1_readdata),   //                    .readdata
		.out_port   (pio_1_external_connection_export)       // external_connection.export
	);

	SPISlaveToAvalonMasterBridge #(
		.SYNC_DEPTH (2)
	) spi_slave_to_avalon_mm_master_bridge_0 (
		.clk                                                                    (clk_clk),                                                                                         //           clk.clk
		.reset_n                                                                (~rst_controller_reset_out_reset),                                                                 //     clk_reset.reset_n
		.mosi_to_the_spislave_inst_for_spichain                                 (spi_slave_to_avalon_mm_master_bridge_0_export_0_mosi_to_the_spislave_inst_for_spichain),          //      export_0.export
		.nss_to_the_spislave_inst_for_spichain                                  (spi_slave_to_avalon_mm_master_bridge_0_export_0_nss_to_the_spislave_inst_for_spichain),           //              .export
		.miso_to_and_from_the_spislave_inst_for_spichain                        (spi_slave_to_avalon_mm_master_bridge_0_export_0_miso_to_and_from_the_spislave_inst_for_spichain), //              .export
		.sclk_to_the_spislave_inst_for_spichain                                 (spi_slave_to_avalon_mm_master_bridge_0_export_0_sclk_to_the_spislave_inst_for_spichain),          //              .export
		.address_from_the_altera_avalon_packets_to_master_inst_for_spichain     (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_address),                                    // avalon_master.address
		.byteenable_from_the_altera_avalon_packets_to_master_inst_for_spichain  (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_byteenable),                                 //              .byteenable
		.read_from_the_altera_avalon_packets_to_master_inst_for_spichain        (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_read),                                       //              .read
		.readdata_to_the_altera_avalon_packets_to_master_inst_for_spichain      (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdata),                                   //              .readdata
		.readdatavalid_to_the_altera_avalon_packets_to_master_inst_for_spichain (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdatavalid),                              //              .readdatavalid
		.waitrequest_to_the_altera_avalon_packets_to_master_inst_for_spichain   (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_waitrequest),                                //              .waitrequest
		.write_from_the_altera_avalon_packets_to_master_inst_for_spichain       (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_write),                                      //              .write
		.writedata_from_the_altera_avalon_packets_to_master_inst_for_spichain   (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_writedata)                                   //              .writedata
	);

	QsysCore_mm_interconnect_0 mm_interconnect_0 (
		.clk_0_clk_clk                                                                (clk_clk),                                                            //                                                              clk_0_clk.clk
		.spi_slave_to_avalon_mm_master_bridge_0_clk_reset_reset_bridge_in_reset_reset (rst_controller_reset_out_reset),                                     // spi_slave_to_avalon_mm_master_bridge_0_clk_reset_reset_bridge_in_reset.reset
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_address                 (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_address),       //                   spi_slave_to_avalon_mm_master_bridge_0_avalon_master.address
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_waitrequest             (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_waitrequest),   //                                                                       .waitrequest
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_byteenable              (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_byteenable),    //                                                                       .byteenable
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_read                    (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_read),          //                                                                       .read
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdata                (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdata),      //                                                                       .readdata
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdatavalid           (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_readdatavalid), //                                                                       .readdatavalid
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_write                   (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_write),         //                                                                       .write
		.spi_slave_to_avalon_mm_master_bridge_0_avalon_master_writedata               (spi_slave_to_avalon_mm_master_bridge_0_avalon_master_writedata),     //                                                                       .writedata
		.pio_0_s1_address                                                             (mm_interconnect_0_pio_0_s1_address),                                 //                                                               pio_0_s1.address
		.pio_0_s1_write                                                               (mm_interconnect_0_pio_0_s1_write),                                   //                                                                       .write
		.pio_0_s1_readdata                                                            (mm_interconnect_0_pio_0_s1_readdata),                                //                                                                       .readdata
		.pio_0_s1_writedata                                                           (mm_interconnect_0_pio_0_s1_writedata),                               //                                                                       .writedata
		.pio_0_s1_chipselect                                                          (mm_interconnect_0_pio_0_s1_chipselect),                              //                                                                       .chipselect
		.pio_1_s1_address                                                             (mm_interconnect_0_pio_1_s1_address),                                 //                                                               pio_1_s1.address
		.pio_1_s1_write                                                               (mm_interconnect_0_pio_1_s1_write),                                   //                                                                       .write
		.pio_1_s1_readdata                                                            (mm_interconnect_0_pio_1_s1_readdata),                                //                                                                       .readdata
		.pio_1_s1_writedata                                                           (mm_interconnect_0_pio_1_s1_writedata),                               //                                                                       .writedata
		.pio_1_s1_chipselect                                                          (mm_interconnect_0_pio_1_s1_chipselect)                               //                                                                       .chipselect
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
