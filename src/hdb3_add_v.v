module hdb3_add_v(
    input clk,
    input data_in,
    output reg [1:0]data_v
);

parameter HDB3_0 = 2'B00; 
parameter HDB3_1 = 2'B01; 
parameter HDB3_V = 2'B11; 
parameter HDB3_B = 2'B10; 

reg [1:0]count=0;
always @(posedge clk) begin
  if(data_in== 1'b1) begin
    count<=0; 
    data_v<=2'b01;
  end
  else begin
    count<=count+1;
    if(count==3'd4)begin
      data_v<=2'b11;
      count<=0;
    end
    else
      data_v<=2'b00;
  end
  
end

endmodule
