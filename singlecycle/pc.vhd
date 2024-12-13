library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
        pcSrc : in std_logic;
        pcTarget : in unsigned(dataWIDTH - 1 downto 0);
        pcNext : out unsigned(dataWIDTH - 1 downto 0);
    );
end pc;

architecture Behavioral of pc is

  /*  signal pcPlus4 : std_logic_vector(dataWIDTH - 1 downto 0);
    signal pc : std_logic_vector(dataWIDTH - 1 downto 0) := (others => '0'); */
    signal pc      : unsigned(dataWIDTH - 1 downto 0); -- Declare as unsigned
    signal pcPlus4 : unsigned(dataWIDTH - 1 downto 0);

begin


    ---internal signals
    pcPlus4 <= pc + 4;

    process(clk, rst_l)
    begin
        if rising_edge(clk) then
            if rst_l = '0' then
                pcNext <= (others => '0');
            else
                case pcSrc is
                    when '0'
                        pc <= pcPlus4;
                    when '1'
                        pc <= pcTarget;
                    when others =>
                        pc <= (others => '0'); -- Optional default case
                end case;
            end if;
        end if;
    end process; 

    ---output
    pcNext <= pc;

end Behavioral;
