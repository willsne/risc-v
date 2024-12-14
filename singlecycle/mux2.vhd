library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux2 is
    generic(
        dataWIDTH : integer := 32);
        
    port(
        d0, d1: in STD_LOGIC_VECTOR(dataWIDTH − 1 downto 0);
        s: in STD_LOGIC;
        y: out STD_LOGIC_VECTOR(dataWIDTH−1 downto 0));
end;

architecture behave of mux2 is
begin
    y <= d1 when s = '1' else d0;
end;
