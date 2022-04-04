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
USE WORK.RegistersPackage.ALL;

--******************************************************--
-- Comentarios:
-- 
-- 
--******************************************************--

ENTITY Registers IS
	
	PORT	 (
				ControlSp        : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
				ControlRegisters : IN  STD_LOGIC_VECTOR(27 DOWNTO 0);
				IrRegisters      : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemoryOut        : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				CsrRegisters     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				AluRegisters     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				PcRegisters      : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Reset            : IN  STD_LOGIC;
				Clk              : IN  STD_LOGIC;
				RegistersCounter : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemoryIn         : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegistersMar     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegistersCsr     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegistersAlu     : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
			 );
	
END ENTITY Registers;

ARCHITECTURE RegistersArch OF Registers IS

CONSTANT Zeros  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

SIGNAL   D      : Matrix;
SIGNAL   Q      : Matrix;
SIGNAL   Enable : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

IManager: ENTITY WORK.InputManager 
PORT MAP	  (Ctrl        => ControlRegisters,
				IrInput     => IrRegisters,
				MemoryInput => MemoryOut,
				CsrInput    => CsrRegisters,
				AluInput    => AluRegisters,
				Enable      => Enable,
				D           => D
			  );

Xn: ENTITY WORK.RegistersBlock 
PORT MAP	  (D         => D,
				Enable    => Enable,
				ControlSp => ControlSp,
				Reset     => Reset,
				Clk       => Clk,
				Q         => Q
			  );

OManager: ENTITY WORK.OutputManager 
PORT MAP	  (PcInput       => PcRegisters,
				IrInput       => IrRegisters,
				Q             => Q,
				Ctrl          => ControlRegisters,
				CounterOutput => RegistersCounter,
				MemoryOutput  => MemoryIn,
				MarOutput     => RegistersMar,
				CsrOutput     => RegistersCsr,
				AluOutput     => RegistersAlu
			  );

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.Registers 
--PORT MAP	  (ControlSp        => SLV,
--				ControlRegisters => SLV,
--				IrRegisters      => SLV,
--				MemoryOut        => SLV,
--				CsrRegisters     => SLV,
--				AluRegisters     => SLV,
--				PcRegisters      => SLV,
--				Reset            => SLV,
--				Clk              => SLV,
--				RegistersCounter => SLV,
--				MemoryIn         => SLV,
--				RegistersMar     => SLV,
--				RegistersCsr     => SLV,
--				RegistersAlu     => SLV
--			  );
--******************************************************--

END RegistersArch;