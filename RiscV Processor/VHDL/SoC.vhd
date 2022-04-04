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

ENTITY SoC IS
	
	PORT	 (
				PeripheralPort   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				Reset            : IN  STD_LOGIC;
				Clk              : IN  STD_LOGIC;
				PeripheralStatus : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				SpySignal        : OUT Spy
			 );
	
END ENTITY SoC;

ARCHITECTURE SoCArch OF SoC IS

SIGNAL MemoryIn      : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MemoryOut     : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MemoryAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Address       : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL MemoryRdWr    : STD_LOGIC_VECTOR( 1 DOWNTO 0);
SIGNAL Irq           : STD_LOGIC_VECTOR( 3 DOWNTO 0);
SIGNAL Ack           : STD_LOGIC_VECTOR( 3 DOWNTO 0);

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

Address <= MemoryAddress(11 DOWNTO 0);

CpuRiscV: ENTITY WORK.RiscV 
PORT MAP	  (MemoryOut     => MemoryOut,
				IRQ           => Irq,
				Reset         => Reset,
				Clk           => Clk,
				MemoryIn      => MemoryIn,
				MemoryAddress => MemoryAddress,
				MemoryRdWr    => MemoryRdWr,
				Qs            => SpySignal.Qs,
				Error         => SpySignal.Error,
				ACK           => Ack,
				RiscVSpy      => SpySignal.CpuSpy
			  );

SummonMemory: ENTITY WORK.MyMemory
PORT MAP	  (Address => Address,
				Clock   => Clk,
				Data    => MemoryIn,
				--RdEn    => MemoryRdWr(0),
				WrEn    => MemoryRdWr(1),
				Q       => MemoryOut
			  );

PeriphericControl: ENTITY WORK.PeriphericCircuit 
PORT MAP	  (PeripheralPort   => PeripheralPort,
				Ack              => Ack,
				Reset            => Reset,
				Clk              => Clk,
				PeripheralStatus => PeripheralStatus,
				Irq              => Irq
			  );

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.SoC 
--PORT MAP	  (PeripheralPort   => SLV,
--				Reset            => SLV,
--				Clk              => SLV,
--				PeripheralStatus => SLV,
--				SpySignal        => SLV
--			  );
--******************************************************--

END SoCArch;