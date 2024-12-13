library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instructionmemory is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
    );
    port (
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in std_logic_vector(addrWIDTH - 1 downto 0);
        wd : out std_logic_vector(dataWIDTH - 1 downto 0);
        rd : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end instructionmemory;

architecture Behavioral of instructionmemory is

	type register_array is array (0 to 31) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal instrRegs : register_array := (others => (others => '0'));

begin

    RD <= instrRegs(to_integer(unsigned(addr))) when rst_l = '0' else (others => '0')

    process(rst_l, we)
    begin
        if rst_l = '0' then
            instrRegs(to_integer(unsigned(addr))) <= (others => (others => '0'));
        elsif we = '1'
            instrRegs(to_integer(unsigned(addr))) <= wd;
        end if;
    end process; 

end Behavioral;
