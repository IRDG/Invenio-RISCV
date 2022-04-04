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

ENTITY Sp IS
	
	PORT	 (
				ControlSp  : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
				-- Segnales de control del SP
				-- bit 0 le indica al SP que se auto incremente, aumenta   1 el SP actual
				-- bit 1 le indica al SP que se auto decremente, disminuye 1 el SP actual
				RegisterSp : IN  STD_LOGIC;
				-- Segnal que habilita la carga de datos en el registro, activa en alto
				DataIn     : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				-- Datos que se van a cargar
				Reset      : IN  STD_LOGIC;
				-- Segnal para reiniciar el sistema
				Clk        : IN  STD_LOGIC;
				-- Segnal de reloj para el funcionamiento de los bloques
				SpRegister : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
				-- Salida de 32 bits que contiene el valor actual del Sp
			 );
	
END ENTITY Sp;

ARCHITECTURE SpArch OF Sp IS

CONSTANT Zeros    : UNSIGNED        (31 DOWNTO 0) := x"00000000";

SIGNAL   D        : UNSIGNED        (31 DOWNTO 0);
SIGNAL   Q        : UNSIGNED        (31 DOWNTO 0);
SIGNAL   Selector : STD_LOGIC_VECTOR( 2 DOWNTO 0);
SIGNAL   DataU    : UNSIGNED        (31 DOWNTO 0); 

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

Selector(0) <= ControlSp(0);
Selector(1) <= ControlSp(1);
Selector(2) <= RegisterSp;

DataU       <= UNSIGNED(DataIn);

WITH Selector SELECT
D <= Q + 1 WHEN "001",
     Q - 1 WHEN "010",
	  DataU WHEN "100",
	  Q     WHEN OTHERS;

PROCESS(Clk, Reset, D)

BEGIN
	
	IF(Reset = '1')THEN
		
		Q <= Zeros;
		
	ELSIF(Rising_Edge(Clk))THEN
		
		Q <= D;
		
	END IF;
	
END PROCESS;

SpRegister <= STD_LOGIC_VECTOR(Q);

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.Sp 
--PORT MAP	  (ControlSp  => SLV,
--				RegisterSp => SLV,
--				DataIn     => SLV,
--				Reset      => SLV,
--				Clk        => SLV,
--				SpRegister => SLV
--			  );
--******************************************************--

END SpArch;