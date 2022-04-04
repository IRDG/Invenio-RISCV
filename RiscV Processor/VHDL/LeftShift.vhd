--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity LeftShift is
port(
		--Entradas
			Reloj: 					in		std_logic;
			
			Reset: 					in 	std_logic;
			
			Enable: 					in 	std_logic;
				--Señal para mover el contenido de left shift a la izquierda
				
			Replace:					in 	std_logic;
				--Señal para reemplazar el valor actual por el valor de DataIn
				
			DataIn: 					in 	std_logic_vector(31 downto 0);
			--contiene el nuevo PC para ser almacenado.
			
		--Salidas		
			LeftShiftRegister: 	out	std_logic_vector(31 downto 0)
			--Señal que envía el contenido de LeftShiftRegister 
			

	  );
end entity LeftShift;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                                        --
--******************************************************--

architecture LeftShiftArch of LeftShift is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

CONSTANT Zeros : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

SIGNAL   Q     : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL   D     : STD_LOGIC_VECTOR(31 DOWNTO 0);

--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

PROCESS(Reloj, Reset, D)

BEGIN
	
	IF(Reset = '1')THEN
		
		Q <= Zeros;
		
	ELSIF(Rising_Edge(Reloj))THEN
		
		IF   (Enable = '1')THEN
			
			Q <= D;
			
		ELSIF(Replace = '1')THEN
			
			Q <= D;
			
		END IF;
		
	END IF;
	
END PROCESS;
	
D( 0)<= Replace AND DataIn(0 );
D( 1)<=(Replace AND DataIn(1 )) OR (Q(0 ) AND NOT Replace);
D( 2)<=(Replace AND DataIn(2 )) OR (Q(1 ) AND NOT Replace);
D( 3)<=(Replace AND DataIn(3 )) OR (Q(2 ) AND NOT Replace);
D( 4)<=(Replace AND DataIn(4 )) OR (Q(3 ) AND NOT Replace);
D( 5)<=(Replace AND DataIn(5 )) OR (Q(4 ) AND NOT Replace);
D( 6)<=(Replace AND DataIn(6 )) OR (Q(5 ) AND NOT Replace);
D( 7)<=(Replace AND DataIn(7 )) OR (Q(6 ) AND NOT Replace);
D( 8)<=(Replace AND DataIn(8 )) OR (Q(7 ) AND NOT Replace);
D( 9)<=(Replace AND DataIn(9 )) OR (Q(8 ) AND NOT Replace);
D(10)<=(Replace AND DataIn(10)) OR (Q(9 ) AND NOT Replace);
D(11)<=(Replace AND DataIn(11)) OR (Q(10) AND NOT Replace);
D(12)<=(Replace AND DataIn(12)) OR (Q(11) AND NOT Replace);
D(13)<=(Replace AND DataIn(13)) OR (Q(12) AND NOT Replace);
D(14)<=(Replace AND DataIn(14)) OR (Q(13) AND NOT Replace);
D(15)<=(Replace AND DataIn(15)) OR (Q(14) AND NOT Replace);
D(16)<=(Replace AND DataIn(16)) OR (Q(15) AND NOT Replace);
D(17)<=(Replace AND DataIn(17)) OR (Q(16) AND NOT Replace);
D(18)<=(Replace AND DataIn(18)) OR (Q(17) AND NOT Replace);
D(19)<=(Replace AND DataIn(19)) OR (Q(18) AND NOT Replace);
D(20)<=(Replace AND DataIn(20)) OR (Q(19) AND NOT Replace);
D(21)<=(Replace AND DataIn(21)) OR (Q(20) AND NOT Replace);
D(22)<=(Replace AND DataIn(22)) OR (Q(21) AND NOT Replace);
D(23)<=(Replace AND DataIn(23)) OR (Q(22) AND NOT Replace);
D(24)<=(Replace AND DataIn(24)) OR (Q(23) AND NOT Replace);
D(25)<=(Replace AND DataIn(25)) OR (Q(24) AND NOT Replace);
D(26)<=(Replace AND DataIn(26)) OR (Q(25) AND NOT Replace);
D(27)<=(Replace AND DataIn(27)) OR (Q(26) AND NOT Replace);
D(28)<=(Replace AND DataIn(28)) OR (Q(27) AND NOT Replace);
D(29)<=(Replace AND DataIn(29)) OR (Q(28) AND NOT Replace);
D(30)<=(Replace AND DataIn(30)) OR (Q(29) AND NOT Replace);
D(31)<=(Replace AND DataIn(31)) OR (Q(30) AND NOT Replace);
	

LeftShiftRegister<= Q;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.LeftShift
--PORT MAP	  (Enable            => SLV,
--				Replace           => SLV,
--				DataIn            => SLV,
--				Reset             => SLV,
--				Reloj             => SLV,
--				LeftShiftRegister => SLV
--			  );
--******************************************************--
End  LeftShiftArch;
