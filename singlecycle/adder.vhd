LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.NUMERIC_STD.ALL ;

entity adder is
    generic(
        dInWIDTH : INTEGER := 32;
        dOutWIDTH : INTEGER := 32
    );

    port (
        a, b : in STD_LOGIC_VECTOR(dInWIDTH - 1 downto 0);
        y : out STD_LOGIC_VECTOR(dOutWIDTH - 1 downto 0)
    );
end;

architecture Behavioral of adder is
begin
    y <= STD_LOGIC_VECTOR(UNSIGNED(a) + UNSIGNED(b));
end Behavioral;    
