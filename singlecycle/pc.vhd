library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc is
    generic (
       	dataWIDTH : INTEGER := 16
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
        PCNext : in std_logic_vector(dataWIDTH - 1 downto 0);
        PC : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end pc;

architecture Behavioral of pc is

begin
    ---increment pc 
    process(clk, rst_l)
    begin
        if rising_edge(clk) then
            if rst_l = '0' then
                PC <= (others => '0');
            else
                PC <= PCNext;
            end if;
        end if;
    end process; 

end Behavioral;
