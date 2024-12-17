library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity programcounter is
    generic (
       	dataWIDTH : INTEGER := 32;
       	instrAddrWIDTH :  INTEGER := 16
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
        PCNext : in std_logic_vector(dataWIDTH - 1 downto 0);
        PC : out std_logic_vector(instrAddrWIDTH - 1 downto 0)
    );
end programcounter;

architecture Behavioral of programcounter is

begin
    ---increment pc 
    process(clk, rst_l)
    begin
        if rising_edge(clk) then
            if rst_l = '0' then
                PC <= (others => '0');
            else
                PC <= PCNext(15 downto 0);
            end if;
        end if;
    end process; 

end Behavioral;
