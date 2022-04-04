--Definicion de las bibliotecas 
library IEEE; 
use IEEE.std_logic_1164.all;

--******************************************************--
-- DEFINICIÓN DE ENTIDAD                                --
--******************************************************--
     
entity Multiplier32Bits is
port(
		--Entradas
		
			Multiplicand:	in std_logic_vector(31 downto 0);
			--Señal del multiplicando, el 0 es el lsb y 31 el msb
			
			Multiplier:		in std_logic_vector(31 downto 0);
			--Señal del multiplicador, el 0 es el lsb y 31 el msb
		--Salidas
		
			Result:			out std_logic_vector(31 downto 0)
		
	  );
end entity Multiplier32Bits;


--******************************************************--
--DEFINICIÓN DE ARQUITECTURA                            --
--******************************************************--

architecture Multiplier32BitsArch of Multiplier32Bits is

--******************************************************--
--DEFINICIÓN DE COMPONENTES Y SEÑALES DE CONEXIÓN                                        
--******************************************************--

component FullPartialProduct is
port(Multiplicand:						in  std_logic_vector(31 downto 0);
		S,Select_M,Select_2M: 			in	 std_logic;
		PartialProduct32Bits:			out std_logic_vector(32 downto 0)
	  );
end component;

component CRAAdder32 is
port(A,B: 									in  std_logic_vector(31 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(31 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component CRAAdder30 is
port(A,B: 									in  std_logic_vector(29 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(29 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component CRAAdder26 is
port(A,B: 									in  std_logic_vector(25 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(25 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component CRAAdder22 is
port(A,B: 									in  std_logic_vector(21 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(21 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component CRAAdder18 is
port(A,B: 									in  std_logic_vector(17 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(17 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component CRAAdder14 is
port(A,B: 									in  std_logic_vector(13 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(13 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component CRAAdder10 is
port(A,B: 									in  std_logic_vector(9  downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(9  downto 0);
		Carryout: 							out std_logic	
	  );
end component;

component CRAAdder6 is
port(A,B: 									in  std_logic_vector(5 downto 0);
		CarryIn: 							in	 std_logic;
		Result:								out std_logic_vector(5 downto 0);
		Carryout: 							out std_logic
	  );
end component;

component BoothDecoder is
port(MultiplierIn:						in std_logic_vector(2 downto 0);
		S,NotS,Select_M,Select_2M: 	out	std_logic
	  );
end component;

	signal PartialOut: 	  std_logic_vector(32 downto 0);

	signal BoothDecoder0:   std_logic_vector(2  downto 0);
	signal BoothDecoder1:   std_logic_vector(2  downto 0);
	signal BoothDecoder2:   std_logic_vector(2  downto 0);
	signal BoothDecoder3:   std_logic_vector(2  downto 0);
	signal BoothDecoder4:   std_logic_vector(2  downto 0);
	signal BoothDecoder5:   std_logic_vector(2  downto 0);
	signal BoothDecoder6:   std_logic_vector(2  downto 0);
	signal BoothDecoder7:   std_logic_vector(2  downto 0);
	signal BoothDecoder8:   std_logic_vector(2  downto 0);
	signal BoothDecoder9:   std_logic_vector(2  downto 0);
	signal BoothDecoder10:  std_logic_vector(2  downto 0);
	signal BoothDecoder11:  std_logic_vector(2  downto 0);
	signal BoothDecoder12:  std_logic_vector(2  downto 0);
	signal BoothDecoder13:  std_logic_vector(2  downto 0);
	signal BoothDecoder14:  std_logic_vector(2  downto 0);
	signal BoothDecoder15:  std_logic_vector(2  downto 0);

	signal Saux:			   std_logic_vector(15 downto 0);
	signal NotSaux:		   std_logic_vector(15 downto 0);
	signal Select_Maux:	   std_logic_vector(15 downto 0);
	signal Select_2Maux:	   std_logic_vector(15 downto 0);

		--señal de salida de los productos parciales
	signal PartialProduct0:  std_logic_vector(32 downto 0);
	signal PartialProduct1:  std_logic_vector(32 downto 0);
	signal PartialProduct2:  std_logic_vector(32 downto 0);
	signal PartialProduct3:  std_logic_vector(32 downto 0);
	signal PartialProduct4:  std_logic_vector(32 downto 0);
	signal PartialProduct5:  std_logic_vector(32 downto 0);
	signal PartialProduct6:  std_logic_vector(32 downto 0);
	signal PartialProduct7:  std_logic_vector(32 downto 0);
	signal PartialProduct8:  std_logic_vector(32 downto 0);
	signal PartialProduct9:  std_logic_vector(32 downto 0);
	signal PartialProduct10: std_logic_vector(32 downto 0);
	signal PartialProduct11: std_logic_vector(32 downto 0);
	signal PartialProduct12: std_logic_vector(32 downto 0);
	signal PartialProduct13: std_logic_vector(32 downto 0);
	signal PartialProduct14: std_logic_vector(32 downto 0);
	signal PartialProduct15: std_logic_vector(32 downto 0);

		--señales adder32A.
	signal FirstAdder32A:   std_logic_vector(31 downto 0);
	signal SecondAdder32A:   std_logic_vector(31 downto 0);
	signal ResultAdder32A:   std_logic_vector(31 downto 0);
		--señales adder32B
	signal SecondAdder32B: 	 std_logic_vector(31 downto 0);
	signal ResultAdder32B: 	 std_logic_vector(31 downto 0);
		--señales adder32C
	signal SecondAdder32C: 	 std_logic_vector(31 downto 0);
	signal ResultAdder32C: 	 std_logic_vector(31 downto 0);
		--señales adder32D	
	signal SecondAdder32D: 	 std_logic_vector(31 downto 0);
	signal ResultAdder32D:   std_logic_vector(31 downto 0);
	
		--señales adder30
	signal FirstAdder30 :	 std_logic_vector(29 downto 0);	
	signal SecondAdder30:    std_logic_vector(29 downto 0);
	signal ResultAdder30:  	 std_logic_vector(29 downto 0);
	
		--señales adder26A
	signal FirstAdder26A : 	 std_logic_vector(25 downto 0);	
	signal SecondAdder26A: 	 std_logic_vector(25 downto 0);
	signal ResultAdder26A: 	 std_logic_vector(25 downto 0);
		--señales adder26B
	signal SecondAdder26B:	 std_logic_vector(25 downto 0);
	signal ResultAdder26B:	 std_logic_vector(25 downto 0);
	
		--señales adder22
	signal FirstAdder22 :	 std_logic_vector(21 downto 0);	
	signal SecondAdder22:	 std_logic_vector(21 downto 0);
	signal ResultAdder22:	 std_logic_vector(21 downto 0);
	
		--señales adder18A
	signal FirstAdder18A : 	 std_logic_vector(17 downto 0);	
	signal SecondAdder18A: 	 std_logic_vector(17 downto 0);
	signal ResultAdder18A: 	 std_logic_vector(17 downto 0);
		--señales adder18B
	signal SecondAdder18B: 	 std_logic_vector(17 downto 0);
	signal ResultAdder18B: 	 std_logic_vector(17 downto 0);
		--señales adder18C	
	signal SecondAdder18C: 	 std_logic_vector(17 downto 0);
	signal ResultAdder18C: 	 std_logic_vector(17 downto 0);
	
		--señales adder14
	signal FirstAdder14 :  	 std_logic_vector(13 downto 0);	
	signal SecondAdder14:  	 std_logic_vector(13 downto 0);
	signal ResultAdder14:  	 std_logic_vector(13 downto 0);
	
		--señales adder10
	signal FirstAdder10A : 	 std_logic_vector(9  downto 0);	
	signal SecondAdder10A: 	 std_logic_vector(9  downto 0);
	signal ResultAdder10A: 	 std_logic_vector(9  downto 0);
	--señales adder10B
	signal SecondAdder10B: 	 std_logic_vector(9  downto 0);
	signal ResultAdder10B: 	 std_logic_vector(9  downto 0);
	
		--señales adder6
	signal FirstAdder6 :   	 std_logic_vector(5  downto 0);	
	signal SecondAdder6:   	 std_logic_vector(5  downto 0);
	signal ResultAdder6:   	 std_logic_vector(5  downto 0);
	signal AuxCarry6	 :	  	 std_logic;
	
		--Señal donde se asignan los carry de salida de los adders
	signal CarryOut:		  	 std_logic_vector(14  downto 0);
--******************************************************--
--Instancias y Conectividad
--******************************************************
begin

	--Asignacion bits del multiplier a los decoders
	BoothDecoder0 ( 0)<= '0';
	BoothDecoder0 ( 1)<= Multiplier( 0);
	BoothDecoder0 ( 2)<= Multiplier( 1);
	
	BoothDecoder1 ( 0)<= Multiplier( 1);
	BoothDecoder1 ( 1)<= Multiplier( 2);
	BoothDecoder1 ( 2)<= Multiplier( 3);
	
	BoothDecoder2 ( 0)<= Multiplier( 3);
	BoothDecoder2 ( 1)<= Multiplier( 4);
	BoothDecoder2 ( 2)<= Multiplier( 5);
	
	BoothDecoder3 ( 0)<= Multiplier( 5);
	BoothDecoder3 ( 1)<= Multiplier( 6);
	BoothDecoder3 ( 2)<= Multiplier( 7);
		
	BoothDecoder4 ( 0)<= Multiplier( 7);
	BoothDecoder4 ( 1)<= Multiplier( 8);
	BoothDecoder4 ( 2)<= Multiplier( 9);
	
	BoothDecoder5 ( 0)<= Multiplier( 9);
	BoothDecoder5 ( 1)<= Multiplier(10);
	BoothDecoder5 ( 2)<= Multiplier(11);
		
	BoothDecoder6 ( 0)<= Multiplier(11);
	BoothDecoder6 ( 1)<= Multiplier(12);
	BoothDecoder6 ( 2)<= Multiplier(13);
		
	BoothDecoder7 ( 0)<= Multiplier(13);
	BoothDecoder7 ( 1)<= Multiplier(14);
	BoothDecoder7 ( 2)<= Multiplier(15);
		
	BoothDecoder8 ( 0)<= Multiplier(15);
	BoothDecoder8 ( 1)<= Multiplier(16);
	BoothDecoder8 ( 2)<= Multiplier(17);
		
	BoothDecoder9 ( 0)<= Multiplier(17);
	BoothDecoder9 ( 1)<= Multiplier(18);
	BoothDecoder9 ( 2)<= Multiplier(19);
		
	BoothDecoder10( 0)<= Multiplier(19);
	BoothDecoder10( 1)<= Multiplier(20);
	BoothDecoder10( 2)<= Multiplier(21);
		
	BoothDecoder11( 0)<= Multiplier(21);
	BoothDecoder11( 1)<= Multiplier(22);
	BoothDecoder11( 2)<= Multiplier(23);
		
	BoothDecoder12( 0)<= Multiplier(23);
	BoothDecoder12( 1)<= Multiplier(24);
	BoothDecoder12( 2)<= Multiplier(25);
		
	BoothDecoder13( 0)<= Multiplier(25);
	BoothDecoder13( 1)<= Multiplier(26);
	BoothDecoder13( 2)<= Multiplier(27);
	
	BoothDecoder14( 0)<= Multiplier(27);
	BoothDecoder14( 1)<= Multiplier(28);
	BoothDecoder14( 2)<= Multiplier(29);
	
	BoothDecoder15( 0)<= Multiplier(29);
	BoothDecoder15( 1)<= Multiplier(30);
	BoothDecoder15( 2)<= Multiplier(31);
	
	-- Incializando señales de los sumadores de productos parciales
	FirstAdder32A<=PartialProduct0(31 downto 0);
	SecondAdder32A(0)<=Saux(0 );
	SecondAdder32A(1)<='0' ;
	SecondAdder32A(31 downto 2)<=PartialProduct1(29 downto 0) ;
	
	FirstAdder30(0)<=Saux(1 );
	FirstAdder30(1)<='0' ;
	FirstAdder30(29 downto 2)<=PartialProduct2(27 downto 0) ;
	SecondAdder30(0)<='0' ;
	SecondAdder30(1)<='0' ;
	SecondAdder30(2)<=Saux(2 );
	SecondAdder30(3)<='0' ;
	SecondAdder30(29 downto 4)<=PartialProduct3(25 downto 0) ;
	
	FirstAdder26A(0)<=Saux(3 );
	FirstAdder26A(1)<='0' ;
	FirstAdder26A(25 downto 2)<=PartialProduct4(23 downto 0) ;
	SecondAdder26A(0)<='0' ;
	SecondAdder26A(1)<='0' ;
	SecondAdder26A(2)<=Saux(4 );
	SecondAdder26A(3)<='0' ;
	SecondAdder26A(25 downto 4)<=PartialProduct5(21 downto 0) ;
	
	FirstAdder22(0)<=Saux(5 );
	FirstAdder22(1)<='0' ;
	FirstAdder22(21 downto 2)<=PartialProduct6(19 downto 0) ;
	SecondAdder22(0)<='0' ;
	SecondAdder22(1)<='0' ;
	SecondAdder22(2)<=Saux(6 );
	SecondAdder22(3)<='0' ;
	SecondAdder22(21 downto 4)<=PartialProduct7(17 downto 0) ;
	
	FirstAdder18A(0)<=Saux(7 );
	FirstAdder18A(1)<='0' ;
	FirstAdder18A(17 downto 2)<=PartialProduct8(15 downto 0) ;
	SecondAdder18A(0)<='0' ;
	SecondAdder18A(1)<='0' ;
	SecondAdder18A(2)<=Saux(8 );
	SecondAdder18A(3)<='0' ;
	SecondAdder18A(17 downto 4)<=PartialProduct9(13 downto 0) ;
	
	FirstAdder14 (0)<=Saux(9 );
	FirstAdder14 (1)<='0' ;
	FirstAdder14 (13 downto 2)<=PartialProduct10(11 downto 0) ;
	SecondAdder14(0)<='0' ;
	SecondAdder14(1)<='0' ;
	SecondAdder14(2)<=Saux(10 );
	SecondAdder14(3)<='0' ;
	SecondAdder14(13 downto 4)<=PartialProduct11(9 downto 0) ;
	
	FirstAdder10A (0)<=Saux(11 );
	FirstAdder10A (1)<='0' ;
	FirstAdder10A (9 downto 2)<=PartialProduct12(7 downto 0) ;
	SecondAdder10A(0)<='0' ;
	SecondAdder10A(1)<='0' ;
	SecondAdder10A(2)<=Saux(12 );
	SecondAdder10A(3)<='0' ;
	SecondAdder10A(9 downto 4)<=PartialProduct13(5 downto 0) ;
	
	FirstAdder6 (0)<=Saux(13 );
	FirstAdder6 (1)<='0' ;
	FirstAdder6 (5 downto 2)<=PartialProduct14(3 downto 0) ;
	SecondAdder6(0)<='0' ;
	SecondAdder6(1)<='0' ;
	SecondAdder6(2)<=Saux(14 );
	SecondAdder6(3)<='0' ;
	SecondAdder6(3)<='0' ;
	SecondAdder6(4)<=	Saux(15) XOR PartialProduct15(0) XOR '0';
	AuxCarry6		<= (Saux(15) AND PartialProduct15(0)) OR ('0' AND (Saux(15) XOR PartialProduct15(0)) );
	SecondAdder6(5)<= '0' XOR PartialProduct15(1) XOR AuxCarry6;
	
	SecondAdder32B(0) <='0';
	SecondAdder32B(1) <='0';
	SecondAdder32B(31 downto 2 )<=ResultAdder30;
	
	SecondAdder32C(0) <='0';
	SecondAdder32C(1) <='0';
	SecondAdder32C(2) <='0';
	SecondAdder32C(3) <='0';
	SecondAdder32C(4) <='0';
	SecondAdder32C(5) <='0';
	SecondAdder32C(31 downto 6 )<=ResultAdder26B;

	SecondAdder32D(0 ) <='0';
	SecondAdder32D(1 ) <='0';
	SecondAdder32D(2 ) <='0';
	SecondAdder32D(3 ) <='0';
	SecondAdder32D(4 ) <='0';
	SecondAdder32D(5 ) <='0';
	SecondAdder32D(6 ) <='0';
	SecondAdder32D(7 ) <='0';
	SecondAdder32D(8 ) <='0';
	SecondAdder32D(9 ) <='0';
	SecondAdder32D(10) <='0';
	SecondAdder32D(11) <='0';
	SecondAdder32D(12) <='0';
	SecondAdder32D(13) <='0';
	SecondAdder32D(31 downto 14)<=ResultAdder18C;
	
	SecondAdder26B(0 ) <='0';
	SecondAdder26B(1 ) <='0';
	SecondAdder26B(2 ) <='0';
	SecondAdder26B(3 ) <='0';
	SecondAdder26B(25 downto 4 )<=ResultAdder22;
	
	SecondAdder18B(0 )<='0';
	SecondAdder18B(1 )<='0';
	SecondAdder18B(2 )<='0';
	SecondAdder18B(3 )<='0';
	SecondAdder18B(17 downto 4 )<=ResultAdder14;
	
	SecondAdder18C(0 )<='0';
	SecondAdder18C(1 )<='0';
	SecondAdder18C(2 )<='0';
	SecondAdder18C(3 )<='0';
	SecondAdder18C(4 )<='0';
	SecondAdder18C(5 )<='0';
	SecondAdder18C(6 )<='0';
	SecondAdder18C(7 )<='0';
	SecondAdder18C(17 downto 8 )<=ResultAdder10B;
	
	SecondAdder10B(0 )<='0';
	SecondAdder10B(1 )<='0';
	SecondAdder10B(2 )<='0';
	SecondAdder10B(3 )<='0';
	SecondAdder10B(9  downto 4 )<=ResultAdder6;
	
	--Declaracion de decoders de Booth
	BD0 : BoothDecoder port map(BoothDecoder0 ,Saux(0 ),NotSaux(0 ),Select_Maux(0 ),Select_2Maux(0 ));
	BD1 : BoothDecoder port map(BoothDecoder1 ,Saux(1 ),NotSaux(1 ),Select_Maux(1 ),Select_2Maux(1 ));
	BD2 : BoothDecoder port map(BoothDecoder2 ,Saux(2 ),NotSaux(2 ),Select_Maux(2 ),Select_2Maux(2 ));
	BD3 : BoothDecoder port map(BoothDecoder3 ,Saux(3 ),NotSaux(3 ),Select_Maux(3 ),Select_2Maux(3 ));
	BD4 : BoothDecoder port map(BoothDecoder4 ,Saux(4 ),NotSaux(4 ),Select_Maux(4 ),Select_2Maux(4 ));
	BD5 : BoothDecoder port map(BoothDecoder5 ,Saux(5 ),NotSaux(5 ),Select_Maux(5 ),Select_2Maux(5 ));
	BD6 : BoothDecoder port map(BoothDecoder6 ,Saux(6 ),NotSaux(6 ),Select_Maux(6 ),Select_2Maux(6 ));
	BD7 : BoothDecoder port map(BoothDecoder7 ,Saux(7 ),NotSaux(7 ),Select_Maux(7 ),Select_2Maux(7 ));
	BD8 : BoothDecoder port map(BoothDecoder8 ,Saux(8 ),NotSaux(8 ),Select_Maux(8 ),Select_2Maux(8 ));
	BD9 : BoothDecoder port map(BoothDecoder9 ,Saux(9 ),NotSaux(9 ),Select_Maux(9 ),Select_2Maux(9 ));
	BD10: BoothDecoder port map(BoothDecoder10,Saux(10),NotSaux(10),Select_Maux(10),Select_2Maux(10));
	BD11: BoothDecoder port map(BoothDecoder11,Saux(11),NotSaux(11),Select_Maux(11),Select_2Maux(11));
	BD12: BoothDecoder port map(BoothDecoder12,Saux(12),NotSaux(12),Select_Maux(12),Select_2Maux(12));
	BD13: BoothDecoder port map(BoothDecoder13,Saux(13),NotSaux(13),Select_Maux(13),Select_2Maux(13));
	BD14: BoothDecoder port map(BoothDecoder14,Saux(14),NotSaux(14),Select_Maux(14),Select_2Maux(14));
	BD15: BoothDecoder port map(BoothDecoder15,Saux(15),NotSaux(15),Select_Maux(15),Select_2Maux(15));
	
	--declaracion de productos de booth parciales
	FPP0 : FullPartialProduct port map(Multiplicand,Saux(0 ),Select_Maux(0 ),Select_2Maux(0 ),PartialProduct0 );
	FPP1 : FullPartialProduct port map(Multiplicand,Saux(1 ),Select_Maux(1 ),Select_2Maux(1 ),PartialProduct1 );
	FPP2 : FullPartialProduct port map(Multiplicand,Saux(2 ),Select_Maux(2 ),Select_2Maux(2 ),PartialProduct2 );
	FPP3 : FullPartialProduct port map(Multiplicand,Saux(3 ),Select_Maux(3 ),Select_2Maux(3 ),PartialProduct3 );
	FPP4 : FullPartialProduct port map(Multiplicand,Saux(4 ),Select_Maux(4 ),Select_2Maux(4 ),PartialProduct4 );
	FPP5 : FullPartialProduct port map(Multiplicand,Saux(5 ),Select_Maux(5 ),Select_2Maux(5 ),PartialProduct5 );
	FPP6 : FullPartialProduct port map(Multiplicand,Saux(6 ),Select_Maux(6 ),Select_2Maux(6 ),PartialProduct6 );
	FPP7 : FullPartialProduct port map(Multiplicand,Saux(7 ),Select_Maux(7 ),Select_2Maux(7 ),PartialProduct7 );
	FPP8 : FullPartialProduct port map(Multiplicand,Saux(8 ),Select_Maux(8 ),Select_2Maux(8 ),PartialProduct8 );
	FPP9 : FullPartialProduct port map(Multiplicand,Saux(9 ),Select_Maux(9 ),Select_2Maux(9 ),PartialProduct9 );
	FPP10: FullPartialProduct port map(Multiplicand,Saux(10),Select_Maux(10),Select_2Maux(10),PartialProduct10);
	FPP11: FullPartialProduct port map(Multiplicand,Saux(11),Select_Maux(11),Select_2Maux(11),PartialProduct11);
	FPP12: FullPartialProduct port map(Multiplicand,Saux(12),Select_Maux(12),Select_2Maux(12),PartialProduct12);
	FPP13: FullPartialProduct port map(Multiplicand,Saux(13),Select_Maux(13),Select_2Maux(13),PartialProduct13);
	FPP14: FullPartialProduct port map(Multiplicand,Saux(14),Select_Maux(14),Select_2Maux(14),PartialProduct14);
	FPP15: FullPartialProduct port map(Multiplicand,Saux(15),Select_Maux(15),Select_2Maux(15),PartialProduct15);
	
		--Sumador de primer y segundo producto parcial longitud 32
	Add32A: CRAAdder32 port map(FirstAdder32A,SecondAdder32A,'0',ResultAdder32A,CarryOut(0 ));

		--Sumador de tercer y cuarto producto parcial longitud 30
	Add30 : CRAAdder30 port map(FirstAdder30,	  SecondAdder30, '0',ResultAdder30, CarryOut(1 ));

		--Sumador de quinto y sexto producto parcial longitud 26
	Add26A: CRAAdder26 port map(FirstAdder26A,  SecondAdder26A,'0',ResultAdder26A,CarryOut(2 ));

		--Sumador de septimo y octavo producto parcial longitud 22
	Add22 : CRAAdder22 port map(FirstAdder22,	  SecondAdder22, '0',ResultAdder22, CarryOut(3 ));

		--Sumador de noveno y decimo producto parcial longitud 18
	Add18A: CRAAdder18 port map(FirstAdder18A,  SecondAdder18A,'0',ResultAdder18A,CarryOut(4 ));

		--Sumador de decimoprimero y decimosegundo producto parcial longitud 14
	Add14 : CRAAdder14 port map(FirstAdder14,	  SecondAdder14, '0',ResultAdder14, CarryOut(5 ));

		--Sumador de decimotercer y decimocuarto producto parcial longitud 10
	Add10A: CRAAdder10 port map(FirstAdder10A,  SecondAdder10A,'0',ResultAdder10A,CarryOut(6 ));

		--Sumador de decimoquinto y decimosexto producto parcial longitud 6, el decimoseptimo es solo un bit y se añade en la iniciacion de variables
	Add6  : CRAAdder6  port map(FirstAdder6 ,	  SecondAdder6 , '0',ResultAdder6 , CarryOut(7 ));

	--Sumador resultado 32A y 30
	Add32B: CRAAdder32 port map(ResultAdder32A, SecondAdder32B,'0',ResultAdder32B,CarryOut(8 ));
	
	--Sumador resultado 26A y 22
	Add26B: CRAAdder26 port map(ResultAdder26A, SecondAdder26B,'0',ResultAdder26B,CarryOut(9 ));
	
	--Sumador resultado 18A y 14
	Add18B: CRAAdder18 port map(ResultAdder18A, SecondAdder18B,'0',ResultAdder18B,CarryOut(10 ));
	
	--Sumador resultado 10A y 6
	Add10B: CRAAdder10 port map(ResultAdder10A, SecondAdder10B,'0',ResultAdder10B,CarryOut(11 ));
	
	--Sumador resultado 32B y 26B
	Add32C: CRAAdder32 port map(ResultAdder32B, SecondAdder32C,'0',ResultAdder32C,CarryOut(12 ));
	
	--Sumador resultado 18B y 10B
	Add18C: CRAAdder18 port map(ResultAdder18B, SecondAdder18C,'0',ResultAdder18C,CarryOut(13 ));
	
	--Sumador resultado 32C y 18C
	Add32D: CRAAdder32 port map(ResultAdder32C, SecondAdder32D,'0',ResultAdder32D,CarryOut(14 ));
	
	Result<=ResultAdder32D;

--BlockN: ENTITY WORK.Multiplier32Bits
--PORT MAP	  (Multiplicand => SLV,
--				Multiplier   => SLV,
--				Result       => SLV
--			  );

End  Multiplier32BitsArch;


