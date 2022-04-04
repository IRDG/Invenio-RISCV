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

--******************************************************--
-- Comentarios:
-- 
-- 
--******************************************************--

ENTITY Word IS
	
	PORT	 (
				D      : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Enable : IN  STD_LOGIC;
				Reset  : IN  STD_LOGIC;
				Clk    : IN  STD_LOGIC;
				Q      : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			 );
	
END ENTITY Word;

ARCHITECTURE WordArch OF Word IS

CONSTANT Zero : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

PROCESS(Clk, Reset, D)

BEGIN
	
	IF(Reset = '1')THEN
		
		Q <= Zero;
		
	ELSIF(Rising_Edge(Clk))THEN
		
		IF(Enable = '1')THEN
			
			Q <= D;
			
		END IF;
		
	END IF;
	
END PROCESS;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.Word 
--PORT MAP	  (D      => SLV,
--				Enable => SLV,
--				Reset  => SLV,
--				Clk    => SLV,
--				Q      => SLV
--			  );
--******************************************************--

END WordArch;