----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    TopDesign - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopDesign is
    Port (
           sw       : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           topselDispA : out  STD_LOGIC;
           topselDispB : out  STD_LOGIC;
           topselDispC : out  STD_LOGIC;
           topselDispD : out  STD_LOGIC;
           topsegA : out  STD_LOGIC;
           topsegB : out  STD_LOGIC;
           topsegC : out  STD_LOGIC;
           topsegD : out  STD_LOGIC;
           topsegE : out  STD_LOGIC;
           topsegF : out  STD_LOGIC;
           topsegG : out  STD_LOGIC;
           JB      : out STD_LOGIC_VECTOR (1 downto 0):=(others => '0'); -- JA(0) 4 fps JA(1) 5 fps
           led     : out STD_LOGIC_VECTOR (5 downto 4)                   -- led4 - 4fps led 5 - 5fps
             
           );
end TopDesign;

architecture Behavioral of TopDesign is
component segmentdriver 
	Port( 
			display_A : in STD_LOGIC_VECTOR  (3 downto 0);
			display_B : in STD_LOGIC_VECTOR  (3 downto 0);
			display_C : in STD_LOGIC_VECTOR  (3 downto 0);
			display_D : in STD_LOGIC_VECTOR  (3 downto 0);
			segA : out STD_LOGIC;
			segB : out STD_LOGIC;
			segC : out STD_LOGIC;
			segD : out STD_LOGIC;
			segE : out STD_LOGIC;
			segF : out STD_LOGIC;
			segG : out STD_LOGIC;
			select_Display_A : out STD_LOGIC; 
			select_Display_B : out STD_LOGIC; 
			select_Display_C : out STD_LOGIC; 
			select_Display_D : out STD_LOGIC;
			clk : in STD_LOGIC
		);
		
		
		
		
end component;
component ClockScale
    generic(
        prescaler : natural := 12500000 -- 12,500,000 in binary
    );
    
    port(
        clock       : in STD_LOGIC; -- 100 Mhz input
        Cam_sync    : out STD_LOGIC -- 200 ms output 
    );
end component;
SIGNAL Ai : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Bi : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Ci : STD_LOGIC_VECTOR(3 downto 0);
SIGNAL Di : STD_LOGIC_VECTOR(3 downto 0);
signal sync200ms : std_logic := '0';
signal sync250ms : std_logic := '0';
signal sync40ms : std_logic := '0';
signal fps5: STD_LOGIC_VECTOR(3 downto 0);
signal out_1 : std_logic := '0';
begin

uut2: segmentDriver PORT MAP(
			display_A => Ai,
			display_B => Bi,
			display_C => Ci,
			display_D => Di,
			segA => topsegA,
			segB => topsegB,
			segC => topsegC,
			segD => topsegD,
			segE => topsegE,
			segF => topsegF,
			segG => topsegG,
			select_Display_A => topselDispA,
			select_Display_B => topselDispB,
			select_Display_C => topselDispC,
			select_Display_D => topselDispD,
			clk => clk
		);

         Ai(0) <= sw(0);
         Ai(1) <= sw(1);
         Ai(2) <= sw(2);
         Ai(3) <= sw(3);		
    
         Bi(0) <= sw(4);
         Bi(1) <= sw(5);
         Bi(2) <= sw(6);
         Bi(3) <= sw(7);
            
         Ci(0) <= sw(8);
         Ci(1) <= sw(9);
         Ci(2) <= sw(10);
         Ci(3) <= sw(11);
         
         Di(0) <= sw(12);
         Di(1) <= sw(13);
         Di(2) <= sw(14);
         Di(3) <= sw(15);
         
--100 000 000 / 4fps  /2 = 12 500 000 = 1011 1110 1011 1100 0010 0000 
--100 000 000 / 5fps  /2 = 10 000 000 = 1001 1000 1001 0110 1000 0000     
--100 000 000 / 20fps /2 =  2 500 000 = 0010 0110 0010 0101 1010 0000?        
U1: ClockScale
    generic map(
        prescaler => 12500000 -- 4fps
    )
    port map (
        clock   => clk,
        Cam_sync    => sync250ms
    );
    
--    JA(0) <= sync250ms;
--    led(4) <= sync250ms;
U2: ClockScale
    generic map(
        prescaler => 10000000 -- 5fps
    )
    port map (
        clock   => clk,
        Cam_sync    => sync200ms
    );
U3: ClockScale
    generic map(
        prescaler => 2500000 -- 20fps
    )
    port map (
        clock   => clk,
        Cam_sync    => sync40ms
    );
--    JA(1) <= sync200ms;
    
--    led(5) <= sync200ms;
U4: process(sw)
    begin
        case sw(4 downto 0) is
			when "00100" => --4 fps
                JB(0) <= sync250ms;
                led(4) <= sync250ms;
                JB(1) <= sync250ms;
                led(5) <= sync250ms;                
			when "00101" => --5 fps
			    JB(0) <= sync200ms;
                led(4) <= sync200ms;
                JB(1) <= sync200ms;
                led(5) <= sync200ms; 
			when "10100" => --20 fps
			    JB(0) <= sync40ms;
                led(4) <= sync40ms;
                JB(1) <= sync40ms;
                led(5) <= sync40ms;
			when others => 
			    JB(0) <= '0';
                led(4) <= '0';
                JB(1) <= '0';
                led(5) <= '0'; 
		end case;
    end process;
end Behavioral;
