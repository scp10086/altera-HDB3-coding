/***********************************************************************************
*-- 通信原理实验平台 -RZ9681
*-- 对应模块：  A2-基带数据产生码型变换模块
*-- 开发环境：  quartus II 13.1
*-- @注意：     例程所在目录路径不能包含中文字符！！
*-----------------------------------------------------------------------------------
*-- 功能说明：
*--   该模块可以完成基带数据产生,常见的码型变换等开发。 
*-----------------------------------------------------------------------------------
*--    Date     |   Author     |    version   |      notes
*--  2017.12.01 |    ZR        |      v1.0    |      初始版本
*-----------------------------------------------------------------------------------
*-  @说明
*-   该代码为实验平台二次开发代码,供学生做二次开发使用,请勿随意传播或应用于商业用途。
*******************COPYRIGHT 2017  南京润众科技有限公司*******************************/
module Board02(
					input  wire SYSCLK,//16.384MHz-主时钟
					input  wire MRESET,//reset
					output wire RUN,   //run_led
					//UART interface 
					input  wire U3TXD, //UART_R
					output wire U3RXD, //UART_T
					//
					output  wire PN,           //2P01
					output  wire DPN,          //2P02
					output  wire PNCLK,        //2P03
					
					//input  wire EXIDATA,    //2P04
					//input  wire EXICLK,     //2P05
					output  wire CODE1,       //2P4+
					output  wire CODE2,       //2P4-
					input  wire RHDB31,       //2P7+
					input  wire RHDB32,       //2P7-
					output  wire RECOVER_CLK,  //2P8					
					output  wire RECOVER_DATA, //2P9
					output wire NOISE,        //2P6
					//
					input  wire HOLD,         //Reserve
					input  wire S2NSS,        //Reserve
					input  wire S2CLK,        //Reserve
					input  wire S2MISO,       //Reserve
					input  wire S2MOSI,       //Reserve
					//
					input  wire  WMD,         //Reserve
					input  wire  DATA         //Reserve
);
//////////////////////////////////////////////////////////////////////////////
//Pll*4
wire clk;
pllx4 pllx4_inst(
	.inclk0(SYSCLK),//16.384Mhz
	.c0(clk)//65.536Mhz
);
//////////////////////////////////////////////////////////////////////////////
wire dpn_out; 
//PN序列生成器 
wire jd_valid;
jd_gen jd_gen_init1(
			.clk(clk),
			.reset_n(MRESET),//reset信号，未使用
			.jd_valid(jd_valid),//使能输出
			.jd_clk(PNCLK),    //时钟输出
			.jd_data(PN),   //数据输出
			.jd_xd(dpn_out)	    //相对码输出
);
/***********************************************************************************
************************************************************************************
*-  在下面填写自己的代码
************************************************************************************
***********************************************************************************/
wire [1:0] data_add_v;
wire [1:0] data_add_b;
wire [1:0] data_polar_out;
reg test_in = 0;
wire test_add_v_wire;
wire test_out_change;
wire test_add_b_wire;
hdb3_add_v hdb2addv(
			.clk(PNCLK),
			.data_in(test_in),
			.data_v(data_add_v),
			.test_add_v(DPN)
);
hdb3_add_b hdb3addb(
			.clk(PNCLK),
			.add_b_in(data_add_v),
			.add_b_out(data_add_b),
			.test_add_b(RECOVER_CLK)
);
hdb3_d2t hdb3d2t(
			.clk(PNCLK),
			.polar_in(data_add_b),
			.polar_out(data_polar_out),
			.test_out(test_out_change)
);
assign CODE1 = data_polar_out[1];
assign CODE2 = data_polar_out[0];

//assign CODE1 = 0;
//assign CODE2 = PN;

//assign RECOVER_CLK = data_polar_out[1];
//assign RECOVER_DATA = data_polar_out[0];


/***********************************************************************************
************************************************************************************
*-  以下部分为运行指示灯显示
************************************************************************************
***********************************************************************************/
reg LED;
reg[23:0] cnt;
always @(posedge SYSCLK)begin
	cnt <= cnt + 1'b1;
	
	if(cnt == 24'hFFFFFF)begin
		cnt <= 0;
		LED <= ~LED;
	end

end

assign RUN = DPN;
assign NOISE = 0;
endmodule
