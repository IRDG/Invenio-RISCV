--Definicion de las bibliotecas 
library IEEE; 
use IEEE.STD_LOGIC_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--


entity Alu is
port(
	--Entradas
		
			Reset: 				in STD_LOGIC;
			--Segnal para reiniciar el sistema
			Reloj: 				in STD_LOGIC;
			--segnal de reloj para elfuncionamiento de los bloques
			Registers_Alu: 	in 	STD_LOGIC_VECTOR(63 DOWNTO 0);
			--Segnal que transmite los datos de los registros a la Alu para ser operados.
			IR_Alu: 				in 	STD_LOGIC_VECTOR(29 DOWNTO 0);
			--Envia los datos que deben ser operados en la Alu, tales como datos inmediatos en las instrucciones.
			Control_Alu: 		in 	STD_LOGIC_VECTOR(36 DOWNTO 0);
			--Segnal del control a la Alu, que transmite le código de operación de la Alu y el modo de direccionamiento
			PC_Alu: 				in	STD_LOGIC_VECTOR(31 DOWNTO 0);
			--Segnal que envía el contenido del PC a la Alu
				
	--Salidas
	
			Alu_Registers: 	out	STD_LOGIC_VECTOR(31 DOWNTO 0);
			--Segnal de salida de la Alu, envia a los registros el resultado de una operación.
			Alu_PC: 				out	STD_LOGIC_VECTOR(31 DOWNTO 0);
			--contiene el nuevo PC para ser almacenado.
			Alu_CSR: 			out	STD_LOGIC_VECTOR(31 DOWNTO 0);
			--Segnal de salida de la Alu, envia a los CSR el resultado de una operación.
			Alu_MAR: 			out	STD_LOGIC_VECTOR(31 DOWNTO 0);
			--segnal que envía el resultado de una operación de la Alu al MAR
			Alu_Control: 		out	STD_LOGIC_VECTOR(3 DOWNTO 0);
			--Segnales de la Alu para el control tipo banderas, 
			
			--Segnales para probar
			
			SpyAddrMode0  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode2  :		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode4  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode6  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode8  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode9  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode11 : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode29 : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode32 : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAddrMode34 : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyAdderResult: 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyMulResult  :		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyResultAND  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyResultOR   : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyResultXOR  : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyLsrRegister: 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyLsregister : 		out					STD_LOGIC_VECTOR (31 DOWNTO 0);
			SpyASRRegister: 		out					STD_LOGIC_VECTOR (31 DOWNTO 0)
	  );
end entity Alu;

--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture AluArch of Alu is

--******************************************************
--Segnales de conexion
--******************************************************

CONSTANT Zero               : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"00000000";

--Segnales de ADDER
SIGNAL	AdderInputA        : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	AdderInputB        : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	AdderResult        : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	AdderCarryIn       : STD_LOGIC;

SIGNAL 	AddrASelector      : STD_LOGIC_VECTOR( 1 DOWNTO 0);
SIGNAL 	AddrBSelector      : STD_LOGIC_VECTOR(10 DOWNTO 0);

--Segnales de Logic Shift Right
SIGNAL	LsrEnable          :	STD_LOGIC;
SIGNAL	LsrReplace         : STD_LOGIC;
SIGNAL	LsrDataIn          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	LsrRegister        : STD_LOGIC_VECTOR(31 DOWNTO 0);

--Segnales left shift
SIGNAL	LSEnable           : STD_LOGIC;
SIGNAL	Lsreplace          : STD_LOGIC;
SIGNAL	LSDataIn           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	Lsregister         : STD_LOGIC_VECTOR(31 DOWNTO 0);

--Segnales arithmetic shift right
SIGNAL	ASREnable          : STD_LOGIC;
SIGNAL	ASRReplace         : STD_LOGIC;
SIGNAL	ASRDataIn          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   ASRRegister        : STD_LOGIC_VECTOR(31 DOWNTO 0);

--Segnales multiplicador
SIGNAL   MulInputA          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MulInputB          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MulResult          : STD_LOGIC_VECTOR(31 DOWNTO 0);

