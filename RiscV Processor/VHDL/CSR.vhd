--******************************************************--
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disegno Digital                       --
--          Seccion de Tecnicas Digitales               --
-- 													              --
-- Titulo :                                             --
-- Fecha  :  	D:XX M:XX Y:20XX                         --
--******************************************************--

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
LIBRARY ALTERA;
USE ALTERA.altera_primitives_components.ALL;

--*************************************************************************--
--                                                                         --
-- IO Annotations:                                                         --
--                                                                         --
-- ControlCsr is given by the following states in that exact order:        --
-- State : [101] [100] [99] [98] [95] [94] [93] [92] [91]                  --
-- Ctrl  : [ 18] [ 17] [16] [15] [14] [13] [12] [11] [10]                  --
--                                                                         --
--                                                                         --
-- State : [90] [88] [84] [73] [72] [71] [70] [69] [68] [67]               --
-- Ctrl  : [ 9] [ 8] [ 7] [ 6] [ 5] [ 4] [ 3] [ 2] [ 1] [ 0]               --
--                                                                         --
-- Ctrl is the same signal as ControlCsr                                   --
--                                                                         --
--                                                                         --
-- IrCsrException Is used for invalid instruction exception and when is    --
-- required the data from Sext(IR[19:15]). The sign extension is made      --
-- within this block                                                       --
--                                                                         --
--*************************************************************************--

ENTITY CSR IS
	
	PORT	 (
				IrCsr          : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
				ControlCsr     : IN  STD_LOGIC_VECTOR(18 DOWNTO 0);
				AluCsr         : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				RegistersCsr   : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				IrCsrException : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
				Reset          : IN  STD_LOGIC;
				Clk            : IN  STD_LOGIC;
				CsrPc          : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				CsrRegisters   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				CsrControl     : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0)
			 );
	
END ENTITY CSR;

ARCHITECTURE CSRArch OF CSR IS

CONSTANT Zeros           : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

SIGNAL   SignIR          : STD_LOGIC;
SIGNAL   SextIR          : STD_LOGIC_VECTOR(31 DOWNTO 0);

SIGNAL   Number1         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Number2         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   AddressSelect   : STD_LOGIC_VECTOR( 7 DOWNTO 0);
SIGNAL   InputSelect     : STD_LOGIC_VECTOR( 5 DOWNTO 0);
SIGNAL   OutputSelect    : STD_LOGIC_VECTOR( 1 DOWNTO 0);
SIGNAL   Ctrl            : STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL   Input           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Output          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Address         : STD_LOGIC_VECTOR(11 DOWNTO 0);

SIGNAL   EnaCsrMisa      : STD_LOGIC;
SIGNAL   EnaCsrMstatus   : STD_LOGIC;
SIGNAL   EnaCsrMEPC      : STD_LOGIC;
SIGNAL   EnaCsrMTVal     : STD_LOGIC;
SIGNAL   EnaCsrMIE       : STD_LOGIC;
SIGNAL   EnaCsrMIP       : STD_LOGIC;
SIGNAL   EnaCsrMIAd0     : STD_LOGIC;
SIGNAL   EnaCsrMIad1     : STD_LOGIC;
SIGNAL   EnaCsrMIAd2     : STD_LOGIC;
SIGNAL   EnaCsrMIAd3     : STD_LOGIC;

SIGNAL   MvendorID       : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MArchId         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MImpId          : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MHartID         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Misa            : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   Mstatus         : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MEPC            : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MTVal           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MIE             : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MIP             : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MIAd0           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MIad1           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MIAd2           : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   MIAd3           : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

Ctrl             <= ControlCsr;

--*************************************************************************--
--                                                                         --
-- Asignacion de SIGNALS Address y AddressSelect                           --
--                                                                         --
-- AddressSelect                                                           --
-- La direccion de escritura/lectura no siempre viene del mismo sitio, en  --
-- varios estados es una constante, mientras que en otros viene del IR.    --
-- Por ello se selecciona la fuente por medio de este SIGNAL               --
--                                                                         --
-- Address                                                                 --
-- Tiene la direccion de escritura/Lectura que se usa en todos los CSR     -- 
--                                                                         --
--*************************************************************************--

AddressSelect(7) <= Ctrl(18);                                                             -- Address 0x30A
AddressSelect(6) <= Ctrl(17);                                                             -- Address 0x309
AddressSelect(5) <= Ctrl(16);                                                             -- Address 0x308
AddressSelect(4) <= Ctrl(15);                                                             -- Address 0x307
AddressSelect(3) <= Ctrl( 9) OR Ctrl(10) OR Ctrl(11) OR
						  Ctrl(12) OR Ctrl(13) OR Ctrl(14);                                     -- Address 0x344
AddressSelect(2) <= Ctrl( 8);                                                             -- Address 0x341
AddressSelect(1) <= Ctrl( 7);                                                             -- Address 0x343
AddressSelect(0) <= Ctrl( 0) OR Ctrl( 1) OR Ctrl( 2) OR 
						  Ctrl( 3) OR Ctrl( 4) OR Ctrl( 5) OR Ctrl( 6); -- Address Given by IR[31:20]

