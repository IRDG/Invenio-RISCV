--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity SinglePartialProduct is
port(
		--Entradas
		
			MultiplicandLSB:	in std_logic;
			
			--Señal del lsb del multiplicando
			
			MultiplicandMSB:	in std_logic;
			
			--Señal del msb del multiplicando
			
			S:						in	std_logic;
			-- Señal S para el signo del producto parcial
				
			Select_M:			in	std_logic;
			--Señal que selecciona si el multiplicando se multiplica por uno
			
			Select_2M: 			in	std_logic;
			--Señal que selecciona si el multiplicando se multiplica por dos
		--Salidas
		
			PartialProduct:	out std_logic
		
	  );
end entity SinglePartialProduct;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture SinglePartialProductArch of SinglePartialProduct is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

	PartialProduct<= (S XOR ( (MultiplicandMSB AND Select_M)OR(MultiplicandLSB AND Select_2M) ) );
	--Ecuacion de salida para obtener uno de los productos parciales.

End  SinglePartialProductArch;


