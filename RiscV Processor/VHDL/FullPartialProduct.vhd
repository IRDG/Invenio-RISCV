--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity FullPartialProduct is
port(
		--Entradas
		
			Multiplicand:	in std_logic_vector(31 downto 0);
			
			--Señales del multiplicando, el 0 es el lsb y 1 el msb
			
			S:						in	std_logic;
			-- Señal S para el signo del producto parcial
				
			Select_M:			in	std_logic;
			--Señal que selecciona si el multiplicando se multiplica por uno
			
			Select_2M: 			in	std_logic;
			--Señal que selecciona si el multiplicando se multiplica por dos
		--Salidas
		
			PartialProduct32Bits:	out std_logic_vector(32 downto 0)
		
	  );
end entity FullPartialProduct;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture FullPartialProductArch of FullPartialProduct is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

component SinglePartialProduct is
port(MultiplicandLSB,MultiplicandMSB,S,Select_M,Select_2M: 		in	 std_logic;
			PartialProduct:				out std_logic
		
	  );
end component;


signal PartialOut: std_logic_vector(32 downto 0);

--******************************************************--
--Instancias y Conectividad
--******************************************************
begin
	BPP0 : SinglePartialProduct port map(Multiplicand(0 ),Multiplicand(0 ),S,Select_M ,Select_M ,PartialOut(0 ));
	BPP1 : SinglePartialProduct port map(Multiplicand(0 ),Multiplicand(1 ),S,Select_M ,Select_2M,PartialOut(1 ));
	BPP2 : SinglePartialProduct port map(Multiplicand(1 ),Multiplicand(2 ),S,Select_M ,Select_2M,PartialOut(2 ));
	BPP3 : SinglePartialProduct port map(Multiplicand(2 ),Multiplicand(3 ),S,Select_M ,Select_2M,PartialOut(3 ));
	BPP4 : SinglePartialProduct port map(Multiplicand(3 ),Multiplicand(4 ),S,Select_M ,Select_2M,PartialOut(4 ));
	BPP5 : SinglePartialProduct port map(Multiplicand(4 ),Multiplicand(5 ),S,Select_M ,Select_2M,PartialOut(5 ));
	BPP6 : SinglePartialProduct port map(Multiplicand(5 ),Multiplicand(6 ),S,Select_M ,Select_2M,PartialOut(6 ));
	BPP7 : SinglePartialProduct port map(Multiplicand(6 ),Multiplicand(7 ),S,Select_M ,Select_2M,PartialOut(7 ));
	BPP8 : SinglePartialProduct port map(Multiplicand(7 ),Multiplicand(8 ),S,Select_M ,Select_2M,PartialOut(8 ));
	BPP9 : SinglePartialProduct port map(Multiplicand(8 ),Multiplicand(9 ),S,Select_M ,Select_2M,PartialOut(9 ));
	BPP10: SinglePartialProduct port map(Multiplicand(9 ),Multiplicand(10),S,Select_M ,Select_2M,PartialOut(10));
	BPP11: SinglePartialProduct port map(Multiplicand(10),Multiplicand(11),S,Select_M ,Select_2M,PartialOut(11));
	BPP12: SinglePartialProduct port map(Multiplicand(11),Multiplicand(12),S,Select_M ,Select_2M,PartialOut(12));
	BPP13: SinglePartialProduct port map(Multiplicand(12),Multiplicand(13),S,Select_M ,Select_2M,PartialOut(13));
	BPP14: SinglePartialProduct port map(Multiplicand(13),Multiplicand(14),S,Select_M ,Select_2M,PartialOut(14));
	BPP15: SinglePartialProduct port map(Multiplicand(14),Multiplicand(15),S,Select_M ,Select_2M,PartialOut(15));
	BPP16: SinglePartialProduct port map(Multiplicand(15),Multiplicand(16),S,Select_M ,Select_2M,PartialOut(16));
	BPP17: SinglePartialProduct port map(Multiplicand(16),Multiplicand(17),S,Select_M ,Select_2M,PartialOut(17));
	BPP18: SinglePartialProduct port map(Multiplicand(17),Multiplicand(18),S,Select_M ,Select_2M,PartialOut(18));
	BPP19: SinglePartialProduct port map(Multiplicand(18),Multiplicand(19),S,Select_M ,Select_2M,PartialOut(19));
	BPP20: SinglePartialProduct port map(Multiplicand(19),Multiplicand(20),S,Select_M ,Select_2M,PartialOut(20));
	BPP21: SinglePartialProduct port map(Multiplicand(20),Multiplicand(21),S,Select_M ,Select_2M,PartialOut(21));
	BPP22: SinglePartialProduct port map(Multiplicand(21),Multiplicand(22),S,Select_M ,Select_2M,PartialOut(22));
	BPP23: SinglePartialProduct port map(Multiplicand(22),Multiplicand(23),S,Select_M ,Select_2M,PartialOut(23));
	BPP24: SinglePartialProduct port map(Multiplicand(23),Multiplicand(24),S,Select_M ,Select_2M,PartialOut(24));
	BPP25: SinglePartialProduct port map(Multiplicand(24),Multiplicand(25),S,Select_M ,Select_2M,PartialOut(25));
	BPP26: SinglePartialProduct port map(Multiplicand(25),Multiplicand(26),S,Select_M ,Select_2M,PartialOut(26));
	BPP27: SinglePartialProduct port map(Multiplicand(26),Multiplicand(27),S,Select_M ,Select_2M,PartialOut(27));
	BPP28: SinglePartialProduct port map(Multiplicand(27),Multiplicand(28),S,Select_M ,Select_2M,PartialOut(28));
	BPP29: SinglePartialProduct port map(Multiplicand(28),Multiplicand(29),S,Select_M ,Select_2M,PartialOut(29));
	BPP30: SinglePartialProduct port map(Multiplicand(29),Multiplicand(30),S,Select_M ,Select_2M,PartialOut(30));
	BPP31: SinglePartialProduct port map(Multiplicand(30),Multiplicand(31),S,Select_M ,Select_2M,PartialOut(31)); 
	BPP32: SinglePartialProduct port map(Multiplicand(31),Multiplicand(31),S,Select_2M,Select_2M,PartialOut(32));

	PartialProduct32Bits<=PartialOut;
End  FullPartialProductArch;


