--******************************************************--
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disegno Digital                       --
--          Seccion de Tecnicas Digitales               --
-- 													              --
-- Titulo :                                             --
-- Fecha  :  	D:XX M:XX Y:20XX                         --
--******************************************************--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE WORK.OutputControlPackage.ALL;

--******************************************************--
-- Comentarios:
-- 
-- 
--******************************************************--

ENTITY RiscV IS
	
	PORT	 (
				MemoryOut     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				IRQ           : IN  STD_LOGIC_VECTOR( 3 DOWNTO 0);
				Reset         : IN  STD_LOGIC;
				Clk           : IN  STD_LOGIC;
				MemoryIn      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemoryAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemoryRdWr    : OUT STD_LOGIC_VECTOR( 1 DOWNTO 0);
				Qs            : OUT STD_LOGIC_VECTOR( 6 DOWNTO 0);
				Error         : OUT STD_LOGIC;
				ACK           : OUT STD_LOGIC_VECTOR( 3 DOWNTO 0);
				RiscVSpy      : OUT RiscVSpy
			 );
	
END ENTITY RiscV;

ARCHITECTURE RiscVArch OF RiscV IS

SIGNAL IrControl         : STD_LOGIC_VECTOR(12 DOWNTO 0);
SIGNAL CsrControl        : STD_LOGIC_VECTOR( 5 DOWNTO 0);
SIGNAL CounterControl    : STD_LOGIC;
SIGNAL AluControl        : STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL ControlRegisters  : STD_LOGIC_VECTOR(27 DOWNTO 0);
SIGNAL ControlSp         : STD_LOGIC_VECTOR( 1 DOWNTO 0);
SIGNAL ControlPc         : STD_LOGIC_VECTOR( 2 DOWNTO 0);
SIGNAL ControlAlu        : STD_LOGIC_VECTOR(36 DOWNTO 0);
SIGNAL ControlMar        : STD_LOGIC_VECTOR( 2 DOWNTO 0);
SIGNAL ControlCounter    : STD_LOGIC_VECTOR( 2 DOWNTO 0);
SIGNAL ControlCsr        : STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL ControlIr         : STD_LOGIC;

SIGNAL IrRegisters       : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL CsrRegisters      : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL AluRegisters      : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PcRegisters       : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL RegistersCounter  : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL RegistersMar      : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL RegistersCsr      : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL RegistersAlu      : STD_LOGIC_VECTOR(63 DOWNTO 0);

SIGNAL IrCsr             : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL AluCsr            : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL IrCsrException    : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL CsrPc             : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL IrCounter         : STD_LOGIC_VECTOR( 5 DOWNTO 0);
SIGNAL IrAlu             : STD_LOGIC_VECTOR(29 DOWNTO 0);

SIGNAL AluPc             : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PcMar             : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PcAlu             : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL AluMar            : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

IrCsr <= IrCsrException(31 DOWNTO 20);

Control: ENTITY WORK.ControlUnit
PORT MAP	  (IrControl         => IrControl,
				CsrControl        => CsrControl,
				IRQ               => IRQ,
				CounterControl    => CounterControl,
				AluControl        => AluControl,
				Reset             => Reset,
				Clk               => Clk,
				ControlRegisters  => ControlRegisters,
				ControlSp         => ControlSp,
				ControlPc         => ControlPc,
				ControlAlu        => ControlAlu,
				ControlMar        => ControlMar,
				ControlMemoryRdWr => MemoryRdWr,
				ControlQs         => Qs,
				ControlError      => Error,
				Ack               => Ack,
				ControlCounter    => ControlCounter,
				ControlCsr        => ControlCsr,
				ControlIr         => ControlIr
			  );

Rpg: ENTITY WORK.Registers 
PORT MAP	  (ControlSp        => ControlSp,
				ControlRegisters => ControlRegisters,
				IrRegisters      => IrRegisters,
				MemoryOut        => MemoryOut,
				CsrRegisters     => CsrRegisters,
				AluRegisters     => AluRegisters,
				PcRegisters      => PcRegisters,
				Reset            => Reset,
				Clk              => Clk,
				RegistersCounter => RegistersCounter,
				MemoryIn         => MemoryIn,
				RegistersMar     => RegistersMar,
				RegistersCsr     => RegistersCsr,
				RegistersAlu     => RegistersAlu
			  );

