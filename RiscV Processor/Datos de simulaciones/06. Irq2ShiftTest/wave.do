onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -color {Cornflower Blue} -label PeripheralPort /testprotocol/PeripheralPort
add wave -noupdate -color {Cornflower Blue} -label Reset /testprotocol/Reset
add wave -noupdate -color {Cornflower Blue} -label Clk /testprotocol/Clk
add wave -noupdate -divider Output
add wave -noupdate -color Orange -label PeripheralStatus /testprotocol/PeripheralStatus
add wave -noupdate -color Orange -label SpySignal -childformat {{/testprotocol/SpySignal.Qs -radix unsigned}} -expand -subitemconfig {/testprotocol/SpySignal.Qs {-color Orange -height 15 -radix unsigned} /testprotocol/SpySignal.Error {-color Orange -height 15} /testprotocol/SpySignal.CpuSpy {-color Orange -height 15 -childformat {{/testprotocol/SpySignal.CpuSpy.CounterCount -radix hexadecimal}} -expand} /testprotocol/SpySignal.CpuSpy.CounterCount {-color Orange -height 15 -radix hexadecimal}} /testprotocol/SpySignal
add wave -noupdate -divider Extra
add wave -noupdate -color olive -label Pc -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/ProgramCounter/Q
add wave -noupdate -color olive -label Sp -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(2)
add wave -noupdate -color olive -label Ir -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/IntructionRegister/Q
add wave -noupdate -color Plum -label x11 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(11)
add wave -noupdate -color Plum -label x12 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(12)
add wave -noupdate -color Plum -label x13 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(13)
add wave -noupdate -color Plum -label x14 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(14)
add wave -noupdate -color Plum -label x15 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(15)
add wave -noupdate -color Plum -label x16 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(16)
add wave -noupdate -color Plum -label x20 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(20)
add wave -noupdate -color Plum -label x21 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(21)
add wave -noupdate -color Plum -label x22 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(22)
add wave -noupdate -color Plum -label x23 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/Rpg/Q(23)
add wave -noupdate -divider MemoryData
add wave -noupdate -color Gold -label Address -radix hexadecimal /testprotocol/Irq2ShiftTest/SummonMemory/address
add wave -noupdate -color Gold -label DataIn(D) -radix hexadecimal /testprotocol/Irq2ShiftTest/SummonMemory/data
add wave -noupdate -color Gold -label WriteEnable -radix hexadecimal /testprotocol/Irq2ShiftTest/SummonMemory/wren
add wave -noupdate -color Gold -label DataOut(Q) -radix hexadecimal /testprotocol/Irq2ShiftTest/SummonMemory/q
add wave -noupdate -divider Csr
add wave -noupdate -color Gray60 -label MEPC -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/ControlStatusRegisters/MEPC
add wave -noupdate -color Gray60 -label MIAd2 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/ControlStatusRegisters/MIAd2
add wave -noupdate -color Gray60 -label Mstatus -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/ControlStatusRegisters/Mstatus
add wave -noupdate -color Gray60 -label MIE -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/ControlStatusRegisters/MIE
add wave -noupdate -color Gray60 -label MIP -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/ControlStatusRegisters/MIP
add wave -noupdate -divider {Logical Shift Right}
add wave -noupdate -color Cyan -label Enable -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Lsr/Enable
add wave -noupdate -color Cyan -label Replace -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Lsr/Replace
add wave -noupdate -color Cyan -label DataIn -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Lsr/DataIn
add wave -noupdate -color Cyan -label Result -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Lsr/LogicalShiftRightRegister
add wave -noupdate -divider {Logical Shift Left}
add wave -noupdate -color Cyan -label Enable -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Ls/Enable
add wave -noupdate -color Cyan -label Replace -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Ls/Replace
add wave -noupdate -color Cyan -label DataIn -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Ls/DataIn
add wave -noupdate -color Cyan -label Result -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Ls/LeftShiftRegister
add wave -noupdate -divider {Arithmetic Shift Right}
add wave -noupdate -color Cyan -label Enable -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Asr/Enable
add wave -noupdate -color Cyan -label Replace -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Asr/Replace
add wave -noupdate -color Cyan -label DataIn -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Asr/DataIn
add wave -noupdate -color Cyan -label Result -radix hexadecimal -radixshowbase 0 /testprotocol/Irq2ShiftTest/CpuRiscV/AlgorithmicLogicUnit/Asr/ArithmeticShiftRightRegister
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2220000 ps} 0}
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
WaveRestoreZoom {1962384 ps} {2782968 ps}

run 4220ns