--Segnales AND
SIGNAL	InputANDA          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	InputANDB          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ResultAND          : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL	AndBselector       : STD_LOGIC_VECTOR( 2 DOWNTO 0);

--Segnales OR
SIGNAL	InputORA           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	InputORB           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	ResultOR           : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL 	OrBselector        : STD_LOGIC_VECTOR( 2 DOWNTO 0);

--Segnales XOR
SIGNAL	InputXORA          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   InputXORB          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   ResultXOR          : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL 	XorBselector       : STD_LOGIC_VECTOR( 1 DOWNTO 0);

--Segnales modo de direccionamiento 
--El numero se da de acuaerdo al primer estado de decode donde fue usado

SIGNAL 	Salida_Alu         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode0          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode2          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode4          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode6          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode8          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode9          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode11         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode29         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode32         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	AddrMode34         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   LogicMode0         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   LogicMode1         : STD_LOGIC_VECTOR(31 DOWNTO 0);

--Se;ales de salidas
SIGNAL   AluRegSelector     : STD_LOGIC_VECTOR( 5 DOWNTO 0) ;
SIGNAL   AluPcSelector      : STD_LOGIC;
SIGNAL   AluCsrSelector     : STD_LOGIC_VECTOR( 1 DOWNTO 0);
SIGNAL   AluMarSelector     : STD_LOGIC;
SIGNAL   SignalSelector     : STD_LOGIC_VECTOR( 9 DOWNTO 0);
SIGNAL   NoSignalSelector   : STD_LOGIC;

SIGNAL   AluGralSelector    : STD_LOGIC_VECTOR(10 DOWNTO 0);

--Segnal Alu shift register para salida
SIGNAL 	AluShiftRegister   : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL   ZeroRegisters      : STD_LOGIC;
SIGNAL   ZeroMar            : STD_LOGIC;
SIGNAL   ZeroPc             : STD_LOGIC;
SIGNAL   ZeroCsr            : STD_LOGIC;
SIGNAL   ZeroCompare        : STD_LOGIC;

SIGNAL   Alu_Registers_Temp : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Alu_Csr_Temp       : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Alu_Pc_Temp        : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Alu_Mar_Temp       : STD_LOGIC_VECTOR(31 DOWNTO 0);

--******************************************************
--Instancias y Conectividad
--******************************************************
begin

Counter: ENTITY WORK.MulCounter 
PORT MAP	  (Reloj      => Reloj,
				Reset      => Reset,
				Enable     => Control_Alu(31),
				EndOfCount => Alu_Control( 0)
			  );

--Segnales de los modos de direccionamiento
AddrMode0(11 DOWNTO  0)  <="000000000000";
AddrMode0(31 DOWNTO 12)  <= IR_Alu(24 DOWNTO  5);

AddrMode2				    <="00000000000000000000000000000001";

AddrMode4(9  DOWNTO 0 )  <= IR_Alu(23 DOWNTO 14);
AddrMode4(10)			    <= IR_Alu(13);
AddrMode4(18 DOWNTO 11)  <= IR_Alu(12 DOWNTO  5);
AddrMode4(19)			    <= IR_Alu(24);
AddrMode4(20)			    <= IR_Alu(24);
AddrMode4(21)			    <= IR_Alu(24);
AddrMode4(22)			    <= IR_Alu(24);
AddrMode4(23)			    <= IR_Alu(24);
AddrMode4(24)			    <= IR_Alu(24);
AddrMode4(25)			    <= IR_Alu(24);
AddrMode4(26)			    <= IR_Alu(24);
AddrMode4(27)			    <= IR_Alu(24);
AddrMode4(28)			    <= IR_Alu(24);
AddrMode4(29)			    <= IR_Alu(24);
AddrMode4(30)			    <= IR_Alu(24);
AddrMode4(31)			    <= IR_Alu(24);

