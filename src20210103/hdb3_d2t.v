module hdb3_d2t(
  input clk,
  input [1:0] polar_in,
  output reg [1:0] polar_out
);

parameter HDB3_P = 2'B10; //+1
parameter HDB3_N = 2'B01; //‐1
parameter HDB3_Z = 2'B00; //0

parameter HDB3_0 = 2'B00; 
parameter HDB3_1 = 2'B01; 
parameter HDB3_V = 2'B11; 
parameter HDB3_B = 2'B10; 
reg first_v = 0;
reg v_polar = 1;
reg b_polar = 1;

always @(clk) begin
  if(clk) begin            //enable in posedge
    if(polar_in == HDB3_V) begin//if the polar code is V
	   if(first_v == 0) begin
	       v_polar <= b_polar;
	   end
      polar_out <= v_polar ? HDB3_B : HDB3_1;
      v_polar <= ~v_polar;
	   first_v <= 1;
    end
    else if(polar_in == HDB3_1 || polar_in == HDB3_B) begin
      polar_out <= b_polar ? HDB3_B : HDB3_1;
      b_polar <= ~b_polar;
    end
    else begin//if the polar code if 0
      polar_out <= HDB3_0;
    end 
  end 
  else begin             //return zero in negedge
    if(polar_out[0] == 1) polar_out[0] <= 0;
    if(polar_out[1] == 1) polar_out[1] <= 0;
  end
end

endmodule // polar