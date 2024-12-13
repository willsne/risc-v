library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SyntaxDemo is
    generic (
        GENERIC_CONSTANT : integer := 42
    );
    port (
        clk       : in std_logic;
        rst       : in std_logic;
        input_a   : in std_logic_vector(3 downto 0);
        input_b   : in std_logic_vector(3 downto 0);
        addr      : in std_logic_vector(4 downto 0); -- Address input (5 bits for 32 registers)
        write_en  : in std_logic;                   -- Write enable signal
        write_data: in std_logic_vector(31 downto 0); -- Data to write
        read_data : out std_logic_vector(31 downto 0); -- Data read from the register
        output_z  : out std_logic_vector(3 downto 0)
    );
end SyntaxDemo;

architecture Behavioral of SyntaxDemo is

    -- Signal declarations
    signal internal_signal : std_logic_vector(3 downto 0) := (others => '0');
    signal temp_signal     : std_logic;

    -- Type declarations
    type state_type is (IDLE, WORKING, DONE);
    signal state : state_type := IDLE;

    -- Array of 32 32-bit registers
    type register_array is array (0 to 31) of std_logic_vector(31 downto 0);
    signal registers : register_array := (others => (others => '0'));

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

    -- Process with if-else
    process(clk, rst)
    begin
        if rst = '1' and rising_edge(clk) then
            internal_signal <= (others => '0');
            state <= IDLE;
            registers <= (others => (others => '0'));
        elsif rising_edge(clk) then
            if write_en = '1' then
                -- Write data to the register indexed by addr
                registers(to_integer(unsigned(addr))) <= write_data;
            end if;
        end if;
    end process;

    -- Read data from the register indexed by addr
    read_data <= registers(to_integer(unsigned(addr)));

    -- Process for state machine
    process(clk, rst)
    begin
        if rst = '1' then
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