AddrMode6(19 DOWNTO 0 )  <= IR_Alu(24 DOWNTO  5);
AddrMode6(20)			    <= IR_Alu(24);
AddrMode6(21)			    <= IR_Alu(24);
AddrMode6(22)			    <= IR_Alu(24);
AddrMode6(23)			    <= IR_Alu(24);
AddrMode6(24)			    <= IR_Alu(24);
AddrMode6(25)			    <= IR_Alu(24);
AddrMode6(26)			    <= IR_Alu(24);
AddrMode6(27)			    <= IR_Alu(24);
AddrMode6(28)			    <= IR_Alu(24);
AddrMode6(29)			    <= IR_Alu(24);
AddrMode6(30)			    <= IR_Alu(24);
AddrMode6(31)			    <= IR_Alu(24);

AddrMode8				    <= NOT Registers_Alu(63 DOWNTO 32);

AddrMode9(3 DOWNTO 0)    <= IR_Alu( 4 DOWNTO  1);
AddrMode9(9 DOWNTO 4)    <= IR_Alu(23 DOWNTO 18);
AddrMode9(10)			    <= IR_Alu(0);
AddrMode9(11)			    <= IR_Alu(24);
AddrMode9(12)			    <= IR_Alu(24);
AddrMode9(13)			    <= IR_Alu(24);
AddrMode9(14)			    <= IR_Alu(24);
AddrMode9(15)			    <= IR_Alu(24);
AddrMode9(16)			    <= IR_Alu(24);
AddrMode9(17)			    <= IR_Alu(24);
AddrMode9(18)			    <= IR_Alu(24);
AddrMode9(19)			    <= IR_Alu(24);
AddrMode9(20)			    <= IR_Alu(24);
AddrMode9(21)			    <= IR_Alu(24);
AddrMode9(22)			    <= IR_Alu(24);
AddrMode9(23)			    <= IR_Alu(24);
AddrMode9(24)			    <= IR_Alu(24);
AddrMode9(25)			    <= IR_Alu(24);
AddrMode9(26)			    <= IR_Alu(24);
AddrMode9(27)			    <= IR_Alu(24);
AddrMode9(28)			    <= IR_Alu(24);
AddrMode9(29)			    <= IR_Alu(24);
AddrMode9(30)			    <= IR_Alu(24);
AddrMode9(31)			    <= IR_Alu(24);

AddrMode11(11 DOWNTO 0)  <= IR_Alu(24 DOWNTO 13);
AddrMode11(12)			    <= IR_Alu(24);
AddrMode11(13)			    <= IR_Alu(24);
AddrMode11(14)			    <= IR_Alu(24);
AddrMode11(15)			    <= IR_Alu(24);
AddrMode11(16)			    <= IR_Alu(24);
AddrMode11(17)			    <= IR_Alu(24);
AddrMode11(18)			    <= IR_Alu(24);
AddrMode11(19)			    <= IR_Alu(24);
AddrMode11(20)			    <= IR_Alu(24);
AddrMode11(21)			    <= IR_Alu(24);
AddrMode11(22)			    <= IR_Alu(24);
AddrMode11(23)			    <= IR_Alu(24);
AddrMode11(24)			    <= IR_Alu(24);
AddrMode11(25)			    <= IR_Alu(24);
AddrMode11(26)			    <= IR_Alu(24);
AddrMode11(27)			    <= IR_Alu(24);
AddrMode11(28)			    <= IR_Alu(24);
AddrMode11(29)			    <= IR_Alu(24);
AddrMode11(30)			    <= IR_Alu(24);
AddrMode11(31)			    <= IR_Alu(24);

AddrMode32( 5 DOWNTO 0)  <= IR_Alu(5 DOWNTO 0);
AddrMode32(31 DOWNTO 6)	 <="00000000000000000000000000";

AddrMode34( 4 DOWNTO 0)  <= IR_Alu(29 DOWNTO 25);
AddrMode34( 5)				 <= IR_Alu(5);
AddrMode34(31 DOWNTO 6)	 <="00000000000000000000000000";