ControlStatusRegisters: ENTITY WORK.CSR 
PORT MAP	  (IrCsr          => IrCsr,
				ControlCsr     => ControlCsr,
				AluCsr         => AluCsr,
				RegistersCsr   => RegistersCsr,
				IrCsrException => IrCsrException,
				Reset          => Reset,
				Clk            => Clk,
				CsrPc          => CsrPc,
				CsrRegisters   => CsrRegisters,
				CsrControl     => CsrControl
			  );

IntructionRegister : ENTITY WORK.Ir
PORT MAP	  (MemoryOut    => MemoryOut,
				Control_IR   => ControlIr,
				Reset        => Reset,
				Reloj        => Clk,
				Ir_Registers => IrRegisters,
				Ir_Control   => IrControl,
				Ir_Alu       => IrAlu,
				Ir_CSR       => IrCsrException,
				Ir_Counter   => IrCounter
			  );

ProgramCounter: ENTITY WORK.Pc 
PORT MAP	  (ControlPc   => ControlPc,
				AluPc       => AluPc,
				CsrPc       => CsrPc,
				Reset       => Reset,
				Clk         => Clk,
				PcMar       => PcMar,
				PcAlu       => PcAlu,
				PcRegisters => PcRegisters
			  );

C: ENTITY WORK.Counter 
PORT MAP	  (Registers_Counter => RegistersCounter,
				Control_Counter   => ControlCounter,
				Ir_Counter        => IrCounter,
				Reset             => Reset,
				Reloj             => Clk,
				Conteo            => RiscVSpy.CounterCount,
				Counter_Control   => CounterControl
			  );

MemoryAddressRegister: ENTITY WORK.Mar 
PORT MAP	  (Pc_Mar        => PcMar,
				Alu_Mar       => AluMar,
				Registers_Mar => RegistersMar,
				Control_Mar   => ControlMar,
				Reset         => Reset,
				Reloj         => Clk,
				MemoryAddress => MemoryAddress
			  );

AlgorithmicLogicUnit: ENTITY WORK.Alu 
PORT MAP	  (Registers_Alu  => RegistersAlu,
				Ir_Alu         => IrAlu,
				Control_Alu    => ControlAlu,
				Pc_Alu         => PcAlu,
				Reset          => Reset,
				Reloj          => Clk,
				Alu_Registers  => AluRegisters,
				Alu_Pc         => AluPc,
				Alu_Csr        => AluCsr,
				Alu_Mar        => AluMar,
				Alu_Control    => AluControl,
				SpyAddrMode0   => OPEN,
				SpyAddrMode2   => OPEN,
				SpyAddrMode4   => OPEN,
				SpyAddrMode6   => OPEN,
				SpyAddrMode8   => OPEN,
				SpyAddrMode9   => OPEN,
				SpyAddrMode11  => OPEN,
				SpyAddrMode29  => OPEN,
				SpyAddrMode32  => OPEN,
				SpyAddrMode34  => OPEN,
				SpyAdderResult => OPEN,
				SpyMulResult   => OPEN,
				SpyResultAnd   => OPEN,
				SpyResultOr    => OPEN,
				SpyResultXor   => OPEN,
				SpyLSRRegister => OPEN,
				SpyLSRegister  => OPEN,
				SpyASRRegister => OPEN
			  );

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.RiscV 
--PORT MAP	  (MemoryOut     => SLV,
--				IRQ           => SLV,
--				Reset         => SLV,
--				Clk           => SLV,
--				MemoryIn      => SLV,
--				MemoryAddress => SLV,
--				MemoryRdWr    => SLV,
--				Qs            => SLV,
--				Error         => SLV,
--				ACK           => SLV,
--				RiscVSpy      => SLV
--			  );
--******************************************************--

END RiscVArch;