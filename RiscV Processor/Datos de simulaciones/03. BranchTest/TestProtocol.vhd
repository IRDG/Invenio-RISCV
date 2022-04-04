--******************************************************--
--        PONTIFICIA UNIVERSIDAD JAVERIANA              --
--                Disegno Digital                       --
--          Seccion de Tecnicas Digitales               --
-- 													              --
-- Titulo :    TestBenchModule                          --
-- Fecha  :  	D:XX M:XX Y:20XX                         --
--******************************************************--

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

USE WORK.OutputControlPackage.ALL;

ENTITY TestProtocol IS
END TestProtocol;

ARCHITECTURE TestProtocolArch OF TestProtocol IS

--******************************************************--
-- Segnales a evaluar, las mismas definidas en el Work del bloque a evaluar
--******************************************************--

SIGNAL PeripheralPort   : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
SIGNAL Reset            : STD_LOGIC                    := '1';
SIGNAL Clk              : STD_LOGIC                    := '1';
SIGNAL PeripheralStatus : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL SpySignal        : Spy;

BEGIN

BranchTest: ENTITY WORK.SoC 
PORT MAP	  (PeripheralPort   => PeripheralPort,
				Reset            => Reset,
				Clk              => Clk,
				PeripheralStatus => PeripheralStatus,
				SpySignal        => SpySignal
			  );

Clk            <= NOT Clk AFTER 10 ns;

Reset          <= '0'     AFTER 20 ns;

PeripheralPort <= "0000"  AFTER 20 ns,
						"0000"  AFTER 40 ns;

END TestProtocolArch;
