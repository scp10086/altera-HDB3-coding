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
