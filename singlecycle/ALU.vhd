library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ALU is
    generic (
        addrWIDTH : INTEGER := 5;
       	dataWIDTH : INTEGER := 32;
        dmemLENGTH : INTEGER := 65536
    );
    port (
        ALUControl : in std_logic_vector(2 downto 0);
        srcA : in std_logic_vector(dataWIDTH - 1 downto 0);
        srcB : in std_logic_vector(dataWIDTH - 1 downto 0);
        zeroFlag : out std_logic;
        ALUResult : out std_logic_vector(dataWIDTH - 1 downto 0)
    );
end ALU;

architecture Behavioral of ALU is
    
    signal adderResult : std_logic_vector(dataWIDTH - 1 downto 0);

    
begin

    zeroFlag <= '1' when adderResult = X"00000000" else '0';
    
    adder : entity work.adder
    port map (
        a => srcA,
        b => srcB,
        y => adderResult
    );
    
    process(ALUControl, adderResult)
    begin
        case ALUControl is
            when "000" => --add
                ALUResult <= adderResult;
            when "001" => --subtract
                ALUResult <= (others => '0');
            when "010" => --and
                ALUResult <= (others => '0');
            when "011" => --or
                ALUResult <= (others => '0');
            when others => 
                ALUResult <= (others => '0');
        end case;
    end process;

end Behavioral;
