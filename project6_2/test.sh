ghdl -a --ieee=synopsys -fexplicit --work=altera_mf calculatortest.vhd calculator.vhd memram.vhd segment_display.vhd
ghdl -e --ieee=synopsys -fexplicit --work=altera_mf calculatortest
ghdl -r calculatortest --vcd=calculatortest.vcd
gtkwave calculatortest.vcd&

