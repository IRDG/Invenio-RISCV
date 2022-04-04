--******************************************************--
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disegno Digital                       --
--          Seccion de Tecnicas Digitales               --
-- 													              --
-- Titulo :                                             --
-- Fecha  :  	D:XX M:XX Y:20XX                         --
--******************************************************--
-- 													              --
---------------- Package: MyPackage.vhd ------------------
-- 													              --
--******************************************************--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

PACKAGE RegistersPackage IS

TYPE     Matrix IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR (31 DOWNTO 0);

--**************************************************************************************************--
--
-- Slv2I         is a Pure function that cast a STD_LOGIC_VECTOR input into an integer
--					  It will give an INTEGER result
-- 				  The result is calculated using UNSIGNED() and TO_INTEGER() functions
-- 
------------------------------------------------------------------------------------------------------
--
-- I2Slv         is a Pure function that cast an INTEGER input into a STD_LOGIC_VECTOR
--               It will give a STD_LOGIC_VECTOR result
--               The result is calculated using TO_UNSIGNED() and STD_LOGIC_VECTOR() functions
--
------------------------------------------------------------------------------------------------------
--
-- Sext          is a Pure function that fills a vector with 1 or 0 regarding the input
--	              It will give a STD_LOGIC_VECTOR result, Size will determine the lenght of it
--               The result is given by the STD_LOGIC input
--
--**************************************************************************************************--

PURE FUNCTION Slv2I(Input : STD_LOGIC_VECTOR)
RETURN INTEGER;

PURE FUNCTION I2Slv(Input : INTEGER;
									 Size  : INTEGER)
RETURN STD_LOGIC_VECTOR;

PURE FUNCTION Sext(Input : STD_LOGIC;
						 Size  : INTEGER)
RETURN STD_LOGIC_VECTOR;

END PACKAGE RegistersPackage;

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

PACKAGE BODY RegistersPackage IS

--**************************************************************************************************--
--
-- Implementation of function Slv2I
--
--
-- Slv2I         is a Pure function that cast a STD_LOGIC_VECTOR input into an integer
--					  It will give an INTEGER result
-- 				  The result is calculated using UNSIGNED() and TO_INTEGER() functions
--
--**************************************************************************************************--

PURE FUNCTION Slv2I(Input : STD_LOGIC_VECTOR)
RETURN INTEGER IS

BEGIN
	
	RETURN TO_INTEGER(UNSIGNED(Input));
	
END Slv2I;

--**************************************************************************************************--
--
-- Implementation of function I2Slv
--
--
-- I2Slv         is a Pure function that cast an INTEGER input into a STD_LOGIC_VECTOR
--               It will give a STD_LOGIC_VECTOR result
--               The result is calculated using TO_UNSIGNED() and STD_LOGIC_VECTOR() functions
--
--**************************************************************************************************--

PURE FUNCTION I2Slv(Input : INTEGER;
									 Size  : INTEGER)
RETURN STD_LOGIC_VECTOR IS

BEGIN
	
	RETURN STD_LOGIC_VECTOR(TO_UNSIGNED(Input,Size));
	
END I2Slv;

--**************************************************************************************************--
--
-- Implementation of function Sext
--
--
-- Sext          is a Pure function that fills a vector with 1 or 0 regarding the input
--	              It will give a STD_LOGIC_VECTOR result, Size will determine the lenght of it
--               The result is given by the STD_LOGIC input
--
--**************************************************************************************************--

PURE FUNCTION Sext(Input : STD_LOGIC;
						 Size  : INTEGER)
RETURN STD_LOGIC_VECTOR IS

CONSTANT Zero : STD_LOGIC_VECTOR(Size-1 DOWNTO 0) := (OTHERS => '0');
CONSTANT Ones : STD_LOGIC_VECTOR(Size-1 DOWNTO 0) := (OTHERS => '1');

BEGIN
	
	IF(Input = '0')THEN
		
		RETURN Zero;
		
	ELSE
		
		RETURN Ones;
		
	END IF;
	
END Sext;
	
END RegistersPackage;