----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2020 10:11:57 AM
-- Design Name: 
-- Module Name: TopDesign_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopDesign_tb is
--  Port ( );
end TopDesign_tb;

architecture Behavioral of TopDesign_tb is

component fa
   
    port(
        a       : in STD_LOGIC;
        b    : out STD_LOGIC
    );
end component;
signal clk: std_logic;
signal C : std_logic;

begin



U0: process      
begin
        clk <= '0';
        wait for 10 ns; 
        clk <= '1';
        wait for 10 ns; 
end process; 

U1: ClockScale
    generic map(
        prescaler => 12500000
    )
    port map(
        clock       => clk,
        Cam_sync    => C
    );
   



end Behavioral;
