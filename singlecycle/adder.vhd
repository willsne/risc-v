library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD_UNSIGNED.all;

entity adder is
    generic(
        dInWIDTH : INTEGER := 32
        dOutWIDTH : INTEGER := 32);

    port(a, b: in STD_LOGIC_VECTOR(dInWIDTH - 1 downto 0);
        y: out STD_LOGIC_VECTOR(dOutWIDTH - 1 downto 0));
end;

architecture behave of adder is

begin
    y <= a + b;
end;    