WITH AddressSelect SELECT
Address <= IrCsr  WHEN "00000001",
			  x"343" WHEN "00000010",
			  x"341" WHEN "00000100",
			  x"344" WHEN "00001000",
			  x"307" WHEN "00010000",
			  x"308" WHEN "00100000",
			  x"309" WHEN "01000000",
			  x"30A" WHEN "10000000",
			  x"000" WHEN OTHERS;

--*************************************************************************--
--                                                                         --
-- Asignacion de SIGNALS input/Output Select                               --
--                                                                         --
-- Usadas para controlar la fuente/destino de los datos de                 --
-- escritura/lectura                                                       --
--                                                                         --
--*************************************************************************--

InputSelect(5)   <= Ctrl(14) ;                                                -- Input coming from Constant 2
InputSelect(4)   <= Ctrl( 9) OR Ctrl(10) OR Ctrl(11) OR Ctrl(12) OR Ctrl(13); -- Input coming from Constant 1
InputSelect(3)   <= Ctrl( 7) ;                                                -- Input coming from Exception
InputSelect(2)   <= Ctrl( 4) ;                                                -- Input coming from Sext(IR)
InputSelect(1)   <= Ctrl( 2) OR Ctrl( 3) OR Ctrl( 5) OR Ctrl( 6);             -- Input coming from ALU
InputSelect(0)   <= Ctrl( 1) ;                                                -- Input coming from Registers

OutputSelect(1)  <= Ctrl( 0);                                                 -- Output going to register 
OutputSelect(0)  <= Ctrl( 8) OR Ctrl(15) OR Ctrl(16) OR Ctrl(17) OR Ctrl(18); -- Output going to PC

--*************************************************************************--
--                                                                         --
-- Asignacion de SIGNALS Input/Output                                      --
--                                                                         --
-- Input :                                                                 --
-- Puesto que todos los registros implementados se pueden escribir, y los  --
-- datos de escritura vienen de diferntes fuentes, se tiene un SIGNAL que  --
-- comprende todas las fuentes de escritura, es controlado por InputSelect --
--                                                                         --
-- Output                                                                  --
-- Puesto que la mayoria de CSR no tienen un registro implementado, se     --
-- verifica que direccion se esta pidiendo, y si es una de las direcciones --
-- con datos implementados, se da el valor del registro/dato, si no esta   --
-- implementado, se regresa 0x0000                                         --
--                                                                         --
--*************************************************************************--

WITH InputSelect SELECT
Input <= RegistersCsr   WHEN "000001",
			AluCsr         WHEN "000010",
			SextIR         WHEN "000100",
			IrCsrException WHEN "001000",
			Number1        WHEN "010000",
			Number2        WHEN "100000",
			Zeros          WHEN OTHERS;

WITH Address SELECT
Output <= MvendorID WHEN x"F11",
			 MArchId   WHEN x"F12",
			 MImpId    WHEN x"F13",
			 MHartID   WHEN x"F14",
			 Misa      WHEN x"301",
			 Mstatus   WHEN x"300",
			 MEPC      WHEN x"341",
			 MTVal     WHEN x"343",
			 MIE       WHEN x"304",
			 MIP       WHEN x"344",
			 MIAd0     WHEN x"307",
			 MIad1     WHEN x"308",
			 MIAd2     WHEN x"309",
			 MIAd3     WHEN x"30A",
			 Zeros     WHEN OTHERS;

--*************************************************************************--
--                                                                         --
-- OUTPUT ASSIGNATION                                                      --
--                                                                         --
-- CsrControl                                                              --
-- Esta salida envia datos de diferentes registros en  posiciones          --
-- especificas, usados para las interrupciones en el control               --
--                                                                         --
-- CsrRegisters                                                            --
-- Envia datos leidos de un CSR al bloque de regsitros                     --
-- Se habilita con OutputSelect(1) en alto.                                --
--                                                                         --
-- CsrPc                                                                   --
-- Envia datos leidos de un CSR al PC                                      --
-- Se habilita con OutputSelect(0) en alto.                                --
--                                                                         --
--*************************************************************************--

CsrControl(5) <= Mstatus(4);
CsrControl(4) <= MIE(31);
CsrControl(3) <= MIE(30);
CsrControl(2) <= MIE(29);
CsrControl(1) <= MIE(28);
CsrControl(0) <= MIP(31);

OutputGenerator: FOR I IN 0 TO 31 GENERATE
	
	CsrRegisters(I) <= Output(I) AND OutputSelect(1);
	CsrPc       (I) <= Output(I) AND OutputSelect(0);
	
END GENERATE OutputGenerator;

--*************************************************************************--
--                                                                         --
-- Enable Signals                                                          --
--                                                                         --
-- Debido a que no todos los CSR se pueden escribir en todos los estados   --
-- se habilita la escritura solamente en donde es permitido                --
--                                                                         --
--*************************************************************************--

