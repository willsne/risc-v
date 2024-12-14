library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
        dmemLENGTH : INTEGER := 65536
    );
    port (
        ALUControl : in std_logic_vector(2 downto 0);
        srcA : in std_logic_vector(dataWIDTH - 1 downto 0);
        srcB : in std_logic_vector(dataWIDTH - 1 downto 0);
        zeroFlag : out std_logic;
        ALUResult : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end ALU;

architecture Behavioral of ALU is

    signal adderResult : std_logic_vector(dataWIDTH - 1 downto 0);

begin

    adder : entity work.adder
        port map (srcA, srcB, adderResult);

    process(ALUControl)
    begin
        case ALUControl is
            when '000' => --add
                ALUResult <= adderResult;
            when '001' => --subtract
                ALUResult <= adderResult;
            when '010' => --and
                ALUResult <= adderResult;
            when '011' => --or
                ALUResult <= adderResult;
            when others => 
                ALUResult <= (others => '0'); -- Set ALUResult to all 0s
        end case;
    end process;

end Behavioral;
