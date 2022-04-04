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

ENTITY InputManager IS
	
	PORT	 (
				Ctrl        : IN  STD_LOGIC_VECTOR(27 DOWNTO 0);
				IrInput     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				MemoryInput : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				CsrInput    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				AluInput    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Enable      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				D           : OUT Matrix
			 );
	
END ENTITY InputManager;

ARCHITECTURE InputManagerArch OF InputManager IS

CONSTANT Zeros       : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";
CONSTANT One         : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000001";

SIGNAL   DataIn      : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   IrOrgn      : STD_LOGIC;
SIGNAL   MemoryOrgn  : STD_LOGIC_VECTOR( 4 DOWNTO 0);
SIGNAL   CsrOrgn     : STD_LOGIC;
SIGNAL   AluOrgn     : STD_LOGIC;
SIGNAL   OneOrg      : STD_LOGIC;
SIGNAL   ZeroOrg     : STD_LOGIC;
SIGNAL   Origen      : STD_LOGIC_VECTOR( 9 DOWNTO 0);

SIGNAL   SigMemory07 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   SigMemory15 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   UsgMemory07 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   UsgMemory15 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   SpecialIr   : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL   Address     : STD_LOGIC_VECTOR( 6 DOWNTO 0);
SIGNAL   NoInput     : STD_LOGIC;
SIGNAL   EnaInput    : STD_LOGIC;

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

IrOrgn        <= Ctrl( 1);
MemoryOrgn(0) <= Ctrl( 5);
MemoryOrgn(1) <= Ctrl( 6);
MemoryOrgn(2) <= Ctrl( 7);
MemoryOrgn(3) <= Ctrl( 8);
MemoryOrgn(4) <= Ctrl( 9);
CsrOrgn       <= Ctrl(19);
AluOrgn       <= Ctrl( 0) OR Ctrl(14) OR Ctrl(17) OR Ctrl(18) OR Ctrl(27);
OneOrg        <= Ctrl(15);
ZeroOrg       <= Ctrl(16);

Origen     <= ZeroOrg & CsrOrgn & OneOrg & MemoryOrgn & IrOrgn & AluOrgn;

SigMemory07 <= Sext(MemoryInput( 7),24) & (MemoryInput( 7 DOWNTO 0));
SigMemory15 <= Sext(MemoryInput(15),16) & (MemoryInput(15 DOWNTO 0));
UsgMemory07 <= Sext(            '0',24) & (MemoryInput( 7 DOWNTO 0));
UsgMemory15 <= Sext(            '0',16) & (MemoryInput(15 DOWNTO 0));

SpecialIrGenerator1:FOR I IN 0 TO 11 GENERATE
	
	SpecialIr(I) <= '0';
	
END GENERATE SpecialIrGenerator1; 

SpecialIrGenerator2: FOR J IN 12 TO 31 GENERATE
	
	SpecialIr(J) <= IrInput(J);
	
END GENERATE SpecialIrGenerator2;

WITH Origen SELECT
DataIn <= AluInput    WHEN "0000000001",
			 SpecialIr   WHEN "0000000010",
			 SigMemory07 WHEN "0000000100",
			 SigMemory15 WHEN "0000001000",
			 MemoryInput WHEN "0000010000",
			 UsgMemory07 WHEN "0000100000",
			 UsgMemory15 WHEN "0001000000",
			 One         WHEN "0010000000",
			 CsrInput    WHEN "0100000000",
			 Zeros       WHEN "1000000000",
			 Zeros       WHEN OTHERS;

NoInput  <= Ctrl( 2) OR Ctrl( 3) OR Ctrl( 4) OR Ctrl(10) OR Ctrl(11) OR
			   Ctrl(12) OR Ctrl(13) OR Ctrl(20) OR Ctrl(21) OR Ctrl(22) OR
			   Ctrl(23) OR Ctrl(24) OR Ctrl(25) OR Ctrl(26);

EnaInput <= Ctrl( 1) OR Ctrl( 5) OR Ctrl( 6) OR Ctrl( 7) OR Ctrl( 8) OR
				Ctrl( 9) OR Ctrl( 0) OR Ctrl(19) OR Ctrl(14) OR Ctrl(17) OR
				Ctrl(18) OR Ctrl(15) OR Ctrl(16) OR Ctrl(27);

Address  <= EnaInput &  NoInput & IrInput(11 DOWNTO 7);

WITH Address SELECT
Enable <= x"00000001" WHEN "1000000", -- 00
			 x"00000002" WHEN "1000001", -- 01
			 x"00000004" WHEN "1000010", -- 02
			 x"00000008" WHEN "1000011", -- 03
			 x"00000010" WHEN "1000100", -- 04
			 x"00000020" WHEN "1000101", -- 05
			 x"00000040" WHEN "1000110", -- 06
			 x"00000080" WHEN "1000111", -- 07
			 x"00000100" WHEN "1001000", -- 08
			 x"00000200" WHEN "1001001", -- 09
			 x"00000400" WHEN "1001010", -- 10
			 x"00000800" WHEN "1001011", -- 11
			 x"00001000" WHEN "1001100", -- 12
			 x"00002000" WHEN "1001101", -- 13
			 x"00004000" WHEN "1001110", -- 14
			 x"00008000" WHEN "1001111", -- 15
			 x"00010000" WHEN "1010000", -- 16
			 x"00020000" WHEN "1010001", -- 17
			 x"00040000" WHEN "1010010", -- 18
			 x"00080000" WHEN "1010011", -- 19
			 x"00100000" WHEN "1010100", -- 20
			 x"00200000" WHEN "1010101", -- 21
			 x"00400000" WHEN "1010110", -- 22
			 x"00800000" WHEN "1010111", -- 23
			 x"01000000" WHEN "1011000", -- 24
			 x"02000000" WHEN "1011001", -- 25
			 x"04000000" WHEN "1011010", -- 26
			 x"08000000" WHEN "1011011", -- 27
			 x"10000000" WHEN "1011100", -- 28
			 x"20000000" WHEN "1011101", -- 29
			 x"40000000" WHEN "1011110", -- 30
			 x"80000000" WHEN "1011111", -- 31
			 x"00000000" WHEN "0100000", -- No Input
			 x"00000000" WHEN OTHERS;

DataGenerator: FOR I IN 0 TO 31 GENERATE
	
	D(I) <= DataIn;
	
END GENERATE DataGenerator;


--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.InputManager 
--PORT MAP	  (Ctrl        => SLV,
--				IrInput     => SLV,
--				MemoryInput => SLV,
--				CsrInput    => SLV,
--				AluInput    => SLV,
--				PcInput     => SLV,
--				Enable      => SLV,
--				D           => SLV
--			  );
--******************************************************--

END InputManagerArch;