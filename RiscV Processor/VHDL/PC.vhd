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
USE IEEE.NUMERIC_STD.ALL;

--******************************************************--
-- Comentarios:
-- 
-- 
--******************************************************--

ENTITY Pc IS
	
	PORT	 (
				ControlPc   : IN  STD_LOGIC_VECTOR( 2 DOWNTO 0);
				AluPc       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				CsrPc       : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Reset       : IN  STD_LOGIC;
				Clk         : IN  STD_LOGIC;
				PcMar       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				PcAlu       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				PcRegisters : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			 );
	
END ENTITY Pc;

ARCHITECTURE PcArch OF Pc IS

CONSTANT Zeros  : UNSIGNED(31 DOWNTO 0) := (others => '0');

SIGNAL   D      : UNSIGNED(31 DOWNTO 0);
SIGNAL   Q      : UNSIGNED(31 DOWNTO 0);
SIGNAL   Alu    : UNSIGNED(31 DOWNTO 0);
SIGNAL   Csr    : UNSIGNED(31 DOWNTO 0);

SIGNAL   Output : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

Alu <= UNSIGNED(AluPc);
Csr <= UNSIGNED(CsrPc);

WITH ControlPc SELECT
D <= Q     WHEN "000",
	  Q + 1 WHEN "001",
	  Alu   WHEN "010",
	  Csr   WHEN "100",
	  Q     WHEN OTHERS;

PROCESS(Clk, Reset, D)

BEGIN
	
	IF(Reset = '1')THEN
		
		Q <= Zeros;
		
	ELSIF(Rising_Edge(Clk))THEN
		
		Q <= D;
		
	END IF;
	
END PROCESS;

Output <= STD_LOGIC_VECTOR(Q);

PcMar       <= Output;
PcRegisters <= Output;
PcAlu       <= Output;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.Pc 
--PORT MAP	  (ControlPc   => SLV,
--				AluPc       => SLV,
--				CsrPc       => SLV,
--				Reset       => SLV,
--				Clk         => SLV,
--				PcMar       => SLV,
--				PcAlu       => SLV,
--				PcRegisters => SLV
--			  );
--******************************************************--

END PcArch;