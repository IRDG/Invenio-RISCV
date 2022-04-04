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
