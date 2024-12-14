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
        immExt : out std_logic_vector(dataWIDTH - 1 downto 0); --
    );
end immextender;

architecture Behavioral of iextender is

begin
    process(immSrc)
        case immSrc is
            when '00' => --I
                if extType = '0' then
                    immExt <= (others => instr(31)) & instr(31:20); 
                elsif extType = '1' then
                    immExt <= (others => '0') & instr(31:20);
                end if;
            when '01' => --S
                immExt <= (others => instr(31)) & instr(31:25) & instr(11:7);
            when '10' => --B
                immExt <= (others => instr(31)) & instr(7) & instr(30:25) & instr(11:8) & instr(11:8) & '0';
            when '11' => --J
                immExt <= (others => instr(31)) & instr(19:12) & instr(20) & instr(30:21) & '0';
        end case;
end process; 

end Behavioral;