AddrMode29( 4 DOWNTO 0)  <= IR_Alu(12 DOWNTO 8);
AddrMode29( 5)			    <= IR_Alu(12);
AddrMode29( 6)			    <= IR_Alu(12);
AddrMode29( 7)			    <= IR_Alu(12);
AddrMode29( 8)			    <= IR_Alu(12);
AddrMode29( 9)			    <= IR_Alu(12);
AddrMode29(10)			    <= IR_Alu(12);
AddrMode29(11)			    <= IR_Alu(12);
AddrMode29(12)			    <= IR_Alu(12);
AddrMode29(13)			    <= IR_Alu(12);
AddrMode29(14)			    <= IR_Alu(12);
AddrMode29(15)			    <= IR_Alu(12);
AddrMode29(16)			    <= IR_Alu(12);
AddrMode29(17)			    <= IR_Alu(12);
AddrMode29(18)			    <= IR_Alu(12);
AddrMode29(19)			    <= IR_Alu(12);
AddrMode29(20)			    <= IR_Alu(12);
AddrMode29(21)			    <= IR_Alu(12);
AddrMode29(22)			    <= IR_Alu(12);
AddrMode29(23)			    <= IR_Alu(12);
AddrMode29(24)			    <= IR_Alu(12);
AddrMode29(25)			    <= IR_Alu(12);
AddrMode29(26)			    <= IR_Alu(12);
AddrMode29(27)			    <= IR_Alu(12);
AddrMode29(28)			    <= IR_Alu(12);
AddrMode29(29)			    <= IR_Alu(12);
AddrMode29(30)			    <= IR_Alu(12);
AddrMode29(31)			    <= IR_Alu(12);

LogicMode0(11 DOWNTO  0) <= IR_Alu(24 DOWNTO 13);
LogicMode0(31 DOWNTO 12) <= "00000000000000000000";

LogicMode1( 4 DOWNTO  0) <= IR_Alu(12 DOWNTO  8);
LogicMode1(31 DOWNTO  5) <= "000000000000000000000000000";

--Fin de segnales de modos de direccionamiento

--Segnal de seleccion para el primer termino de la suma
AddrASelector(0) <= ( Control_Alu(0 ) OR Control_Alu(1 ) OR Control_Alu(2 ) OR Control_Alu(3 ) OR Control_Alu(4 ) OR Control_Alu(5 ) OR Control_Alu(9 ) OR Control_Alu(10) );
AddrASelector(1) <= ( Control_Alu(6 ) OR Control_Alu(7 ) OR Control_Alu(8 ) OR Control_Alu(11) OR Control_Alu(12) OR Control_Alu(13) OR Control_Alu(14) OR Control_Alu(21) OR Control_Alu(22) OR Control_Alu(32) OR Control_Alu(33) OR Control_Alu(34) OR Control_Alu(35));

--Segnal de seleccion para el segundo termino de la suma
AddrBSelector( 0) <= (Control_Alu( 0) OR Control_Alu( 1));
AddrBSelector( 1) <= (Control_Alu( 2) OR Control_Alu( 3));
AddrBSelector( 2) <= (Control_Alu( 4) OR Control_Alu( 5));
AddrBSelector( 3) <= (Control_Alu( 6) OR Control_Alu( 7));
AddrBSelector( 4) <= (Control_Alu( 8) OR Control_Alu(22));
AddrBSelector( 5) <= (Control_Alu( 9) OR Control_Alu(10));
AddrBSelector( 6) <= (Control_Alu(11) OR Control_Alu(12) OR Control_Alu(13));
AddrBSelector( 7) <= (Control_Alu(32) OR Control_Alu(33));
AddrBSelector( 8) <= (Control_Alu(34) OR Control_Alu(35));	
AddrBSelector( 9) <=  Control_Alu(14);
AddrBSelector(10) <=  Control_Alu(21);

--Segnal de carry de entrada
AdderCarryIn      <=  Control_Alu(8) OR Control_Alu(14) OR Control_Alu(22);

--AND
InputAndA         <=	 Registers_Alu(31 DOWNTO  0);

--Segnal de  seleccion de segundo termino de AND
AndBselector(0)   <=  Control_Alu(17);
AndBselector(1)   <=  Control_Alu(28) OR Control_Alu(26);
AndBselector(2)   <=  Control_Alu(30);

