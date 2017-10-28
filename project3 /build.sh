ghdl -a shifttest.vhd shift.vhd
ghdl -e shifttest
ghdl -r shifttest --vcd=shifttest.vcd 
gtkwave shifttest.vcd