EnaCsrMisa      <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMstatus   <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMEPC      <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMTVal     <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) OR Ctrl( 7) ;
EnaCsrMIE       <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMIP       <= Ctrl(14) OR Ctrl(13) OR Ctrl(12) OR Ctrl(11) OR Ctrl(10) OR Ctrl( 9) ;
EnaCsrMIAd0     <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMIad1     <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMIAd2     <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;
EnaCsrMIAd3     <= Ctrl( 6) OR Ctrl( 5) OR Ctrl( 4) OR Ctrl( 3) OR Ctrl( 2) OR Ctrl( 1) ;

--*************************************************************************--
--                                                                         --
-- Signo extendido y escritura limitada                                    --
--                                                                         --
-- El CSR[0x344] (MIP) tiene instrucciones especiales para darle valores   --
-- especificos, para ello se usan Number 1 y 2                             --
--                                                                         --
-- El generador es usado para extender el signo del IR[19:15]              --
--                                                                         --
--*************************************************************************--

Number1   <= (MIP) OR ("1" & Ctrl(13) & Ctrl(12) & Ctrl(11) & Ctrl(10) & Ctrl(9) & "00000000000000000000000000");
Number2   <= (MIP) OR ("10000000000000000000100000000000");

SignIR    <= IrCsrException(19);

SextIR(4) <= IrCsrException(19);
SextIR(3) <= IrCsrException(18);
SextIR(2) <= IrCsrException(17);
SextIR(1) <= IrCsrException(16);
SextIR(0) <= IrCsrException(15);

SextGenerator: FOR I IN 31 DOWNTO 5 GENERATE
	
	SextIR(I) <= SignIR;
	
END GENERATE SextGenerator;

--*************************************************************************--
--                                                                         --
-- Valores de registros de solo lectura implementados (Hardwired)          --
--                                                                         --
--*************************************************************************--

MvendorID       <= "00000000000000000000000000000000";
MArchId         <= "01010000010101010100101000110010";
MImpId          <= "00000000000000000000000000000001";
MHartID         <= "00000000000000000000000000000000";

--*************************************************************************--
--                                                                         --
-- Implementacion de los CSR, con sus respectivos valores iniciales,       --
-- direcciones y habilitadores                                             --
--                                                                         --
--*************************************************************************--

PROCESS(Clk, Reset)

BEGIN
	
	IF(Reset='1')THEN
		
		Misa      <= "01000000000000000001000100000000";
		Mstatus   <= "00000000000000000000000000010000";
		MEPC      <= "00000000000000000000000000000000";
		MTVal     <= "00000000000000000000000000000000";
		MIE       <= "00000000000000000000000000000000";
		MIP       <= "00000000000000000000000000000000";
		MIAd0     <= "00000000000000000000000000000000";
		MIad1     <= "00000000000000000000000000000000";
		MIAd2     <= "00000000000000000000000000000000";
		MIAd3     <= "00000000000000000000000000000000";
		
	ELSIF(Rising_Edge(Clk))THEN
		
		IF   ((Address = x"301") AND (EnaCsrMisa      = '1'))THEN
			
			Misa      <= Input;
			
		ELSIF((Address = x"300") AND (EnaCsrMstatus   = '1'))THEN
			
			Mstatus   <= Input;
			
		ELSIF((Address = x"341") AND (EnaCsrMEPC      = '1'))THEN
			
			MEPC      <= Input;
			
		ELSIF((Address = x"343") AND (EnaCsrMTVal     = '1'))THEN
			
			MTVal     <= Input;
			
		ELSIF((Address = x"304") AND (EnaCsrMIE       = '1'))THEN
			
			MIE       <= Input;
			
		ELSIF((Address = x"344") AND (EnaCsrMIP       = '1'))THEN
			
			MIP       <= Input;
			
		ELSIF((Address = x"307") AND (EnaCsrMIAd0     = '1'))THEN
			
			MIAd0     <= Input;
			
		ELSIF((Address = x"308") AND (EnaCsrMIAd1     = '1'))THEN
			
			MIad1     <= Input;
			
		ELSIF((Address = x"309") AND (EnaCsrMIAd2     = '1'))THEN
			
			MIAd2     <= Input;
			
		ELSIF((Address = x"30A") AND (EnaCsrMIAd3     = '1'))THEN
			
			MIAd3     <= Input;
			
		END IF;
		
	END IF;
	
END PROCESS;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.CSR 
--PORT MAP	  (IrCsr          => SLV,
--				ControlCsr     => SLV,
--				AluCsr         => SLV,
--				RegistersCsr   => SLV,
--				IrCsrException => SLV,
--				Reset          => SLV,
--				Clk            => SLV,
--				CsrPc          => SLV,
--				CsrRegisters   => SLV,
--				CsrControl     => SLV
--			  );
--******************************************************--

END CSRArch;