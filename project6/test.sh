ghdl -a --ieee=synopsys -fexplicit --work=altera_mf /opt/altera/12.1/quartus/eda/sim_lib/altera*.vhd
ghdl -a --ieee=synopsys -fexplicit --work=altera_mf stackertest.vhd stacker.vhd memram.vhd
ghdl -e --ieee=synopsys -fexplicit --work=altera_mf stackertest
ghdl -r stackertest --vcd=stackertest.vcd
gtkwave stackertest.vcd&

