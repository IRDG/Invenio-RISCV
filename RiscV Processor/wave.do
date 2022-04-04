onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -color {Cornflower Blue} -label PeripheralPort /testprotocol/PeripheralPort
add wave -noupdate -color {Cornflower Blue} -label Reset /testprotocol/Reset
add wave -noupdate -color {Cornflower Blue} -label Clk /testprotocol/Clk
add wave -noupdate -divider Output
add wave -noupdate -color Orange -label PeripheralStatus /testprotocol/PeripheralStatus
add wave -noupdate -color Orange -label SpySignal -childformat {{/testprotocol/SpySignal.Qs -radix unsigned}} -expand -subitemconfig {/testprotocol/SpySignal.Qs {-color Orange -height 15 -radix unsigned} /testprotocol/SpySignal.Error {-color Orange -height 15} /testprotocol/SpySignal.CpuSpy {-color Orange -height 15 -childformat {{/testprotocol/SpySignal.CpuSpy.CounterCount -radix hexadecimal}} -expand} /testprotocol/SpySignal.CpuSpy.CounterCount {-color Orange -height 15 -radix hexadecimal}} /testprotocol/SpySignal
add wave -noupdate -divider RPG
add wave -noupdate -color olive -label Pc -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ProgramCounter/Q
add wave -noupdate -color olive -label Sp -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(2)
add wave -noupdate -color Plum -label X10 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(10)
add wave -noupdate -color Plum -label X11 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(11)
add wave -noupdate -color Plum -label X12 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(12)
add wave -noupdate -color Plum -label X13 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(13)
add wave -noupdate -color Plum -label X14 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(14)
add wave -noupdate -color Plum -label X15 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(15)
add wave -noupdate -color Plum -label X16 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(16)
add wave -noupdate -color Plum -label X20 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(20)
add wave -noupdate -color Plum -label X21 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(21)
add wave -noupdate -color Plum -label X22 -radix hexadecimal -radixshowbase 0 /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(22)
add wave -noupdate -color Plum -label X23 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/Rpg/Q(23)
add wave -noupdate -divider MemoryData
add wave -noupdate -color Gold -label Address -radix hexadecimal /testprotocol/Irq1ShiftInmTest/SummonMemory/address
add wave -noupdate -color Gold -label DataIn(D) -radix hexadecimal /testprotocol/Irq1ShiftInmTest/SummonMemory/data
add wave -noupdate -color Gold -label WriteEnable -radix hexadecimal /testprotocol/Irq1ShiftInmTest/SummonMemory/wren
add wave -noupdate -color Gold -label DataOut(Q) -radix hexadecimal /testprotocol/Irq1ShiftInmTest/SummonMemory/q
add wave -noupdate -divider CSR
add wave -noupdate -color Gray60 -label MEPC -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MEPC
add wave -noupdate -color Gray60 -label MIAd0 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MIAd0
add wave -noupdate -color Gray60 -label MIAd1 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MIad1
add wave -noupdate -color Gray60 -label MIAd2 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MIAd2
add wave -noupdate -color Gray60 -label MIAd3 -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MIAd3
add wave -noupdate -color Gray60 -label MIE -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MIE
add wave -noupdate -color Gray60 -label Mstatus -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/Mstatus
add wave -noupdate -color Gray60 -label Mip -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/ControlStatusRegisters/MIP
add wave -noupdate -divider CraAdder
add wave -noupdate -color {Blue Violet} -label Result -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/Result
add wave -noupdate -color {Blue Violet} -label CarryOut /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/Carryout
add wave -noupdate -color {Blue Violet} -label A -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/A
add wave -noupdate -color {Blue Violet} -label B -radix hexadecimal -childformat {{/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(31) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(30) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(29) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(28) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(27) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(26) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(25) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(24) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(23) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(22) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(21) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(20) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(19) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(18) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(17) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(16) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(15) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(14) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(13) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(12) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(11) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(10) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(9) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(8) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(7) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(6) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(5) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(4) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(3) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(2) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(1) -radix hexadecimal} {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(0) -radix hexadecimal}} -subitemconfig {/testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(31) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(30) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(29) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(28) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(27) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(26) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(25) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(24) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(23) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(22) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(21) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(20) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(19) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(18) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(17) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(16) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(15) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(14) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(13) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(12) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(11) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(10) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(9) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(8) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(7) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(6) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(5) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(4) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(3) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(2) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(1) {-color {Blue Violet} -height 15 -radix hexadecimal} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B(0) {-color {Blue Violet} -height 15 -radix hexadecimal}} /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/B
add wave -noupdate -color {Blue Violet} -label CarryIn /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/CraA32/CarryIn
add wave -noupdate -divider Shifts
add wave -noupdate -color Blue -label ShiftRight -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/Lsr/LogicalShiftRightRegister
add wave -noupdate -color Blue -label ShiftLeft -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/Ls/LeftShiftRegister
add wave -noupdate -color Blue -label {Ar ShiftRight} -radix hexadecimal /testprotocol/Irq1ShiftInmTest/CpuRiscV/AlgorithmicLogicUnit/Asr/ArithmeticShiftRightRegister
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3761372 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 125
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
WaveRestoreZoom {3371059 ps} {4405819 ps}

run 4060ns
