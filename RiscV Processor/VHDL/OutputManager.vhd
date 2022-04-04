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

ENTITY OutputManager IS
	
	PORT	 (
				PcInput       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				IrInput       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Q             : IN  Matrix;
				Ctrl          : IN  STD_LOGIC_VECTOR(27 DOWNTO 0);
				CounterOutput : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemoryOutput  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				MarOutput     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				CsrOutput     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				AluOutput     : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
			 );
	
END ENTITY OutputManager;

ARCHITECTURE OutputManagerArch OF OutputManager IS

CONSTANT Zeros        : STD_LOGIC_VECTOR(31 DOWNTO  0) := (OTHERS => '0');

SIGNAL   Out1Selector : STD_LOGIC_VECTOR( 4 DOWNTO  0);
SIGNAL   Out2Selector : STD_LOGIC_VECTOR( 1 DOWNTO  0);
SIGNAL   Out1Address  : INTEGER   RANGE   0   TO   31 ;
SIGNAL   Out2Address  : INTEGER   RANGE   0   TO   31 ;
SIGNAL   DataOut1     : STD_LOGIC_VECTOR(31 DOWNTO  0);
SIGNAL   DataOut2     : STD_LOGIC_VECTOR(31 DOWNTO  0);
SIGNAL   DataSext07   : STD_LOGIC_VECTOR(31 DOWNTO  0);
SIGNAL   DataSext15   : STD_LOGIC_VECTOR(31 DOWNTO  0);

SIGNAL   CounterSel   : STD_LOGIC;
SIGNAL   MemorySel    : STD_LOGIC_VECTOR( 3 DOWNTO  0);
SIGNAL   MarSel       : STD_LOGIC;
SIGNAL   CsrSel       : STD_LOGIC;
SIGNAL   AluSel       : STD_LOGIC_VECTOR( 1 DOWNTO  0);

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

Out1Selector(0) <= Ctrl( 2) OR Ctrl( 4) OR Ctrl(17) OR Ctrl(18) OR Ctrl(20) OR Ctrl(14) OR Ctrl(27);
Out1Selector(1) <= Ctrl( 3) OR Ctrl(26);
Out1Selector(2) <= Ctrl(10) OR Ctrl(11) OR Ctrl(12) OR Ctrl(13) OR Ctrl(21);
Out1Selector(3) <= Ctrl(22) OR Ctrl(24);
Out1Selector(4) <= Ctrl(23);


Out2Selector(0) <= Ctrl( 3) OR Ctrl(21);
Out2Selector(1) <= Ctrl( 4) OR Ctrl(18) OR Ctrl(27);

WITH Out1Selector SELECT
Out1Address <= Slv2I(IrInput(19 DOWNTO 15)) WHEN "00001",
					Slv2I(IrInput(24 DOWNTO 20)) WHEN "00010",
					Slv2I(IrInput(11 DOWNTO  7)) WHEN "00100",
					2                            WHEN "01000",
					Slv2I(IrInput( 6 DOWNTO  2)) WHEN "10000",
					0                            WHEN OTHERS;

WITH Out2Selector SELECT
Out2Address <= Slv2I(IrInput(19 DOWNTO 15)) WHEN "01",
					Slv2I(IrInput(24 DOWNTO 20)) WHEN "10",
					0                            WHEN OTHERS;

DataOut1 <= Q(Out1Address);
DataOut2 <= Q(Out2Address);

DataSext07   <= Sext(Q(Out1Address)( 7),24) & (Q(Out1Address)( 7 DOWNTO 0));
DataSext15   <= Sext(Q(Out1Address)(15),16) & (Q(Out1Address)(15 DOWNTO 0));

CounterSel   <= Ctrl(26);
MemorySel(0) <= Ctrl(12) OR Ctrl(23);  --Basic
MemorySel(1) <= Ctrl(10); --Sext7
MemorySel(2) <= Ctrl(11); --Sext15
MemorySel(3) <= Ctrl(25); --Pc
MarSel       <= Ctrl(24);
CsrSel       <= Ctrl(20);
AluSel(0)    <= Ctrl( 2) OR Ctrl(13) OR Ctrl(14) OR Ctrl(17) OR Ctrl(22);  -- Single
AluSel(1)    <= Ctrl( 3) OR Ctrl( 4) OR Ctrl(18) OR Ctrl(21) OR Ctrl(27); --Double

WITH CounterSel SELECT
CounterOutput <= DataOut1 WHEN '1',
					  Zeros    WHEN OTHERS;

WITH MemorySel SELECT
MemoryOutput <= DataOut1   WHEN "0001",
					 DataSext07 WHEN "0010",
					 DataSext15 WHEN "0100",
					 PcInput    WHEN "1000",
					 Zeros      WHEN OTHERS;

WITH MarSel SELECT
MarOutput <= DataOut1 WHEN '1',
				 Zeros    WHEN OTHERS;

WITH CsrSel SELECT
CsrOutput <= DataOut1 WHEN '1',
				 Zeros    WHEN OTHERS;

WITH AluSel SELECT
AluOutput <= (Zeros    & DataOut1) WHEN "01",
				 (DataOut2 & DataOut1) WHEN "10",
				 (Zeros    & Zeros   ) WHEN OTHERS;




--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.OutputManager 
--PORT MAP	  (PcInput       => SLV,
--				IrInput       => SLV,
--				Q             => SLV,
--				Ctrl          => SLV,
--				CounterOutput => SLV,
--				MemoryOutput  => SLV,
--				MarOutput     => SLV,
--				CsrOutput     => SLV,
--				AluOutput     => SLV
--			  );
--******************************************************--

END OutputManagerArch;