ghdl -a --ieee=synopsys -fexplicit --work=altera_mf /opt/altera/12.1/quartus/eda/sim_lib/altera*.vhd
ghdl -a --ieee=synopsys -fexplicit --work=altera_mf calculatortest.vhd
calculator.vhd memram.vhd
ghdl -e --ieee=synopsys -fexplicit --work=altera_mf calculatortest
ghdl -r calculatortest --vcd=calculatortest.vcd
gtkwave calculatortest.vcd&

