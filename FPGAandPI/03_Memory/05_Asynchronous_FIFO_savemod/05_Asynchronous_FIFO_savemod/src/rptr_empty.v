//****************************************************************************//
//# @Author: ����˼
//# @Date:   2019-04-07 03:20:23
//# @Last Modified by:   zlk
//# @WeChat Official Account: OpenFPGA
//# @Last Modified time: 2019-08-25 01:12:58
//# Description: 
//# @Modification History: 2018-05-28 20:26:28
//# Date          By         Version         Change Description: 
//# ========================================================================= #
//# 2018-05-28 20:26:28
//# ========================================================================= #
//# |                                                         | #
//# |                                OpenFPGA                   | #
//****************************************************************************//
`timescale 1ns / 1ps

module rptr_empty
#(
    parameter ADDRSIZE = 4
)
(
    output reg                rempty, 
    output     [ADDRSIZE-1:0] raddr,  //��������ʽ�Ķ�ָ��
    output reg [ADDRSIZE  :0] rptr,  //��������ʽ�Ķ�ָ��
    input      [ADDRSIZE  :0] rq2_wptr, //ͬ�����дָ��
    input                     rinc, rclk, rrst_n
);
  reg  [ADDRSIZE:0] rbin;
  wire [ADDRSIZE:0] rgraynext, rbinnext;
 // GRAYSTYLE2 pointer
 //�������ƵĶ�ָ�����������ƵĶ�ָ��ͬ��
  always @(posedge rclk or negedge rrst_n) 
      if (!rrst_n) begin
          rbin <= 0;
          rptr <= 0;
      end  
      else begin        
          rbin<=rbinnext; //ֱ����Ϊ�洢ʵ��ĵ�ַ
          rptr<=rgraynext;//����� sync_r2w.vģ�飬��ͬ���� wrclk ʱ����
      end
  // Memory read-address pointer (okay to use binary to address memory)
  assign raddr     = rbin[ADDRSIZE-1:0]; //ֱ����Ϊ�洢ʵ��ĵ�ַ���������ӵ�RAM�洢ʵ��Ķ���ַ�ˡ�
  assign rbinnext  = rbin + (rinc & ~rempty); //�������ж������ʱ���ָ���1
  assign rgraynext = (rbinnext>>1) ^ rbinnext; //�������ƵĶ�ָ��תΪ������
  // FIFO empty when the next rptr == synchronized wptr or on reset 
  assign rempty_val = (rgraynext == rq2_wptr); //����ָ�����ͬ�����дָ�룬��Ϊ�ա�
  always @(posedge rclk or negedge rrst_n) 
      if (!rrst_n)
          rempty <= 1'b1; 
      else     
          rempty <= rempty_val;
 
endmodule