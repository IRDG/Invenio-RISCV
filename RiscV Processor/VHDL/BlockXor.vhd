--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity BlockXor is
port(
		--Entradas
		
			A: 			in std_logic_vector(31 downto 0);
			--Señal de primera entrada del XOR
			
			B: 			in std_logic_vector(31 downto 0);
			--Señal de segunda entrada del XOR
			
		--Salidas
			Result:		out std_logic_vector(31 downto 0)

		
	  );
end entity BlockXor;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture BlockXorArch of BlockXor is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--



--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

Generator: FOR I IN 0 TO 31 GENERATE
	
	Result(i) <= A(i) XOR B(i);
	
END GENERATE Generator;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.BlockXor
--PORT MAP	  (A        => SLV,
--				B        => SLV,
--				Result   => SLV
--			  );
--******************************************************--

End  BlockXorArch;
