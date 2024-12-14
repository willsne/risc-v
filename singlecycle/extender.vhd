library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity immExt is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
    );
    port (
        rst_l    : in std_logic;
        immSrc : in std_logic_vector(1 downto 0);
        instr : in std_logic_vector(dataWIDTH - 1 downto 0);
        immExt : out std_logic_vector(dataWIDTH - 1 downto 0)
    );
end immExt;

architecture Behavioral of immExt is

begin
    ---internal signals
    immExtPlus4 <= immExt + 4;

    ---increment immExt 
    process(rst_l)
    begin
        if rst_l = '0' then
            immExtNext <= (others => '0');
        else
            case immSrc is
                when '00' => --I
                    immExt <= (others => instr(31)) & instr(31:20); 
                when '01' => --S
                    immExt <= (others => instr(31)) & instr(31:25) & instr(11:7);
                when '10' => --B
                    immExt <= (others => instr(31)) & instr(7) & instr(30:25) & instr(11:8) & instr(11:8) & '0';
                when '11' => --J
                    immExt <= (others => instr(31)) & instr(19:12) & instr(20) & instr(30:21) & '0';
            end case;
        end if;
end process; 

end Behavioral;