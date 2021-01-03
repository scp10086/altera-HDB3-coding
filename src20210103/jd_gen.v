module jd_gen(
			input wire clk,
			input wire reset_n,
			output wire jd_valid,    //使能输出
			output reg jd_clk,    //时钟输出
			output reg jd_data,   //数据输出
			output reg jd_xd	    //相对码输出
);

reg data_valid;
wire PN15,PN31,PN511;

assign jd_valid = data_valid;


reg[14:0] count_div;
reg d1;

initial
begin
data_valid <= 0;
count_div <= 14'b0;
d1 <= 0;
end

always @(posedge clk)begin
	count_div <= count_div + 1'b1;	

	begin
		d1 <= count_div[2];
		jd_clk <= d1;
		
		if(d1==1 && count_div[2] == 0)      data_valid <= 1;
		else	                               data_valid <= 0;	
			
	end
end


reg[3:0] count_data;
always @(posedge clk)begin
	if(data_valid)begin
		jd_data <= PN15;
		jd_xd <= jd_xd ^ PN15;
	end
end


PN15 PN_gen_inst1(
					.clk(clk),
					.reset_n(reset_n),			
					.valid(data_valid),
					.PN15(PN15),
					.PN31(PN31),
					.PN511(PN511),
					.PN1023(),
					.PN2047()					
);



endmodule

