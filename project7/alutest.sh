ghdl -a alutestbench.vhd ALU.vhd 
ghdl -e alutestbench
ghdl -r alutestbench --vcd=alutestbench.vcd 
gtkwave alutestbench.vcd
