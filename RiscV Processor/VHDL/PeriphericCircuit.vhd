
--******************************************************--
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disegno Digital                       --
--          Seccion de Tecnicas Digitales               --
-- 													              --
-- Titulo :                                             --
-- Fecha  :  	D:XX M:XX Y:20XX                         --
--******************************************************--

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;



--******************************************************--
-- Comentarios:
-- 
-- 
--******************************************************--

ENTITY PeriphericCircuit IS
	

	PORT	 (
				PeripheralPort   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				Ack              : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				Reset            : IN  STD_LOGIC;
				Clk              : IN  STD_LOGIC;
				PeripheralStatus : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				Irq              : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			 );
	
END ENTITY PeriphericCircuit;

ARCHITECTURE PeriphericCircuitArch OF PeriphericCircuit IS

TYPE   StateType IS (StandBy,Request);

SIGNAL NextState0 : StateType;
SIGNAL PrevState0 : StateType;
SIGNAL NextState1 : StateType;
SIGNAL PrevState1 : StateType;
SIGNAL NextState2 : StateType;
SIGNAL PrevState2 : StateType;
SIGNAL NextState3 : StateType;
SIGNAL PrevState3 : StateType;

BEGIN

--******************************************************--
-- 
-- 
-- 
--******************************************************--

StateMemory: PROCESS (Reset, Clk)
BEGIN
	
	IF (Reset = '1')THEN
		
		PrevState0 <= Standby;
		PrevState1 <= Standby;
		PrevState2 <= Standby;
		PrevState3 <= Standby;
		
	ELSIF (RISING_EDGE(Clk))THEN
		
		PrevState0 <= NextState0;
		PrevState1 <= NextState1;
		PrevState2 <= NextState2;
		PrevState3 <= NextState3;
		
	END IF;
	
END PROCESS StateMemory;

StateChange: PROCESS (PrevState0,PrevState1,PrevState2,PrevState3,PeripheralPort,Ack)
BEGIN
	
	CASE PrevState0 IS
	----------------------------------------------------------
		WHEN Standby =>
			
			Irq(0)              <= '0';
			PeripheralStatus(0) <= '0';
			
			IF (PeripheralPort(0) = '1')THEN
				
				NextState0 <= Request;
				
			ELSE
				
				NextState0 <= Standby;
				
			END IF;
	----------------------------------------------------------
		WHEN Request =>
			
			Irq(0)              <= '1';
			PeripheralStatus(0) <= '1';
			
			IF (Ack(0) = '1')THEN
				
				NextState0 <= Standby;
				
			ELSE
				
				NextState0 <= Request;
				
			END IF;
	----------------------------------------------------------
	END CASE;
	
	CASE PrevState1 IS
	----------------------------------------------------------
		WHEN Standby =>
			
			Irq(1)              <= '0';
			PeripheralStatus(1) <= '0';
			
			IF (PeripheralPort(1) = '1')THEN
				
				NextState1 <= Request;
				
			ELSE
				
				NextState1 <= Standby;
				
			END IF;
	----------------------------------------------------------
		WHEN Request =>
			
			Irq(1)              <= '1';
			PeripheralStatus(1) <= '1';
			
			IF (Ack(1) = '1')THEN
				
				NextState1 <= Standby;
				
			ELSE
				
				NextState1 <= Request;
				
			END IF;
	----------------------------------------------------------
	END CASE;
	
	CASE PrevState2 IS
	----------------------------------------------------------
		WHEN Standby =>
			
			Irq(2)              <= '0';
			PeripheralStatus(2) <= '0';
			
			IF (PeripheralPort(2) = '1')THEN
				
				NextState2 <= Request;
				
			ELSE
				
				NextState2 <= Standby;
				
			END IF;
	----------------------------------------------------------
		WHEN Request =>
			
			Irq(2)              <= '1';
			PeripheralStatus(2) <= '1';
			
			IF (Ack(2) = '1')THEN
				
				NextState2 <= Standby;
				
			ELSE
				
				NextState2 <= Request;
				
			END IF;
	----------------------------------------------------------
	END CASE;
	
	CASE PrevState3 IS
	----------------------------------------------------------
		WHEN Standby =>
			
			Irq(3)              <= '0';
			PeripheralStatus(3) <= '0';
			
			IF (PeripheralPort(3) = '1')THEN
				
				NextState3 <= Request;
				
			ELSE
				
				NextState3 <= Standby;
				
			END IF;
	----------------------------------------------------------
		WHEN Request =>
			
			Irq(3)              <= '1';
			PeripheralStatus(3) <= '1';
			
			IF (Ack(3) = '1')THEN
				
				NextState3 <= Standby;
				
			ELSE
				
				NextState3 <= Request;
				
			END IF;
	----------------------------------------------------------
	END CASE;
	
END PROCESS StateChange;

--******************************************************--
-- 
-- Summon This Block:
-- 
--******************************************************--
--BlockN: ENTITY WORK.PeriphericCircuit 
--PORT MAP	  (PeripheralPort   => SLV,
--				Ack              => SLV,
--				Reset            => SLV,
--				Clk              => SLV,
--				PeripheralStatus => SLV,
--				Irq              => SLV
--			  );
--******************************************************--

END PeriphericCircuitArch;