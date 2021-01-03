module hdb3_add_v(
    input clk,
    input data_in,
    output reg [1:0]data_v
);

parameter HDB3_0 = 2'B00; 
parameter HDB3_1 = 2'B01; 
parameter HDB3_V = 2'B11; 
parameter HDB3_B = 2'B10; 

reg [2:0]count=0;

always @(posedge clk) begin
  if(data_in == 1) begin
    count <= 0; 
    data_v <= HDB3_1;
  end
  else begin
    count <= count+1;
    if(count == 3)begin
      data_v <= HDB3_V;
      count <= 0;
    end
    else begin
      data_v <= HDB3_0;
		end
  end
  
end

endmodule
