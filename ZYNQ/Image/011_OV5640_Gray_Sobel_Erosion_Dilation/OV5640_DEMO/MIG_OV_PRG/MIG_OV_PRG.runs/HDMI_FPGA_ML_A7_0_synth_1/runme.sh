#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=E:/Xilinx/SDK/2017.4/bin;E:/Xilinx/Vivado/2017.4/ids_lite/ISE/bin/nt64;E:/Xilinx/Vivado/2017.4/ids_lite/ISE/lib/nt64:E:/Xilinx/Vivado/2017.4/bin
else
  PATH=E:/Xilinx/SDK/2017.4/bin;E:/Xilinx/Vivado/2017.4/ids_lite/ISE/bin/nt64;E:/Xilinx/Vivado/2017.4/ids_lite/ISE/lib/nt64:E:/Xilinx/Vivado/2017.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='F:/FILE/FPGA/ZYNQ/TEST/CH04_OV5640_DEMO/OV5640_TS_DATA/MIG_OV_PRG/MIG_OV_PRG.runs/HDMI_FPGA_ML_A7_0_synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log HDMI_FPGA_ML_A7_0.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source HDMI_FPGA_ML_A7_0.tcl