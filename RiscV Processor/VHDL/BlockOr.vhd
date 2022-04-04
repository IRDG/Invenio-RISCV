--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity BlockOr is
port(
		--Entradas
		
			A: 			in std_logic_vector(31 downto 0);
			--Señal de primera entrada del OR
			
			B: 			in std_logic_vector(31 downto 0);
			--Señal de segunda entrada del OR
			
		--Salidas
			Result:		out std_logic_vector(31 downto 0)

		
	  );
end entity BlockOr;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture BlockOrArch of BlockOr is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--



--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

Generator: FOR I IN 0 TO 31 GENERATE
	
	Result(i) <= A(i) OR B(i);
	
END GENERATE Generator;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.BlockOr
--PORT MAP	  (A        => SLV,
--				B        => SLV,
--				Result   => SLV
--			  );
--******************************************************--

End  BlockOrArch;
