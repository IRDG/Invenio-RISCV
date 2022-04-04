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
add wave -noupdate -color olive -label Pc -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/ProgramCounter/Q
add wave -noupdate -color olive -label Sp -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(2)
add wave -noupdate -color Plum -label x11 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(11)
add wave -noupdate -color Plum -label x12 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(12)
add wave -noupdate -color Plum -label x13 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(13)
add wave -noupdate -color Plum -label x14 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(14)
add wave -noupdate -color Plum -label x15 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(15)
add wave -noupdate -color Plum -label x16 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(16)
add wave -noupdate -color Plum -label x17 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(17)
add wave -noupdate -color Plum -label x18 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(18)
add wave -noupdate -color Plum -label x20 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(20)
add wave -noupdate -color Plum -label x21 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(21)
add wave -noupdate -color Plum -label x22 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/Q(22)
add wave -noupdate -divider MemoryData
add wave -noupdate -color Gold -label Address -radix hexadecimal /testprotocol/Irq0ALuInmTest/SummonMemory/address
add wave -noupdate -color Gold -label DataIn(D) -radix hexadecimal /testprotocol/Irq0ALuInmTest/SummonMemory/data
add wave -noupdate -color Gold -label WriteEnable -radix hexadecimal /testprotocol/Irq0ALuInmTest/SummonMemory/wren
add wave -noupdate -color Gold -label DataOut(Q) -radix hexadecimal /testprotocol/Irq0ALuInmTest/SummonMemory/q
add wave -noupdate -divider Adder
add wave -noupdate -color Turquoise -label InA -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/AdderInputA
add wave -noupdate -color Turquoise -label InB -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/AdderInputB
add wave -noupdate -color Turquoise -label {Carry In} -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/CarryIn
add wave -noupdate -color Turquoise -label Result -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/AdderResult
add wave -noupdate -color Turquoise -label {Carry Out} -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/Carryout
add wave -noupdate -divider And
add wave -noupdate -color Turquoise -label InA -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/InputANDA
add wave -noupdate -color Turquoise -label InB -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/InputANDB
add wave -noupdate -color Turquoise -label Result -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/ResultAND
add wave -noupdate -divider Or
add wave -noupdate -color Turquoise -label InA -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/InputORA
add wave -noupdate -color Turquoise -label InB -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/InputORB
add wave -noupdate -color Turquoise -label Result -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/ResultOR
add wave -noupdate -divider Xor
add wave -noupdate -color Turquoise -label InA -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/InputXORA
add wave -noupdate -color Turquoise -label InB -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/InputXORB
add wave -noupdate -color Turquoise -label Result -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/AlgorithmicLogicUnit/ResultXOR
add wave -noupdate -divider Csr
add wave -noupdate -color Gray60 -label Mstatus -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/ControlStatusRegisters/Mstatus
add wave -noupdate -color Gray60 -label MIE -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/ControlStatusRegisters/MIE
add wave -noupdate -color Gray60 -label MIP -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/ControlStatusRegisters/MIP
add wave -noupdate -color Gray60 -label MIAd0 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq0ALuInmTest/CpuRiscV/ControlStatusRegisters/MIAd0
add wave -noupdate -divider {Rpg Out}
add wave -noupdate -color {Medium Orchid} -label DataOut1 -radix hexadecimal /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/OManager/DataOut1
add wave -noupdate -color {Medium Orchid} -label {Address 1} /testprotocol/Irq0ALuInmTest/CpuRiscV/Rpg/OManager/Out1Address
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2220000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 129
configure wave -valuecolwidth 99
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
WaveRestoreZoom {1952998 ps} {2874308 ps}

run 3860ns
