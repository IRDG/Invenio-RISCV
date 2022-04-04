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
add wave -noupdate -color Plum -label x11 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(11)
add wave -noupdate -color Plum -label x12 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(12)
add wave -noupdate -color Plum -label x13 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(13)
add wave -noupdate -color Plum -label x14 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(14)
add wave -noupdate -color Plum -label x15 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(15)
add wave -noupdate -color Plum -label x16 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(16)
add wave -noupdate -color Plum -label x17 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(17)
add wave -noupdate -color Plum -label x18 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(18)
add wave -noupdate -color Plum -label x19 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(19)
add wave -noupdate -color Plum -label x20 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/Rpg/Q(20)
add wave -noupdate -divider MemoryData
add wave -noupdate -color Gold -label Address -radix hexadecimal /testprotocol/CsrOpTest/SummonMemory/address
add wave -noupdate -color Gold -label DataIn(D) -radix hexadecimal /testprotocol/CsrOpTest/SummonMemory/data
add wave -noupdate -color Gold -label WriteEnable -radix hexadecimal /testprotocol/CsrOpTest/SummonMemory/wren
add wave -noupdate -color Gold -label DataOut(Q) -radix hexadecimal /testprotocol/CsrOpTest/SummonMemory/q
add wave -noupdate -divider CSR
add wave -noupdate -color Gray60 -label MEPC -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MEPC
add wave -noupdate -color Gray60 -label MIAd0 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MIAd0
add wave -noupdate -color Gray60 -label MIAd1 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MIad1
add wave -noupdate -color Gray60 -label MIAd2 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MIAd2
add wave -noupdate -color Gray60 -label MIAd3 -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MIAd3
add wave -noupdate -color Gray60 -label Misa -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/Misa
add wave -noupdate -color Gray60 -label Mstatus -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/Mstatus
add wave -noupdate -color Gray60 -label MTVal -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MTVal
add wave -noupdate -color Gray60 -label MIE -radix hexadecimal -radixshowbase 0 /testprotocol/CsrOpTest/CpuRiscV/ControlStatusRegisters/MIE
add wave -noupdate -divider Alu
add wave -noupdate -color {Blue Violet} -label AluCsr -radix hexadecimal /testprotocol/CsrOpTest/CpuRiscV/AlgorithmicLogicUnit/Alu_CSR
add wave -noupdate -color {Blue Violet} -label {Result And} -radix hexadecimal /testprotocol/CsrOpTest/CpuRiscV/AlgorithmicLogicUnit/ResultAND
add wave -noupdate -color {Blue Violet} -label {Result Or} -radix hexadecimal /testprotocol/CsrOpTest/CpuRiscV/AlgorithmicLogicUnit/ResultOR
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
WaveRestoreZoom {1151662 ps} {2148552 ps}

run 3180ns
