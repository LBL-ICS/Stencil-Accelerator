`define ERROR_THRESHOLD 5  //5% error tolerace
`define BW 32
`define ST 5
`define COLUMNS 10
`define TILES 2 ////////(COLUMNS+ST -1)/ST // ceil (cols/sw)



//--------------------------------------------------------- 
//--- test cases  
//--------------------------------------------------------- 




module stencil_core_2d_tb();
//---------------------------------------------------------
//--- wire and reg declaration 
//---------------------------------------------------------
reg                     clock;
reg                     reset;
reg                     in_ready;
reg  [`BW*`ST-1 :0]     in_matrix   ;
reg  [`BW*`ST-1 :0]     in_weight    ;
reg  [`BW-1:0]          out_data;
reg                     out_valid;

// golden and input files
//
//

reg [`TILES*`BW-1:0] output_ram;
reg [`ST*`BW-1:0]    input_ram[0:`COLUMNS-1];

initial begin
	$readmemh("../golden/input.txt" , input_ram);
end






stencil_core_2d u_stencil_core_2d (.clock        (clock         ),
			.reset     (reset         ),
			.io_in_matrix  (in_matrix       ),
			.io_in_ready   (in_ready       ),
			.io_out_valid  (out_valid),
                   .io_in_weight            (in_weight          ),
	           .io_out_data        (out_data      ));
		  
//---------------------------------------------------------------------
//------- BFM
//---------------------------------------------------------------------
integer i, j;
always #5 clock = ~clock;
initial begin
   clock           = 1'b0;
   reset           = 1'b1;
   in_ready        = 1'b0;
   in_matrix      = `BW*`ST'h0;
   in_weight       = `BW*`ST'h0;             ;
  
    @(posedge clock );
 
   reset           = 1'b0;


   #10;
 @(posedge clock );

 for(i=0; i<`COLUMNS;i=i+1) begin
	in_ready        = 1'b1;
	in_matrix       = input_ram[i];
	in_weight      =160'h3F8000003F8000003F8000003F8000003F800000 ;  
// in_weight      = 96'h3F8000003F8000003F800000;


 @(posedge clock);
 end


   in_ready        = 1'b0;
   @(posedge clock);




 //   in_matrix     = 96'h4000000040A0000040E00000;
 //  in_weight      = 96'h3F8000003F8000003F800000;
    
 //   @(posedge clock);
 
 //   in_ready        = 1'b1;
 //   in_matrix     = 96'h4040000040E0000040000000;
 //  in_weight      = 96'h3F8000003F8000003F800000;

 //   @(posedge clock);
 //      in_ready        = 1'b1;
 //   in_matrix     = 96'h408000004080000040400000;
 
 //  in_weight      = 96'h3F8000003F8000003F800000;

// @(posedge clock);

/// second 3x3
// in_ready        = 1'b1;
//    in_matrix       = 96'h40A000004040000040800000;
 //  in_weight      = 96'h3F8000003F8000003F800000;
// @(posedge clock);


//  in_ready        = 1'b1;
//    in_matrix       = 96'h40E000004000000040E00000;
//   in_weight      = 96'h3F8000003F8000003F800000;
// @(posedge clock);


 // in_ready        = 1'b1;
 //   in_matrix       = 96'h410000004110000041000000;
//   in_weight      = 96'h3F8000003F8000003F800000;
// @(posedge clock);





   @(posedge clock);

 
end //initial begin-end





endmodule
