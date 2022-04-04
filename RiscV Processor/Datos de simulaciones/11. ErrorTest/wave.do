onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -color {Cornflower Blue} -label PeripheralPort /testprotocol/PeripheralPort
add wave -noupdate -color {Cornflower Blue} -label Reset /testprotocol/Reset
add wave -noupdate -color {Cornflower Blue} -label Clk /testprotocol/Clk
add wave -noupdate -divider Output
add wave -noupdate -color Orange -label PeripheralStatus /testprotocol/PeripheralStatus
add wave -noupdate -color Orange -label SpySignal -childformat {{/testprotocol/SpySignal.Qs -radix unsigned}} -expand -subitemconfig {/testprotocol/SpySignal.Qs {-color Orange -height 15 -radix unsigned} /testprotocol/SpySignal.Error {-color Orange -height 15} /testprotocol/SpySignal.CpuSpy {-color Orange -height 15}} /testprotocol/SpySignal
add wave -noupdate -divider Extra
add wave -noupdate -color olive -label Sp -radix hexadecimal /testprotocol/ErrorTest/CpuRiscV/Rpg/Q(2)
add wave -noupdate -color olive -label Pc -radix hexadecimal /testprotocol/ErrorTest/CpuRiscV/ProgramCounter/Q
add wave -noupdate -color plum -label X10 -radix hexadecimal /testprotocol/ErrorTest/CpuRiscV/Rpg/Q(10)
add wave -noupdate -color plum -label X23 -radix hexadecimal /testprotocol/ErrorTest/CpuRiscV/Rpg/Q(23)
add wave -noupdate -divider MemoryData
add wave -noupdate -color Gold -label Address -radix hexadecimal /testprotocol/ErrorTest/SummonMemory/address
add wave -noupdate -color Gold -label DataIn(D) -radix hexadecimal /testprotocol/ErrorTest/SummonMemory/data
add wave -noupdate -color Gold -label WriteEnable -radix hexadecimal /testprotocol/ErrorTest/SummonMemory/wren
add wave -noupdate -color Gold -label DataOut(Q) -radix hexadecimal /testprotocol/ErrorTest/SummonMemory/q
add wave -noupdate -divider CSR
add wave -noupdate -color Gray60 -label MEPC -radix hexadecimal -radixshowbase 0 /testprotocol/ErrorTest/CpuRiscV/ControlStatusRegisters/MEPC
add wave -noupdate -color Gray60 -label MTVAL -radix hexadecimal -radixshowbase 0 /testprotocol/ErrorTest/CpuRiscV/ControlStatusRegisters/MTVal
add wave -noupdate -color Gray60 -label MIAd0 -radix hexadecimal -radixshowbase 0 /testprotocol/ErrorTest/CpuRiscV/ControlStatusRegisters/MIAd0
add wave -noupdate -color Gray60 -label MIAd1 -radix hexadecimal -radixshowbase 0 /testprotocol/ErrorTest/CpuRiscV/ControlStatusRegisters/MIad1
add wave -noupdate -color Gray60 -label MIAd2 -radix hexadecimal -radixshowbase 0 /testprotocol/ErrorTest/CpuRiscV/ControlStatusRegisters/MIAd2
add wave -noupdate -color Gray60 -label MIAd3 -radix hexadecimal -radixshowbase 0 /testprotocol/ErrorTest/CpuRiscV/ControlStatusRegisters/MIAd3
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
WaveRestoreZoom {1435523 ps} {2540867 ps}

run 2380ns
