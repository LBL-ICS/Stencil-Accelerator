`define ERROR_THRESHOLD 5  //5% error tolerace
`define BW 32
`define ST 3
`define COLUMNS 6
`define ROWS 6
`define TILES 2 ////////(COLUMNS+ST -1)/ST // ceil (cols/sw)



//--------------------------------------------------------- 
//--- test cases  
//--------------------------------------------------------- 




module datapath_st3_tb_3d();
//---------------------------------------------------------
//--- wire and reg declaration 
//---------------------------------------------------------
reg                     clock;
reg                     reset;
reg                     datapath_ready_in;
reg  [`BW*`ST*`ST-1 :0]     datapath_data_in  ;
//reg  [`BW*`ST-1 :0]     in_weight    ;
reg  [`BW-1:0]          datapath_data_out1;
reg  [`BW-1:0]          datapath_data_out2;
reg  [`BW-1:0]          datapath_data_out3;

reg  [`BW-1:0]          datapath_data_out4;
reg  [`BW-1:0]          datapath_data_out5;
reg  [`BW-1:0]          datapath_data_out6;


reg                     datapath_valid_out1;
reg                     datapath_valid_out2;
reg                     datapath_valid_out3;

// golden and input files
//
//

reg [`TILES*`BW-1:0] output_ram;
reg [`ST*`BW*`ST-1:0]    input_ram[0:`COLUMNS-1];

initial begin
	$readmemh("../golden/input_3d.txt" , input_ram);
end






laplace_3d u_laplace_3d (.clock        (clock         ),
			.reset     (reset         ),
			.io_datapath_data_in  (datapath_data_in       ),
			.io_datapath_ready_in   (datapath_ready_in       ),
			.io_datapath_data_out1  (datapath_data_out1),
			.io_datapath_data_out2  (datapath_data_out2),
			.io_datapath_data_out3  (datapath_data_out3),
			.io_datapath_data_out4    (datapath_data_out4),
			.io_datapath_data_out5    (datapath_data_out5),
			.io_datapath_data_out6    (datapath_data_out6)
			);
//			.io_datapath_data_out1  (datapath_data_out1),
//			.io_datapath_data_out2  (datapath_data_out2),
//			.io_datapath_data_out3  (datapath_data_out3));

  //                 .io_in_weight            (in_weight          ),
	        //   .io_out_data        (out_data      ));
		  
//---------------------------------------------------------------------
//------- BFM
//---------------------------------------------------------------------
integer i, j;
always #5 clock = ~clock;
initial begin
   clock           = 1'b0;
   reset           = 1'b1;
   datapath_ready_in        = 1'b0;
   datapath_data_in     = `BW*`ST*`ST'h0;
//   in_weight       = `BW*`ST'h0;             ;
  
  #100; 
  

  #15;
  

 for(i=0; i<`COLUMNS;i=i+1) begin
	 @(posedge clock);  // wait for negedge
	reset= 1'b0;
	datapath_ready_in       = 1'b1;
	datapath_data_in       = input_ram[i];
//	in_weight      =160'h3F8000003F8000003F8000003F8000003F800000 ;  
// in_weight      = 96'h3F8000003F8000003F800000;


 
 end


    datapath_ready_in    = 1'b0;
   @(posedge clock);




 //   in_matrix     = 96'h4000000040A0000040E00000;
 //  in_weight      = 96'h3F8000003F8000003F800000;
    
 //   @(posedge clock);
 
 


   @(posedge clock);

 
end //initial begin-end





endmodule
