# altera-HDB3-coding
东南大学信息学院大四通信系统实验组HDB3编码FPGA实验

# 实验要求

- 产生一组随机序列，作为待编码数据
- 对原始数据进行HDB3编码
- 使用现有电路，输出双极性码，用示波器观测
- 在编码基础上完成译码算法。（提高部分）

任务：在FPGA中产生基带数据和相关时钟，并对这个数据进行HDB3编码；
产生速率16KHZ，码长15位的随机码，并从2P1输出；
用2P1的数据进行HDB3编码，正极性和负极性信号分别从CODE1和CODE2输出；
正负极性信号经极性变换电路从2P4输出三电平双极性归零HDB3码；
2P3输出HDB3时钟；
开发扩展功能：将HDB3编码速率改为64KHZ；

# 开发语言
verilog hdl（建议） 

# 开发环境
Quartus 13.1（建议版本）

# 硬件
FPGA芯片型号：EP4CE6E22C8
时钟 16.384Mhz \*4 =65.536Mhz
|使用的模块| A2基带信号产生与码型变换模块 |
| - | - |
|PN 序列输出| 2p1 |
|正极性信号| code1 |
|负极性信号| code2 |
|电平双极性归零HDB3码| 2p4 |
|HDB3时钟| 2p3 |
|使用的demo|ex1_A2|

code1 和 code2 实现 减法器电路 的输入 $` V_out = V_code1 - V_code2 `$
# 下载
准备 网线 一根

使用quartus ii 编译完程序后，在工程的output_files文件夹里面生成了一个xxxxx.sof文件。

转换sof为rbf;

打开quartus ii -》file->convert Programming file ;

Programming file type 选择Raw Binary file(.rbf),然后选择生成rbf的路径。

在Input file to convert栏点击SOF Data ,点击add file ,选择刚刚生成的xxxxx.sof文件

点generate生成rbf文件。

寻找试验箱IP 理论上为10.10.10.185

电脑IP设置：
                    IP地址：   10.10.10.xxx（xxx和实验箱不重复）
                    子网掩码：255.255.255.0

设置好之后，可以通过电脑的ping命令，测试网络是否已通。

在试验箱上选择二次开发， 加载rbf文件。如果实验箱有多个FPGA芯片，从右向左计数

# 实验原理
[通信原理中的HDB3码的编码规则](https://zhuanlan.zhihu.com/p/86177759)

[HDB3编译码原理](https://blog.csdn.net/cfc1243570631/article/details/9078419)
# 参考代码
https://github.com/piratfm/HDB3_encode_decode

https://github.com/xuhangamy/HDB3codec_FPGA

# 编码过程

首先将输入的原始数据码流进行 4 个连 0 的检测，对第 4 个 0 替换成 V 码。

对 2 个 V 码之间 1 的个数进行检测，如果个数为偶数，则将 4 个连 0 个的第一个 0 替换为
B 码。下面是具体的 VerilogHDL 实现代码：

对原数据码流中的 1 与增加的 B 码一起进行正负极性交替变换；第一个 V 码与第一个数据 1 的极性一致，从第二个 V 码开始则正负极性交替变换。

# 仿真

Quartus II 调用 Modelsim 仿真
https://www.runoob.com/w3cnote/verilog-install.html

Quartus II 13简易仿真教程
https://blog.csdn.net/lgfx21/article/details/88599919

Quartus系列：Quartus II 功能仿真设置流程
https://www.cnblogs.com/xgcl-wei/p/9021586.html

本实验使用Modelsim Altera 10.1d进行仿真，需另外破解，破解方式及大部分问题见以上链接。
具体过程：
1.编写testbench，任意方式添加时钟，需要对输入初始化，否则仿真时输入高阻，输出不定；
2.仿真例程失败，例程不讲武德，用于PN序列发生的代码没有初始化，且有的代码无法通过编译（仿真比较严格，不能在使用变量之后再声明），需要自行修改；
3.最好修改PN时钟周期，否则波形看起来不方便（将jd_gen里的count_div[11]改为更小的数字，记得最后改回来）；
4.PLL在仿真中似乎不起作用，不过不影响逻辑验证。

# 报错解决
记得去下载 modelsim-altera 13.1
之后会报错 

【Modelsim常见问题】Can’t launch the ModelSim-Altera software
报错信息：

【分享转发】Modelsim常见问题合集,常见Modelsim仿真相关问题收录  
https://hifpga.com/%E9%97%AE%E9%A2%98/36787/%E5%88%86%E4%BA%AB%E8%BD%AC%E5%8F%91modelsim%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E5%90%88%E9%9B%86%E5%B8%B8%E8%A7%81modelsim%E4%BB%BF%E7%9C%9F%E7%9B%B8%E5%85%B3%E9%97%AE%E9%A2%98%E6%94%B6%E5%BD%95/

时钟不能太快 这会导致 示波器显示有问题 建议采用PN序列输出的时钟

建议采用状态机改写各个模块。

使用全零序列测试V码和B码是否正常添加到了序列里。
# rbf

由于之前使用不同的开发板测试代码，发现开发板本身可能有问题 所以要提前编译了一个测试用的rbf

注意一下情况是错误的。

为什么 2p1 PN序列 和2p3 时钟 输出的信号 都是双极性信号 这不合理

1.rbf 
指示灯会熄灭。 
PN,           //2P01
DPN,          //2P02
PNCLK,        //2P03

# 时间

在老师给的demo ex1_A2里，时钟为 62us 或者 64us 周期为 16.13khz。
15PN 对应 15个时钟周期 一次循环为940us 周期为1.064khz。

# 使用

将 src20201231文件夹里的 文件 Board02.v替换ex1_A2 demo工程中的对应文件；
将 hdb3_add_v.v hdb3_add_b.v hdb3_d2t.v jd_gen.v放到工程文件夹下 ，并在软件中添加到工程里；
在quartus中生成仿真文件（链接里应该有具体方法），用simulation/modelsim/Board02.vt代替生成的模板，并确保文件名等与设置一致。
