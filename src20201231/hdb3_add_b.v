module hdb3_add_b(
  input clk,
  input [1:0]add_b_in,
  output [1:0]add_b_out,
  output wire test_add_b
);

parameter HDB3_0 = 2'B00; 
parameter HDB3_1 = 2'B01; 
parameter HDB3_V = 2'B11; 
parameter HDB3_B = 2'B10; 

reg v_occur=0;
reg v_occur_2=0;
reg enen=0;
reg [1:0] d[3:0];
always @(posedge clk) begin
  d[3]<=d[2];
  d[2]<=d[1];
  d[1]<=d[0];
  d[0]<=add_b_in;
end

always @(posedge clk)begin
  if(d[0]==2'b11) begin//if times of V is even 
    v_occur<=1;
  end
  else if(d[0]==2'b01) begin
    enen<=~enen;
	 v_occur<=0;
//    firstv<=1;
  end
  if (d[0]==2'b00)begin
		v_occur<=0;
  end
//    firstv<=1;
end
assign test_add_b = !enen && (v_occur==1);
assign add_b_out=!enen && (v_occur==1) ? 2'b10 : d[3];

endmodule
