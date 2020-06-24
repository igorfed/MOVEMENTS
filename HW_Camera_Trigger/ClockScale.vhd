library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ClockScale is
    generic(
        prescaler : natural := 12500000
    );
    port(
        clock       : in STD_LOGIC;
        Cam_sync    : out STD_LOGIC
    );
end ClockScale;
architecture Behavioral of ClockScale is
    signal prescaler_fps5: STD_LOGIC_VECTOR(23 downto 0) := "100110001001011010000000";
    signal prescaler_counter: STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
    signal sync: std_logic := '0';
begin
    countClock1: process(clock)
    begin
        if rising_edge(clock) then
            prescaler_counter <= prescaler_counter + 1;
            if(prescaler_counter > prescaler) then
                sync <=not sync;
                prescaler_counter <= (others => '0');
            end if;
        end if;
    end process;
Cam_sync <= sync;
end Behavioral;
