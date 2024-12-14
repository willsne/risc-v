library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datamemory is
    generic (
        addrWIDTH : INTEGER := 16
       	dataWIDTH : INTEGER := 32
        dmemLENGTH : INTEGER := 65536
    );
    port (
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in std_logic_vector(addrWIDTH - 1 downto 0);
        wd : in std_logic_vector(dataWIDTH - 1 downto 0);
        rd : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end datamemory;

architecture Behavioral of datamemory is

	type mem_array is array (0 to dmemLENGTH - 1) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal dataMem : mem_array := (others => (others => '0'));

begin

    process(rst_l, we)
    begin
        if rst_l = '0' then
            dataMem <= (others => (others => '0'));
        elsif we = '1' then
            dataMem(addr) <= wd;
        else
            rd <= dataMem(addr);
        end if;
    end process; 

end Behavioral;
