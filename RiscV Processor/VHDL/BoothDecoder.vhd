--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity BoothDecoder is
port(
		--Entradas
		
			MultiplierIn:	in std_logic_vector(2 downto 0);
			
			--Señales del multiplicador 0 es el lsb y 2 el msb
		--Salidas
		
			S:				out	std_logic;
			-- Señal S para el signo del producto parcial
			
			NotS:			out	std_logic;
			--Señal S negada
				
			Select_M:	out	std_logic;
			--Señal que selecciona si el multiplicando se multiplica por uno
			
			Select_2M: 	out	std_logic
			--Señal que selecciona si el multiplicando se multiplica por dos
	  );
end entity BoothDecoder;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                                        --
--******************************************************--

architecture BoothDecoderArch of BoothDecoder is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

	Select_M	<=(MultiplierIn(0) XOR MultiplierIn(1));

	S			<=(MultiplierIn(2) 	  );
			
	NotS		<=(NOT MultiplierIn(2));
			
	Select_2M<=(NOT ( (MultiplierIn(0) XOR MultiplierIn(1))OR(MultiplierIn(1) XNOR MultiplierIn(2)) ));



End  BoothDecoderArch;


