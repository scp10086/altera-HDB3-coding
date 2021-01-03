module hdb3_add_b(
  input clk,
  input [1:0] add_b_in,
  output wire[1:0] add_b_out
);

parameter HDB3_0 = 2'B00; 
parameter HDB3_1 = 2'B01; 
parameter HDB3_V = 2'B11; 
parameter HDB3_B = 2'B10; 

parameter init = 2'b00;
parameter xV = 2'b01;
parameter V1= 2'b10;
reg[1:0] state = init;

reg [1:0] data[3:0];

always @(posedge clk) begin
  data[3] <= data[2];
  data[2] <= data[1];
  data[1] <= data[0];
  data[0] <= add_b_in;
end

always @(posedge clk)begin
  case(state)
  init:
  begin
    if(data[0] != HDB3_V) state <= init;
	 else state <= xV;
  end
  xV:
  begin
	 if(data[0] == HDB3_1) state <= V1;
	 else state <= xV;
  end
  V1:
  begin
    if(data[0] == HDB3_0) state <= V1;
	 else state <= xV;
  end
  endcase
end

assign add_b_out = ((data[0] == HDB3_V)&(state == xV)) ? HDB3_B:data[3];

endmodule