--OR
InputOrA          <=	Registers_Alu(31 DOWNTO  0);

--Segnal de  seleccion de segundo termino de OR
OrBselector(0)    <=  Control_Alu(16);
OrBselector(1)    <= (Control_Alu(25) OR Control_Alu(27) );
OrBselector(2)    <=  Control_Alu(29);

--XOR
InputXorA         <=	 Registers_Alu(31 DOWNTO  0);

--Segnal de  seleccion de segundo termino de XOR
XorBselector(0)   <=  Control_Alu(15);
XorBselector(1)   <=  Control_Alu(24);

--Segnales de bloques shift

--Segnales LogicalShiftRight
LsrEnable  <=		Control_Alu(19);
LsrReplace <= 		Control_Alu(36) OR Control_Alu(18) OR Control_Alu(20);

--Segnales left shift
LSEnable  <=		Control_Alu(18);
Lsreplace <=		Control_Alu(36) OR Control_Alu(19) OR Control_Alu(20);

--Segnales ArithmeticShiftRight
ASREnable  <=		Control_Alu(20);
ASRReplace <=		Control_Alu(36) OR Control_Alu(19) OR Control_Alu(18);

--Segnales Multiplicador
MulInputA <=		Registers_Alu(31 DOWNTO  0);
MulInputB <=		Registers_Alu(63 DOWNTO 32);

--Proceso para asignar segnales de entrada a bloques con decodificacion

WITH AddrASelector SELECT
AdderInputA <= Pc_Alu                     WHEN "01",
					Registers_Alu(31 DOWNTO 0) WHEN "10",
					Zero                       WHEN OTHERS;

WITH AddrBSelector SELECT
AdderInputB <=      AddrMode0              WHEN "00000000001",
					     AddrMode2              WHEN "00000000010",
					     AddrMode4              WHEN "00000000100",
					     AddrMode11             WHEN "00000001000",  -- previamente Mode 6
					     AddrMode8              WHEN "00000010000",
					     AddrMode9              WHEN "00000100000",
					     AddrMode11             WHEN "00001000000",
					     AddrMode32             WHEN "00010000000",
					     AddrMode34             WHEN "00100000000",
					NOT (AddrMode11)            WHEN "01000000000",
					Registers_Alu(63 DOWNTO 32) WHEN "10000000000",
					Zero                        WHEN OTHERS;

WITH AndBselector SELECT
InputAndB <= LogicMode0                  WHEN "001",
				 Registers_Alu(63 DOWNTO 32) WHEN "010",
				 LogicMode1                  WHEN "100",
				 Zero                        WHEN OTHERS;

WITH OrBselector SELECT
InputOrB <= LogicMode0                  WHEN "001",
				Registers_Alu(63 DOWNTO 32) WHEN "010",
				LogicMode1                  WHEN "100",
				Zero                        WHEN OTHERS;

WITH XorBselector SELECT
InputXorB <= LogicMode0                  WHEN "01",
				 Registers_Alu(63 DOWNTO 32) WHEN "10",
				 Zero                        WHEN OTHERS;

WITH Control_Alu(36) SELECT
LsrDataIn  <= Registers_Alu(31 DOWNTO 0) WHEN '1',
				  Zero                       WHEN OTHERS;

WITH Control_Alu(36) SELECT
LsDataIn   <= Registers_Alu(31 DOWNTO 0) WHEN '1',
				  Zero                       WHEN OTHERS;

WITH Control_Alu(36) SELECT
AsrDataIn  <= Registers_Alu(31 DOWNTO 0) WHEN '1',
				  Zero                       WHEN OTHERS;

--*********************************************************************--
-- INSTANCIACION DE COMPONENTES
--*********************************************************************--

CraA32: ENTITY WORK.CraAdder32
PORT MAP	  (A        => AdderInputA,
				B        => AdderInputB,
				CarryIn  => AdderCarryIn,
				Result   => AdderResult,
				CarryOut => Alu_Control(3)
			  );

