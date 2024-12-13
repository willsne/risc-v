library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity regfile is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
    );
    port (
        clk : in std_logic;
        rst_l    : in std_logic;
        a1 : in std_logic;
        a2 : in std_logic;
        a3 : in std_logic;
      	we3 : in std_logic;
        addr : in std_logic_vector(addrWIDTH - 1 downto 0);
        wd3 : out std_logic_vector(dataWIDTH - 1 downto 0);
        rd1 : out std_logic_vector(dataWIDTH - 1 downto 0);
        rd2 : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end regfile;

architecture Behavioral of regfile is

	type register_array is array (0 to 31) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal dataRegsD : register_array := (others => (others => '0'));
    signal dataRegsQ : register_array := (others => (others => '0'));


begin

    rd1 <= dataRegsQ(to_integer(unsigned(a1)));
    rd2 <= dataRegsQ(to_integer(unsigned(a2)));

    process(clk, rst_l, we)
    begin
        if rst_l = '0' and rising_edge(clk) then
            dataRegsD <= (others => (others => '0'));
        elsif rising_edge(clk)
            if we3 = '1'
                dataRegsD(to_integer(unsigned(a3))) <= wd3 others => dataRegsQ;
            end if;
            dataRegsQ <= dataRegsD;
        end if;
    end process; 

end Behavioral;
