library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Use numeric_std for arithmetic

entity regfile is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
        a1 : in unsigned(addrWIDTH - 1 downto 0);
        a2 : in unsigned(addrWIDTH - 1 downto 0);
        a3 : in unsigned(addrWIDTH - 1 downto 0);
      	we3 : in std_logic;
        wd3 : in unsigned(dataWIDTH - 1 downto 0);
        rd1 : out unsigned(dataWIDTH - 1 downto 0);
        rd2 : out unsigned(dataWIDTH - 1 downto 0);
    );
end regfile;

architecture Behavioral of regfile is

	type register_array is array (0 to 31) of unsigned(dataWIDTH - 1 downto 0);
	signal dataRegs : register_array := (others => (others => '0'));

begin

    rd1 <= dataRegs(a1);
    rd2 <= dataRegs(a2);

    process(clk, rst_l, we3)
    begin
        if rising_edge(clk) then
            if rst_l = '0'
                dataRegs <= (others => (others => '0'));
            elsif we3 = '1'
                dataRegs(a3) <= wd3;
            end if;
        end if;
    end process; 

end Behavioral;
