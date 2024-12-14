library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux4 is
    generic(
        dataWIDTH : integer := 32);

    port(
        d0, d1, d2, d3: in STD_LOGIC_VECTOR(dataWIDTH − 1 downto 0);
        s: in STD_LOGIC_VECTOR(1 downto 0);
        y: out STD_LOGIC_VECTOR(width−1 downto 0));
end;

architecture Behavioral of mux4 is
begin
    process(d0, d1, d2, s) begin
        if (s = "00") then y <= d0;
        elsif (s = "01") then y <= d1;
        elsif (s = "10") then y <= d2;
        elsif (s = "11") then y <= d3;
        end if;
    end process;
end;