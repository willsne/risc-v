library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Use numeric_std for arithmetic

entity instructionmemory is
    generic (
        addrWIDTH : INTEGER := 16;
       	dataWIDTH : INTEGER := 32;
        imemLENGTH : INTEGER := 256
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in std_logic_vector(addrWIDTH - 1 downto 0);
        wd : in std_logic_vector(dataWIDTH - 1 downto 0);
        rd : out std_logic_vector(dataWIDTH - 1 downto 0)
    );
end instructionmemory;

architecture Behavioral of instructionmemory is

	type mem_array is array (0 to imemLENGTH - 1) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal instrMem : mem_array := (others => (others => '0'));
    
begin

    rd <= instrMem(to_integer(unsigned(addr)));

    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                instrMem(to_integer(unsigned(addr))) <= wd;
            end if;
        end if;
    end process;

end Behavioral;
