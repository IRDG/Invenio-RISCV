onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -color {Cornflower Blue} -label PeripheralPort /testprotocol/PeripheralPort
add wave -noupdate -color {Cornflower Blue} -label Reset /testprotocol/Reset
add wave -noupdate -color {Cornflower Blue} -label Clk /testprotocol/Clk
add wave -noupdate -divider Output
add wave -noupdate -color Orange -label PeripheralStatus /testprotocol/PeripheralStatus
add wave -noupdate -color Orange -label SpySignal -childformat {{/testprotocol/SpySignal.Qs -radix unsigned}} -expand -subitemconfig {/testprotocol/SpySignal.Qs {-color Orange -height 15 -radix unsigned} /testprotocol/SpySignal.Error {-color Orange -height 15} /testprotocol/SpySignal.CpuSpy {-color Orange -height 15}} /testprotocol/SpySignal
add wave -noupdate -divider Rpg
add wave -noupdate -color Plum -label x11 -radix hexadecimal /testprotocol/MemRwRdTest/CpuRiscV/Rpg/Q(11)
add wave -noupdate -color Plum -label x12 -radix hexadecimal /testprotocol/MemRwRdTest/CpuRiscV/Rpg/Q(12)
add wave -noupdate -color Plum -label x13 -radix hexadecimal /testprotocol/MemRwRdTest/CpuRiscV/Rpg/Q(13)
add wave -noupdate -color Plum -label x14 -radix hexadecimal /testprotocol/MemRwRdTest/CpuRiscV/Rpg/Q(14)
add wave -noupdate -color Plum -label x15 -radix hexadecimal /testprotocol/MemRwRdTest/CpuRiscV/Rpg/Q(15)
add wave -noupdate -divider MemoryData
add wave -noupdate -color Gold -label Address -radix hexadecimal /testprotocol/MemRwRdTest/SummonMemory/address
add wave -noupdate -color Gold -label DataIn(D) -radix hexadecimal /testprotocol/MemRwRdTest/SummonMemory/data
add wave -noupdate -color Gold -label WriteEnable -radix hexadecimal /testprotocol/MemRwRdTest/SummonMemory/wren
add wave -noupdate -color Gold -label DataOut(Q) -radix hexadecimal /testprotocol/MemRwRdTest/SummonMemory/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1660000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 129
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 1
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1455798 ps} {2316932 ps}

run 4460ns
