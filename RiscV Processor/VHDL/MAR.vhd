
--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;
library ALTERA;
use ALTERA.altera_primitives_components.all;



--Declaracion de entradas y salidas del bloque--
Entity Mar is
	port(
			
			Reset: 					in std_logic;
			--Señal para reiniciar el sistema
			Reloj: 					in std_logic;
			--señal de reloj para elfuncionamiento d elos bloques
			PC_Mar: 					in 	std_logic_vector(31 downto 0);
			--Señal que envía la dirección desde el PC al Mar para obtener la instrucción de memoria.
			ALU_Mar: 				in 	std_logic_vector(31 downto 0); 
			--señal que envía el resultado de una operación de la ALU al Mar
			Registers_Mar:			in		std_logic_vector(31 downto 0);
			--Señal del banco de registros para almacenar valor de registros, en especifico SP al Mar
			Control_Mar:			in		std_logic_vector(2  downto 0);
		
			MemoryAddress: 		out	std_logic_vector(31 downto 0)
			--señal que envía la dirección almacenada en Mar a la memoria.
		 );
end Entity Mar;



architecture MarArch of Mar is

CONSTANT Zeros  : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

SIGNAL   auxQ   : STD_LOGIC_VECTOR(31 downto 0); 
SIGNAL   auxD   : STD_LOGIC_VECTOR(31 downto 0);
SIGNAL   Enable : STD_LOGIC;

BEGIN
Enable<=(Control_Mar(0) OR Control_Mar(1) OR Control_Mar(2));

