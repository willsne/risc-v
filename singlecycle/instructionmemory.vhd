library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instructionmemory is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
        imemLENGTH : INTEGER := 65536
    );
    port (
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in unsigned(addrWIDTH - 1 downto 0);
        wd : out unsigned(dataWIDTH - 1 downto 0);
        rd : out unsigned(dataWIDTH - 1 downto 0);
    );
end instructionmemory;

architecture Behavioral of instructionmemory is

	type mem_array is array (0 to imemLENGTH - 1) of unsigned(dataWIDTH - 1 downto 0);
	signal instrMem : register_array; /* := (others => (others => '0')); */

begin

    rd <= instrMem(addr);

    process(rst_l, we)
    begin
        if rst_l = '0' then
            instrMem <= (others => (others => '0'));
        elsif we = '1'
            instrRegs(addr) <= wd;
        end if;
    end process; 

end Behavioral;
