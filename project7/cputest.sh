ghdl -a --ieee=synopsys --work=altera_mf cpubench.vhd CPU.vhd ALU.vhd ProgramROM.vhd DataRAM.vhd
ghdl -e --ieee=synopsys -fexplicit --work=altera_mf cpubench
ghdl -r cpubench --vcd=cpubench.vcd
gtkwave cpubench.vcd &
