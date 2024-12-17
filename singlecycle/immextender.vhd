library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity immextender is
    generic (
       	dataWIDTH : INTEGER := 32
    );
    port (
        extType: in std_logic; --0, sign.
        immSrc : in std_logic_vector(1 downto 0);
        instr : in std_logic_vector(dataWIDTH - 1 downto 0);
        immExt : out std_logic_vector(dataWIDTH - 1 downto 0)
    );
end immextender;

architecture Behavioral of immextender is

begin
    process(immSrc, extType, instr)
    begin
        case immSrc is
            when "00" => -- I-type
                if extType = '0' then
                    immExt <= (31 downto 12 => instr(31)) & instr(31 downto 20); 
                else
                    immExt <= (31 downto 12 => '0') & instr(31 downto 20);
                end if;
            when "01" => -- S-type
                immExt <= (31 downto 12 => instr(31)) & instr(31 downto 25) & instr(11 downto 7);
            when "10" => -- B-type
                immExt <= (31 downto 12 => instr(31)) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
            when "11" => -- J-type
                immExt <= instr(31 downto 20) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0';
        end case;
    end process; 

end Behavioral;