--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--


entity Ir is
port(
		--Entradas
		
			MemoryOut    : IN  STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
			--Salida de datos de la memoria, en este caso, contiene la instrucción
			Control_Ir   : IN  STD_LOGIC := '0';
			--Señal del control que indica al Ir reemplazar su valor con el valor de Memoryout
			Reset        : IN  STD_LOGIC := '0';
			--Señal para reiniciar el sistema
			Reloj        : IN  STD_LOGIC := '1';
			--señal de reloj para el funcionamiento de los bloques
			Ir_Registers : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			--envia la dIrecciones de los registros rd, rs1 o rs2 de las instrucciones para acceder a los registros necesarios.
			Ir_Control   : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
			--envia al control los opcodes de la instrucción para poder determinar los saltos de las instrucciones.
			Ir_Alu       : OUT STD_LOGIC_VECTOR(29 DOWNTO 0);
			--Envia los datos que deben ser operados en la ALU, tales como datos inmediatos en las instrucciones.
			Ir_CSR       : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			--Envia las dIrección de los CSR donde se realiza la instrucción.
			Ir_Counter   : OUT STD_LOGIC_VECTOR( 5 DOWNTO 0)
			--Carga un valor inmediato a Counter
			
	  );
end entity Ir;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture IrArch of Ir is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

CONSTANT Zeros : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

SIGNAL   Q     : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   D     : STD_LOGIC_VECTOR(31 DOWNTO 0);

--******************************************************--
--Instancias y Conectividad
--******************************************************
BEGIN

--Declara los FF que conforman el Ir, el enable es la señal Contol_Ir,
-- al ser 1, reemplaza su valor actual por el de MemoryOut

PROCESS(Reloj, Reset, D)

BEGIN
	
	IF(Reset = '1')THEN
		
		Q <= Zeros;
		
	ELSIF(Rising_Edge(Reloj))THEN
		
		IF(Control_Ir = '1')THEN
			
			Q <= D;
			
		END IF;
		
	END IF;
	
END PROCESS;

D <= MemoryOut;
	
--****************************************************--
--Asignar Salidas
--****************************************************--

Ir_Registers <= Q;
	
--envia la dIrecciones de los registros rd, rs1 o rs2 de las instrucciones para acceder a los registros necesarios.
--DIreccion rd: 	0: 5
--Dato immediato 	5:25
--DIreccion rs1 	9:13
--DIreccion rs2  14:18
			
			
Ir_Control( 6 DOWNTO 0) <= Q( 6 DOWNTO  0);
Ir_Control( 9 DOWNTO 7) <= Q(14 DOWNTO 12);
Ir_Control(10)          <= Q(15);
Ir_Control(11)          <= Q(30);
Ir_Control(12)          <= Q(25);
--envia al control los opcodes de la instrucción para poder determinar los saltos de las instrucciones.
			
Ir_Alu(24 DOWNTO  0)    <= Q(31 DOWNTO 7);
--Envia los datos que deben ser operados en la ALU, tales como datos inmediatos en las instrucciones.
Ir_Alu(29 DOWNTO 25)    <= Q(6 DOWNTO 2);
		
Ir_CSR                  <= Q(31 DOWNTO 0);
--Envia las dIrección de los CSR donde se realiza la instrucción.

Ir_Counter              <= Q(25 DOWNTO 20);
--Carga un valor inmediato a counter

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN : ENTITY WORK.Ir
--PORT MAP	  (MemoryOut    => SLV,
--				Control_Ir   => SLV,
--				Reset        => SLV,
--				Reloj        => SLV,
--				Ir_Registers => SLV,
--				Ir_Control   => SLV,
--				Ir_Alu       => SLV,
--				Ir_CSR       => SLV,
--				Ir_Counter   => SLV
--			  );
--******************************************************--
			
End  IrArch;
