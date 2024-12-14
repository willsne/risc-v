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
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in unsigned(addrWIDTH - 1 downto 0);
        wd : out unsigned(dataWIDTH - 1 downto 0);
        rd : out unsigned(dataWIDTH - 1 downto 0);
    );
end ALU;

architecture Behavioral of ALU is


begin

    rd <= dataMem(addr);

    process(rst_l, we)
    begin
        if rst_l = '0' then
            dataMem <= (others => (others => '0'));
        elsif we = '1'
            dataMem(addr) <= wd;
        end if;
    end process; 

end Behavioral;
