module hdb3_d2t(
  input clk,
  input [1:0]polar_in,
  output reg [1:0]polar_out
);

parameter HDB3_P = 2'B10; //+1
parameter HDB3_N = 2'B01; //‐1
parameter HDB3_Z = 2'B00; //0

parameter HDB3_0 = 2'B00; 
parameter HDB3_1 = 2'B01; 
parameter HDB3_V = 2'B11; 
parameter HDB3_B = 2'B10; 
reg first_v =0;
reg v_polar=1;
reg b_polar=1;
always @(posedge clk) begin
  if(polar_in==2'b11) begin//if the polar code is V
	 if(first_v == 0) begin
	     v_polar <= b_polar;
	 end
    polar_out<=v_polar ? 2'b01 : 2'b11;
    v_polar<=~v_polar;
	 first_v <= 1;
  end
  else if(polar_in==2'b01 || polar_in==2'b10) begin
    polar_out<=first_v ? 2'b10 : 2'b01;
    b_polar<=~b_polar;
  end
  else begin//if the polar code if 0
    polar_out<=2'b00;
  end 
end

endmodule // polar