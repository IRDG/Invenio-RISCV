--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity CRAAdder32 is
port(
		--Entradas
		
			A: 			in std_logic_vector(31 downto 0);
			--Señal de primera entrada del sumador
			
			B: 			in std_logic_vector(31 downto 0);
			--Señal de segunda entrada del sumador
			
			CarryIn: 	in	std_logic;
			--Señal carry entrada
			
		--Salidas
			Result:		out std_logic_vector(31 downto 0);
			Carryout: 	out std_logic

		
	  );
end entity CRAAdder32;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture CRAAdder32Arch of CRAAdder32 is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

signal Carry: std_logic_vector(32 downto 0);

--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

Carry(0) <= CarryIn;

CarryGenerator: FOR I IN 0 TO 31 GENERATE
	
		Result(I  )		<=  A(I) XOR B(I) XOR Carry(I);
		Carry (I+1) 	<= (A(I) AND B(I)) OR (Carry(I) AND (A(I) XOR B(I)) );
	
END GENERATE CarryGenerator;

CarryOut <=Carry(32);

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.CRAAdder32
--PORT MAP	  (A        => SLV,
--				B        => SLV,
--				CarryIn  => SLV,
--				Result   => SLV,
--				CarryOut => SLV
--			  );
--******************************************************--

End  CRAAdder32Arch;
