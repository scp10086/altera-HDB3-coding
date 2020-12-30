module hdb3_add_b(
  input clk,
  input [1:0]add_b_in,
  output [1:0]add_b_out
);

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
    enen<=0;
    v_occur<=1;
  end
  else if(d[0]==2'b01) begin
    enen<=~enen;
//    firstv<=1;
  end
  if(d[1]==2'b11) begin
	 v_occur_2<=1;
  end
//    firstv<=1;
end

assign add_b_out=!enen && (v_occur==1) && (v_occur_2==1) &&(d[0]==2'b11) ? 2'b10 : d[3];

endmodule
