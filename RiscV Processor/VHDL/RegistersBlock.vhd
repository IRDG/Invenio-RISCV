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

ENTITY RegistersBlock IS
	
	PORT	 (
				D                : IN  Matrix;
				Enable           : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				ControlSp        : IN  STD_LOGIC_VECTOR( 1 DOWNTO 0);
				Reset            : IN  STD_LOGIC;
				Clk              : IN  STD_LOGIC;
				Q                : OUT Matrix
			 );
	
END ENTITY RegistersBlock;

ARCHITECTURE RegistersBlockArch OF RegistersBlock IS

CONSTANT Zeros  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

BEGIN

--******************************************************--
-- 
-- x00 -> Zero
-- x01 -> Return Address
-- x02 -> Stack  Pointer
-- x03 -> Global Pointer
-- x04 -> Thread Pointer
-- x05 -> Temporal 0
-- x06 -> Temporal 1
-- x07 -> Temporal 2
-- x08 -> S00
-- x09 -> S01
-- x10 -> A0
-- x11 -> A1
-- x12 -> A2
-- x13 -> A3
-- x14 -> A4
-- x15 -> A6
-- x16 -> A6
-- x17 -> A7
-- x18 -> S02
-- x19 -> S03
-- x20 -> S04
-- x21 -> S05
-- x22 -> S06
-- x23 -> S07
-- x24 -> S08
-- x25 -> S09
-- x26 -> S10
-- x27 -> S11
-- x28 -> Temporal 3
-- x29 -> Temporal 4
-- x30 -> Temporal 5
-- x31 -> Temporal 6
-- 
--******************************************************--

Q(0) <= Zeros;

X1: ENTITY WORK.Word 
PORT MAP	  (D      => D(1),
				Enable => Enable(1),
				Reset  => Reset,
				Clk    => Clk,
				Q      => Q(1)
			  );

X2: ENTITY WORK.Sp 
PORT MAP	  (ControlSp  => ControlSp,
				RegisterSp => Enable(2),
				DataIn     => D(2),
				Reset      => Reset,
				Clk        => Clk,
				SpRegister => Q(2)
			  );

RegistersGenerator: FOR I IN 3 TO 31 GENERATE
	
	X: ENTITY WORK.Word 
	PORT MAP	  (D      => D(I),
					Enable => Enable(I),
					Reset  => Reset,
					Clk    => Clk,
					Q      => Q(I)
				  );
	
END GENERATE RegistersGenerator;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.RegistersBlock 
--PORT MAP	  (D         => SLV,
--				Enable    => SLV,
--				ControlSp => SLV,
--				Reset     => SLV,
--				Clk       => SLV,
--				Q         => SLV
--			  );
--******************************************************--

END RegistersBlockArch;