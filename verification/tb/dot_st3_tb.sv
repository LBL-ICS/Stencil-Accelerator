`define ERROR_THRESHOLD 5  //5% error tolerace
`define BW 32
`define ST 3




//--------------------------------------------------------- 
//--- test cases  
//--------------------------------------------------------- 




module dot_st3_tb();
//---------------------------------------------------------
//--- wire and reg declaration 
//---------------------------------------------------------
reg                     clock;
reg                     reset;
reg                     in_ready;
reg  [`BW*`ST-1 :0]     in_data    ;
reg  [`BW*`ST-1 :0]     in_weight    ;
reg  [`BW-1:0]          out_data;



Dot_real u_Dot_real (.clock        (clock         ),
			.reset     (reset         ),
			.io_in_data   (in_data       ),
			.io_in_ready   (in_ready       ),

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
   in_data       = `BW*`ST'h0;
   in_weight       = `BW*`ST'h0;             ;
  
    @(posedge clock );
 
   reset           = 1'b0;
   in_ready        = 1'b1;
    in_data       = 96'h3F8000003F8000003F800000;
   in_weight      = 96'h3F8000003F8000003F800000;
    
    @(posedge clock);
 
  in_ready        = 1'b1;
    in_data       = 96'h40400000bf800000c0a00000;
   in_weight      = 96'h4000000040800000c0000000;


    @(posedge clock);
 
end //initial begin-end

endmodule
