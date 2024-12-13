library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SyntaxDemo is
    generic (
        addrWIDTH : INTEGER := 5
       	dataWIDTH : INTEGER := 32
    );
    port (
        rst_l    : in std_logic;
      	we : in std_logic;
        addr : in std_logic_vector(addrWIDTH - 1 downto 0);
        rd : out std_logic_vector(dataWIDTH - 1 downto 0);
    );
end SyntaxDemo;

architecture Behavioral of SyntaxDemo is

	type register_array is array (0 to 31) of std_logic_vector(dataWIDTH - 1 downto 0);
	signal registers : register_array := (others => (others => '0'));


    -- Signal declarations
    signal internal_signal : std_logic_vector(3 downto 0) := (others => '0');
    signal temp_signal     : std_logic;

    -- Type declarations
    type state_type is (IDLE, WORKING, DONE);
    signal state : state_type := IDLE;

    -- Constant declarations
    constant LOCAL_CONSTANT : integer := 10;

    -- Subprogram declarations
    function add_bits(a, b : std_logic_vector(3 downto 0)) return std_logic_vector is
        variable result : std_logic_vector(4 downto 0);
    begin
        result := ('0' & a) + ('0' & b);
        return result(3 downto 0);
    end function;

begin 
registers(to_integer(unsigned(addr))) <= write_data;

    -- Concurrent assignment
    RD <= internal_signal when state = DONE else (others => '0');
    
    -- Process with if-else
    process(clk, rst)
    begin
        if rst = '1' then
            internal_signal <= (others => '0');
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if input_a = "0000" then
                        state <= WORKING;
                    else
                        state <= IDLE;
                    end if;
                when WORKING =>
                    internal_signal <= add_bits(input_a, input_b);
                    state <= DONE;
                when DONE =>
                    state <= IDLE;
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;
    
   
    -- Process with if-else
    process(clk, rst)
    begin
        if rst = '1' then
            internal_signal <= (others => '0');
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if input_a = "0000" then
                        state <= WORKING;
                    else
                        state <= IDLE;
                    end if;
                when WORKING =>
                    internal_signal <= add_bits(input_a, input_b);
                    state <= DONE;
                when DONE =>
                    state <= IDLE;
                when others =>
                    state <= IDLE;
            end case;
        end if;
    end process;

    -- Concurrent assignment
    output_z <= internal_signal when state = DONE else (others => '0');

    -- Generate block
    gen_loop: for i in 0 to 3 generate
        temp_signal <= input_a(i) and input_b(i);
    end generate gen_loop;

    -- Block statement
    MyBlock: block
        signal block_signal : std_logic_vector(3 downto 0);
    begin
        block_signal <= input_a or input_b;
    end block MyBlock;

end Behavioral;