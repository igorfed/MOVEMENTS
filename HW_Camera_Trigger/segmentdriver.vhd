----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    segmentdriver - Behavioral 
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

entity segmentdriver is
    Port ( display_A : in  STD_LOGIC_VECTOR (3 downto 0);
           display_B : in  STD_LOGIC_VECTOR (3 downto 0);
           display_C : in  STD_LOGIC_VECTOR (3 downto 0);
           display_D : in  STD_LOGIC_VECTOR (3 downto 0);
           segA : out  STD_LOGIC;
           segB : out  STD_LOGIC;
           segC : out  STD_LOGIC;
           segD : out  STD_LOGIC;
           segE : out  STD_LOGIC;
           segF : out  STD_LOGIC;
           segG : out  STD_LOGIC;
           select_Display_A : out  STD_LOGIC;
           select_Display_B : out  STD_LOGIC;
           select_Display_C : out  STD_LOGIC;
           select_Display_D : out  STD_LOGIC;
           clk : in  STD_LOGIC);
end segmentdriver;

architecture Behavioral of segmentdriver is
-- Component Declaration
          COMPONENT segmentDecoder
          PORT(
                  Digit : in std_logic_vector(3 downto 0);       
                  segment_A : out  STD_LOGIC;
						segment_B : out  STD_LOGIC;
						segment_C : out  STD_LOGIC;
						segment_D : out  STD_LOGIC;
						segment_E : out  STD_LOGIC;
						segment_F : out  STD_LOGIC;
						segment_G : out  STD_LOGIC
						);
          END COMPONENT;

			 COMPONENT clock_divider
			 PORT(
					clk : in STD_LOGIC; 
					enable : in STD_LOGIC;
					reset : in STD_LOGIC;
					data_clk : out STD_LOGIC_VECTOR (15 downto 0)
					);
			 END COMPONENT;
SIGNAL temperary_data : std_logic_vector(3 downto 0);
SIGNAL clock_word : std_logic_vector(15 downto 0);
SIGNAL slow_clock : std_logic;
		 
begin

-- Component Instantiation
          uut: segmentDecoder PORT MAP(
						
						Digit => temperary_data,
                        segment_A => segA,
						segment_B => segB,
						segment_C => segC,
						segment_D => segD,
						segment_E => segE,
						segment_F => segF,
						segment_G => segG
          );
 uut1: clock_divider PORT MAP(
						clk => clk,
						enable => '1',
						reset => '0',
						data_clk => clock_word
			 );
slow_clock <= clock_word(15);

PROCESS(slow_clock)

	variable  display_selection : STD_LOGIC_VECTOR(1 DOWNTO 0);
	BEGIN
	if slow_clock'event and slow_clock = '1' then	
	
	case display_selection is 
	
	 when "00" => temperary_data <= display_A;

			
			select_display_A <= '0';
			select_Display_B <= '1';
			select_Display_C <= '1';
			select_Display_D <= '1';
			
			display_selection := display_selection+'1';
	when "01" => temperary_data <= display_B;
		
			select_Display_A <= '1';
			select_Display_B <= '0';
			select_Display_C <= '1';
			select_Display_D <= '1';
			
			display_selection := display_selection+'1';
	when "10" => temperary_data <= display_C;
			select_Display_A <= '1';
			select_Display_B <= '1';
			select_Display_C <= '0';
			select_Display_D <= '1';
			display_selection := display_selection+'1';
	when others => temperary_data <= display_D;
			select_Display_A <= '1';
			select_Display_B <= '1';
			select_Display_C <= '1';
			select_Display_D <= '0';
			display_selection := display_selection+'1';
	end case;
 
end if;

	END PROCESS;

end Behavioral;

