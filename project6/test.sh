ghdl -a --ieee=synopsys -fexplicit --work=altera_mf /opt/altera/12.1/quartus/eda/sim_lib/altera*.vhd
<<<<<<< HEAD
ghdl -a --ieee=synopsys -fexplicit --work=altera_mf calculatortest.vhd
calculator.vhd memram.vhd
ghdl -e --ieee=synopsys -fexplicit --work=altera_mf calculatortest
ghdl -r calculatortest --vcd=calculatortest.vcd
gtkwave calculatortest.vcd&
=======
ghdl -a --ieee=synopsys -fexplicit --work=altera_mf stackertest.vhd stacker.vhd memram.vhd
ghdl -e --ieee=synopsys -fexplicit --work=altera_mf stackertest
ghdl -r stackertest --vcd=stackertest.vcd
gtkwave stackertest.vcd&
>>>>>>> 9ad15e95ea6eeabb991f4909beb8bc41ea2da683

