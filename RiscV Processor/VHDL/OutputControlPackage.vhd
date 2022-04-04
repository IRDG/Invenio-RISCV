--******************************************************--
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disegno Digital                       --
--          Seccion de Tecnicas Digitales               --
-- 													              --
-- Titulo :                                             --
-- Fecha  :  	D:XX M:XX Y:20XX                         --
--******************************************************--
-- 													              --
----------- Package: OutputControlPackage.vhd ------------
-- 													              --
--******************************************************--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE OutputControlPackage IS

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 01 : PcRegRwTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 02 : MemRwRdTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 03 : BrachTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 04 : Irq0AluInmTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 05 : Irq1ShiftInmTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 06 : Irq2ShiftTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 07 : AluTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 08 : ConditionalTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 09 : Irq3SpOpTest
-- 
--******************************************************--

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 10 : CsrOpTest
-- 
--******************************************************-- 	

--******************************************************--
-- 
-- Type used to control the output signals on Test 
-- 11 : ErrorTest
-- 
--******************************************************--

TYPE RiscVSpy IS RECORD
	
	CounterCount : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
END RECORD RiscVSpy;

TYPE Spy IS RECORD
	
	Qs     : STD_LOGIC_VECTOR(6 DOWNTO 0);
	Error  : STD_LOGIC;
	CpuSpy : RiscVSpy;
	
END RECORD Spy;

END PACKAGE OutputControlPackage;

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

PACKAGE BODY OutputControlPackage IS

END OutputControlPackage;