library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Use numeric_std for arithmetic

entity datamemory is
    generic (
        addrWIDTH : INTEGER := 16;
       	dataWIDTH : INTEGER := 32;
        dmemLENGTH : INTEGER := 256
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in std_logic_vector(addrWIDTH - 1 downto 0);
        wd : in std_logic_vector(dataWIDTH - 1 downto 0);
        rd : out std_logic_vector(dataWIDTH - 1 downto 0)
    );
end datamemory;

architecture Behavioral of datamemory is

	type mem_array is array (0 to dmemLENGTH - 1) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal dataMem : mem_array := (others => (others => '0'));

begin

    rd <= dataMem(to_integer(unsigned(addr)));

    process(clk, rst_l)
    begin
        if rising_edge(clk) then
            if we = '1' then
                dataMem(to_integer(unsigned(addr))) <= wd;
            end if;
        end if;
    end process; 

end Behavioral;
