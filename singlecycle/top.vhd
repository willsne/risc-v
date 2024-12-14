library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopModule is
    port (
        clk         : in  std_logic;      -- Clock signal
        reset       : in  std_logic;      -- Reset signal
    );
end TopModule;


architecture Structural of TopModule is

    signal pc          : integer range 0 to 31 := 0;   -- Program counter
    signal instr       : std_logic_vector(31 downto 0);
    signal alu_result  : std_logic_vector(31 downto 0);
    signal read_data   : std_logic_vector(31 downto 0);
    signal wd          : std_logic_vector(31 downto 0);
    signal rs1_addr    : std_logic_vector(4 downto 0);
    signal rs2_addr    : std_logic_vector(4 downto 0);
    signal result_src  : std_logic := '0';  -- MUX selector
    signal write_enable : std_logic := '1'; -- Write enable for RegFile
begin
    -- Instantiate the ALU module
    ALU_inst : entity work.ALU
        port map (
            -- ALU ports
            aluresult => alu_result,
            -- other ports...
        );

    -- Instantiate the Data Memory module
    DataMemory_inst : entity work.DataMemory
        port map (
            -- Data memory ports
            readdata => rd,
            -- other ports...
        );

    -- Instantiate the RegFile module
    RegFile_inst : entity work.RegFile
        port map (
            wd => write_data,
            -- other ports...
        );

    -- Multiplexer to decide write data
    process(all)
    begin
        if resultsrc = '0' then
            write_data <= alu_result;
        else
            write_data <= data_memory;
        end if;
    end process;

end Structural;


begin

--map instructionmemory output to datamemory input
as1 <= instr(19:15);
as2 <= instr(24:20);

--map regfile module wd input to either aluresult output of alu module or datamemory module readdata output depending on resultsrc from control module
    -- Multiplexer to select wd input for regfile
    process(all)
    begin
        if resultSrc = '0' then
            wd3 <= aluresult;  -- Select ALU result
        else
            wd3 <= rd;   -- Select data memory output
        end if;
    end process;

end behavioral;