auxD(0 )<= ( ( PC_Mar(0 ) AND Control_Mar(0) ) OR ( ALU_Mar(0 ) AND Control_Mar(1) ) OR ( Registers_Mar(0 ) AND Control_Mar(2) ) );                                        
auxD(1 )<= ( ( PC_Mar(1 ) AND Control_Mar(0) ) OR ( ALU_Mar(1 ) AND Control_Mar(1) ) OR ( Registers_Mar(1 ) AND Control_Mar(2) ) );                                        
auxD(2 )<= ( ( PC_Mar(2 ) AND Control_Mar(0) ) OR ( ALU_Mar(2 ) AND Control_Mar(1) ) OR ( Registers_Mar(2 ) AND Control_Mar(2) ) );                                        
auxD(3 )<= ( ( PC_Mar(3 ) AND Control_Mar(0) ) OR ( ALU_Mar(3 ) AND Control_Mar(1) ) OR ( Registers_Mar(3 ) AND Control_Mar(2) ) );                                        
auxD(4 )<= ( ( PC_Mar(4 ) AND Control_Mar(0) ) OR ( ALU_Mar(4 ) AND Control_Mar(1) ) OR ( Registers_Mar(4 ) AND Control_Mar(2) ) );                                        
auxD(5 )<= ( ( PC_Mar(5 ) AND Control_Mar(0) ) OR ( ALU_Mar(5 ) AND Control_Mar(1) ) OR ( Registers_Mar(5 ) AND Control_Mar(2) ) );                                        
auxD(6 )<= ( ( PC_Mar(6 ) AND Control_Mar(0) ) OR ( ALU_Mar(6 ) AND Control_Mar(1) ) OR ( Registers_Mar(6 ) AND Control_Mar(2) ) );                                        
auxD(7 )<= ( ( PC_Mar(7 ) AND Control_Mar(0) ) OR ( ALU_Mar(7 ) AND Control_Mar(1) ) OR ( Registers_Mar(7 ) AND Control_Mar(2) ) );                                        
auxD(8 )<= ( ( PC_Mar(8 ) AND Control_Mar(0) ) OR ( ALU_Mar(8 ) AND Control_Mar(1) ) OR ( Registers_Mar(8 ) AND Control_Mar(2) ) );                                        
auxD(9 )<= ( ( PC_Mar(9 ) AND Control_Mar(0) ) OR ( ALU_Mar(9 ) AND Control_Mar(1) ) OR ( Registers_Mar(9 ) AND Control_Mar(2) ) );                                        
auxD(10)<= ( ( PC_Mar(10) AND Control_Mar(0) ) OR ( ALU_Mar(10) AND Control_Mar(1) ) OR ( Registers_Mar(10) AND Control_Mar(2) ) );                                    
auxD(11)<= ( ( PC_Mar(11) AND Control_Mar(0) ) OR ( ALU_Mar(11) AND Control_Mar(1) ) OR ( Registers_Mar(11) AND Control_Mar(2) ) );                                    
auxD(12)<= ( ( PC_Mar(12) AND Control_Mar(0) ) OR ( ALU_Mar(12) AND Control_Mar(1) ) OR ( Registers_Mar(12) AND Control_Mar(2) ) );                                    
auxD(13)<= ( ( PC_Mar(13) AND Control_Mar(0) ) OR ( ALU_Mar(13) AND Control_Mar(1) ) OR ( Registers_Mar(13) AND Control_Mar(2) ) );                                    
auxD(14)<= ( ( PC_Mar(14) AND Control_Mar(0) ) OR ( ALU_Mar(14) AND Control_Mar(1) ) OR ( Registers_Mar(14) AND Control_Mar(2) ) );                                    
auxD(15)<= ( ( PC_Mar(15) AND Control_Mar(0) ) OR ( ALU_Mar(15) AND Control_Mar(1) ) OR ( Registers_Mar(15) AND Control_Mar(2) ) );                                    
auxD(16)<= ( ( PC_Mar(16) AND Control_Mar(0) ) OR ( ALU_Mar(16) AND Control_Mar(1) ) OR ( Registers_Mar(16) AND Control_Mar(2) ) );                                    
auxD(17)<= ( ( PC_Mar(17) AND Control_Mar(0) ) OR ( ALU_Mar(17) AND Control_Mar(1) ) OR ( Registers_Mar(17) AND Control_Mar(2) ) );                                    
auxD(18)<= ( ( PC_Mar(18) AND Control_Mar(0) ) OR ( ALU_Mar(18) AND Control_Mar(1) ) OR ( Registers_Mar(18) AND Control_Mar(2) ) );                                    
auxD(19)<= ( ( PC_Mar(19) AND Control_Mar(0) ) OR ( ALU_Mar(19) AND Control_Mar(1) ) OR ( Registers_Mar(19) AND Control_Mar(2) ) );                                    
auxD(20)<= ( ( PC_Mar(20) AND Control_Mar(0) ) OR ( ALU_Mar(20) AND Control_Mar(1) ) OR ( Registers_Mar(20) AND Control_Mar(2) ) );                                    
auxD(21)<= ( ( PC_Mar(21) AND Control_Mar(0) ) OR ( ALU_Mar(21) AND Control_Mar(1) ) OR ( Registers_Mar(21) AND Control_Mar(2) ) );                                    
auxD(22)<= ( ( PC_Mar(22) AND Control_Mar(0) ) OR ( ALU_Mar(22) AND Control_Mar(1) ) OR ( Registers_Mar(22) AND Control_Mar(2) ) );                                    
auxD(23)<= ( ( PC_Mar(23) AND Control_Mar(0) ) OR ( ALU_Mar(23) AND Control_Mar(1) ) OR ( Registers_Mar(23) AND Control_Mar(2) ) );                                    
auxD(24)<= ( ( PC_Mar(24) AND Control_Mar(0) ) OR ( ALU_Mar(24) AND Control_Mar(1) ) OR ( Registers_Mar(24) AND Control_Mar(2) ) );                                    
auxD(25)<= ( ( PC_Mar(25) AND Control_Mar(0) ) OR ( ALU_Mar(25) AND Control_Mar(1) ) OR ( Registers_Mar(25) AND Control_Mar(2) ) );                                    
auxD(26)<= ( ( PC_Mar(26) AND Control_Mar(0) ) OR ( ALU_Mar(26) AND Control_Mar(1) ) OR ( Registers_Mar(26) AND Control_Mar(2) ) );                                    
auxD(27)<= ( ( PC_Mar(27) AND Control_Mar(0) ) OR ( ALU_Mar(27) AND Control_Mar(1) ) OR ( Registers_Mar(27) AND Control_Mar(2) ) );                                    
auxD(28)<= ( ( PC_Mar(28) AND Control_Mar(0) ) OR ( ALU_Mar(28) AND Control_Mar(1) ) OR ( Registers_Mar(28) AND Control_Mar(2) ) );                                    
auxD(29)<= ( ( PC_Mar(29) AND Control_Mar(0) ) OR ( ALU_Mar(29) AND Control_Mar(1) ) OR ( Registers_Mar(29) AND Control_Mar(2) ) );                                    
auxD(30)<= ( ( PC_Mar(30) AND Control_Mar(0) ) OR ( ALU_Mar(30) AND Control_Mar(1) ) OR ( Registers_Mar(30) AND Control_Mar(2) ) );                                    
auxD(31)<= ( ( PC_Mar(31) AND Control_Mar(0) ) OR ( ALU_Mar(31) AND Control_Mar(1) ) OR ( Registers_Mar(31) AND Control_Mar(2) ) );

--Se reciben todos los datos del registro
PROCESS(Reloj, Reset, AuxD)

BEGIN
	
	IF(Reset = '1')THEN
		
		AuxQ <= Zeros;
		
	ELSIF(Rising_Edge(Reloj))THEN
		
		IF(Enable = '1')THEN
			
			AuxQ <= AuxD;
			
		END IF;
		
	END IF;
	
END PROCESS;

--se envian los datos obtenidos al memory address	
MemoryAddress <= auxQ;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.Mar 
--PORT MAP	  (Pc_Mar        => SLV,
--				Alu_Mar       => SLV,
--				Registers_Mar => SLV,
--				Control_Mar   => SLV,
--				Reset         => SLV,
--				Reloj         => SLV,
--				MemoryAddress => SLV
--			  );
--******************************************************--

END MarArch;