Lsr: ENTITY WORK.LogicalShiftRight
PORT MAP	  (Enable                    => LsrEnable,
				Replace                   => LsrReplace,
				DataIn                    => LsrDataIn,
				Reset                     => Reset,
				Reloj                     => Reloj,
				LogicalShiftRightRegister => LsrRegister
			  );

Ls: ENTITY WORK.LeftShift
PORT MAP	  (Enable            => LsEnable,
				Replace           => Lsreplace,
				DataIn            => LsDataIn,
				Reset             => Reset,
				Reloj             => Reloj,
				LeftShiftRegister => Lsregister
			  );

Asr: ENTITY WORK.ArithmeticShiftRight
PORT MAP	  (Enable                       => AsrEnable,
				Replace                      => AsrReplace,
				DataIn                       => AsrDataIn,
				Reset                        => Reset,
				Reloj                        => Reloj,
				ArithmeticShiftRightRegister => AsrRegister
			  );

Mul: ENTITY WORK.Multiplier32Bits
PORT MAP	  (Multiplicand => MulInputA,
				Multiplier   => MulInputB,
				Result       => MulResult
			  );

OpAnd: ENTITY WORK.BlockAnd
PORT MAP	  (A        => InputAndA,
				B        => InputAndB,
				Result   => ResultAnd
			  );

OpOr: ENTITY WORK.BlockOr
PORT MAP	  (A        => InputOrA,
				B        => InputOrB,
				Result   => ResultOr
			  );

OpXor: ENTITY WORK.BlockXor
PORT MAP	  (A        => InputXorA,
				B        => InputXorB,
				Result   => ResultXor
			  );

--****************************************************--
--Asignar Salidas
--****************************************************--

AluShiftRegister<=LsrRegister OR Lsregister OR ASRRegister;
--Se;ales de seleccion de salida Alu registers
AluRegSelector(0) <= (Control_Alu( 1) OR Control_Alu( 3) OR Control_Alu(13) OR Control_Alu(22) OR Control_Alu(21)  );
AluRegSelector(1) <= (Control_Alu(15) OR Control_Alu(24) );
AluRegSelector(2) <= (Control_Alu(16) OR Control_Alu(25) );
AluRegSelector(3) <= (Control_Alu(17) OR Control_Alu(26) );
AluRegSelector(4) <=  Control_Alu(23);
AluRegSelector(5) <=  Control_Alu(31);

--Segnal de seleccion de salida Alu pc
AluPcSelector     <= (Control_Alu( 5) OR Control_Alu( 7) OR Control_Alu(10));

--Segnal de seleccion de salida Alu csr
AluCsrSelector(0) <= (Control_Alu(27) OR Control_Alu(29) );
AluCsrSelector(1) <= (Control_Alu(28) OR Control_Alu(30) );

--Segnal de seleccion de salida Alu mar
AluMarSelector    <= (Control_Alu(12) OR Control_Alu(33) OR Control_Alu(35));

SignalSelector    <= (AluMarSelector & AluCsrSelector & AluPcSelector & AluRegSelector);

WITH SignalSelector SELECT
NoSignalSelector  <= '1' WHEN "0000000000",
							'0' WHEN "0000000001",
							'0' WHEN "0000000010",
							'0' WHEN "0000000100",
							'0' WHEN "0000001000",
							'0' WHEN "0000010000",
							'0' WHEN "0000100000",
							'0' WHEN "0001000000",
							'0' WHEN "0010000000",
							'0' WHEN "0100000000",
							'0' WHEN "1000000000",
							'0' WHEN OTHERS;

-- Asignar salidas

WITH AluRegSelector SELECT
Alu_Registers_Temp <= AdderResult      WHEN "000001",
							 ResultXOR        WHEN "000010",
							 ResultOR         WHEN "000100",
							 ResultAND        WHEN "001000",
							 AluShiftRegister WHEN "010000",
							 MulResult        WHEN "100000",
							 Zero             WHEN OTHERS;

WITH AluPcSelector SELECT
Alu_Pc_Temp <= AdderResult WHEN '1',
					Zero        WHEN OTHERS;

WITH AluCsrSelector SELECT
Alu_Csr_Temp <= ResultOR  WHEN "01",
					 ResultAND WHEN "10",
					 Zero      WHEN OTHERS;

