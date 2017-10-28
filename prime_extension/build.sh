ghdl -a prime_extension.vhd testbench.vhd
ghdl -e testbench 
ghdl -r testbench --vcd=testbench.vcd
gtkwave testbench.vcd
