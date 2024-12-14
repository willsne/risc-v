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
        a1 : in std_logic_vector(addrWIDTH - 1 downto 0);
        a2 : in std_logic_vector(addrWIDTH - 1 downto 0);
        a3 : in std_logic_vector(addrWIDTH - 1 downto 0);
      	we3 : in std_logic;
        wd3 : in std_logic_vector(dataWIDTH - 1 downto 0);
        rd1 : out std_logic_vector(dataWIDTH - 1 downto 0);
        rd2 : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end regfile;

architecture Behavioral of regfile is

	type register_array is array (0 to 31) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal dataRegs : register_array := (others => (others => '0'));

begin
    process(clk, rst_l, we3)
    begin
        if rising_edge(clk) and rst_l = '0' then
                dataRegs <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if we3 = '1' then 
                dataRegs(a3) <= wd3;
            elsif we3 = '0' then
                rd1 <= dataregs(a1);
                rd2 <= dataregs(a2);
            end if;
        end if;
    end process; 

end Behavioral;