WITH AluMarSelector SELECT
Alu_Mar_Temp <= AdderResult WHEN '1',
					 Zero        WHEN OTHERS;

Alu_Registers <= Alu_Registers_Temp;
Alu_Pc        <= Alu_Pc_Temp;
Alu_Csr       <= Alu_Csr_Temp;
Alu_Mar       <= Alu_Mar_Temp;
		
WITH Alu_Registers_Temp SELECT
ZeroRegisters <= '1' WHEN x"00000000",
					  '0' WHEN OTHERS;

WITH Alu_Pc_Temp SELECT
ZeroMar       <= '1' WHEN x"00000000",
					  '0' WHEN OTHERS;

WITH Alu_Csr_Temp SELECT
ZeroPc        <= '1' WHEN x"00000000",
					  '0' WHEN OTHERS;

WITH Alu_Mar_Temp SELECT
ZeroCsr       <= '1' WHEN x"00000000",
					  '0' WHEN OTHERS;

WITH AdderResult SELECT
ZeroCompare   <= '1' WHEN x"00000000",
					  '0' WHEN OTHERS;

AluGralSelector <= (NoSignalSelector & SignalSelector);

WITH AluGralSelector SELECT
Alu_Control(1) <= ZeroRegisters WHEN "00000000001",
						ZeroRegisters WHEN "00000000010",
						ZeroRegisters WHEN "00000000100",
						ZeroRegisters WHEN "00000001000",
						ZeroRegisters WHEN "00000010000",
						ZeroRegisters WHEN "00000100000",
						ZeroPc        WHEN "00001000000",
						ZeroCsr       WHEN "00010000000",
						ZeroCsr       WHEN "00100000000",
						ZeroMar       WHEN "01000000000",
						ZeroCompare   WHEN "10000000000",
						'0'           WHEN OTHERS;

Alu_Control(2) <= AdderResult(31);
			
--Salidas para pruebas

SpyResultAND   <= ResultAND;
SpyResultOR    <= ResultOR;
SpyResultXOR   <= ResultXOR;
SpyLsrRegister <= LsrRegister;
SpyLsregister  <= Lsregister;
SpyASRRegister <= ASRRegister;
SpyMulResult   <= MulResult;

SpyAddrMode0   <= AddrMode0;
SpyAddrMode2   <= AddrMode2;
SpyAddrMode4   <= AddrMode4;
SpyAddrMode6   <= AddrMode6;
SpyAddrMode8   <= AddrMode8;
SpyAddrMode9   <= AddrMode9;
SpyAddrMode11  <= AddrMode11;
SpyAddrMode29  <= AddrMode29;
SpyAddrMode32  <= AddrMode32;
SpyAddrMode34  <= AddrMode34;
SpyAdderResult <= AdderResult;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.Alu 
--PORT MAP	  (Registers_Alu  => SLV,
--				Ir_Alu         => SLV,
--				Control_Alu    => SLV,
--				Pc_Alu         => SLV,
--				Reset          => SLV,
--				Reloj          => SLV,
--				Alu_Registers  => SLV,
--				Alu_Pc         => SLV,
--				Alu_Csr        => SLV,
--				Alu_Mar        => SLV,
--				Alu_Control    => SLV,
--				SpyAddrMode0   => SLV,
--				SpyAddrMode2   => SLV,
--				SpyAddrMode4   => SLV,
--				SpyAddrMode6   => SLV,
--				SpyAddrMode8   => SLV,
--				SpyAddrMode9   => SLV,
--				SpyAddrMode11  => SLV,
--				SpyAddrMode29  => SLV,
--				SpyAddrMode32  => SLV,
--				SpyAddrMode34  => SLV,
--				SpyAdderResult => SLV,
--				SpyMulResult   => SLV,
--				SpyResultAnd   => SLV,
--				SpyResultOr    => SLV,
--				SpyResultXor   => SLV,
--				SpyLsrRegister => SLV,
--				SpyLsregister  => SLV,
--				SpyASRRegister => SLV
--			  );
--******************************************************--

End  AluArch;
