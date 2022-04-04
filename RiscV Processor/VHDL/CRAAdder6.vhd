--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity CRAAdder6 is
port(
		--Entradas
		
			A: 			in std_logic_vector(5 downto 0);
			--Señal de primera entrada del sumador
			
			B: 			in std_logic_vector(5 downto 0);
			--Señal de segunda entrada del sumador
			
			CarryIn: 			in	std_logic;
			--Señal carry entrada
			
		--Salidas
			Result:		out std_logic_vector(5 downto 0);
			Carryout: 		out std_logic

		
	  );
end entity CRAAdder6;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture CRAAdder6Arch of CRAAdder6 is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

signal Carry: std_logic_vector(6 downto 0);

--******************************************************--
--Instancias y Conectividad
--******************************************************
begin
	Carry(0) <= CarryIn;
	
	
--	process (A,B,Carry)
--	begin
--	
--		for i in 0 to 5 loop
--			Result(i  )		<=  A(i) XOR B(i) XOR  Carry(i);
--			Carry (i+1) 	<= (A(i) AND B(i)) OR (Carry(i) AND (A(i) XOR B(i)) );
--		end loop;
--		
--	end process;
	
	CarryGenerator: FOR I IN 0 TO 5 GENERATE
	
		Result(i  )		<=  A(i) XOR B(i) XOR Carry(i);
		Carry (i+1) 	<= (A(i) AND B(i)) OR (Carry(i) AND (A(i) XOR B(i)) );
	
END GENERATE CarryGenerator;
	
	CarryOut <=Carry(6);

End  CRAAdder6Arch;


