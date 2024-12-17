library ieee;
use ieee.std_logic_1164.all;

entity top is
    generic (
        regAddrWIDTH : INTEGER := 5;
        instAddrWIDTH : INTEGER := 16;
       	dataWIDTH : INTEGER := 32

    );
    port (
        clk         : in  std_logic;
        rst_l       : in  std_logic
    );
end top;


architecture Behavioral of top is

    --constants
    signal four: STD_LOGIC_VECTOR(dataWIDTH - 1 downto 0) := X"00000004";

    --all signals on the right in an instantiation must be declared
    --sorted by module output

    --instructionmemory
    signal instr : std_logic_vector(dataWIDTH - 1 downto 0);
    --datamemory
    signal readData : std_logic_vector(dataWIDTH - 1 downto 0);
    --regfile
    signal rd1_out : std_logic_vector(dataWIDTH - 1 downto 0);
    signal rd2_out : std_logic_vector(dataWIDTH - 1 downto 0);
    --control
    signal PCSrc : std_logic;
    signal ResultSrc : std_logic;
    signal memWrite : std_logic;
    signal extType : std_logic;
    signal ALUControl : std_logic_vector(2 downto 0);
    signal ALUSrc : std_logic;
    signal zeroFlag : std_logic;
    signal immSrc : std_logic_vector(1 downto 0);
    signal regWrite : std_logic;
    --ALU
    signal ALUResult : std_logic_vector(dataWIDTH - 1 downto 0);
    --immextender
    signal immExt : std_logic_vector(dataWIDTH - 1 downto 0);
    ---PC
    signal PC : std_logic_vector(instAddrWIDTH - 1 downto 0);
    --srcB_mux
    signal srcB : std_logic_vector(dataWIDTH - 1 downto 0);
    --PCNext_mux
    signal PCNext : std_logic_vector(dataWIDTH - 1 downto 0);
    --result_mux
    signal result : std_logic_vector(dataWIDTH - 1 downto 0);
    --PCPlus4_adder
    signal PCPlus4 : std_logic_vector(dataWIDTH - 1 downto 0);
    --PCTarget_adder
    signal PCTarget : std_logic_vector(dataWIDTH - 1 downto 0);
    
    signal PC_with_prefix : std_logic_vector(31 downto 0);


begin
    PC_with_prefix <= X"0000" & PC; -- Assuming PC is 16 bits

    instructionmemory : entity work.instructionmemory
    port map (
        clk => clk,
        rst_l => rst_l,
        we => memWrite, --not writing yet
        addr => PC,
        wd => X"00000000",
        --
        rd => instr --mapping output to internal signal instr
    );

    datamemory : entity work.datamemory
    port map (
        clk => clk,
        rst_l => rst_l,
        we => memWrite,
        addr => ALUResult(15 downto 0),
        wd => rd2_out,
        --
        rd => readData --mapping output to internal signal readData
    );

    regfile : entity work.regfile
    port map (
        clk => clk,
        rst_l => rst_l,
        a1 => instr(19 downto 15),
        a2 => instr(24 downto 20),
        a3 => instr(11 downto 7), --mapping input to internal signal instr
        we3 => regWrite,
        wd3 => result,
        --
        rd1 => rd1_out,
        rd2 => rd2_out
    );

    control : entity work.control
    port map (
        op => instr(6 downto 0),
        funct3 => instr(14 downto 12),
        funct7_bit => instr(30),
        zeroFlag => zeroFlag,
        --
        extType => extType,
        pcSrc => PCSrc,
        resultSrc => ResultSrc,
        memWrite => memWrite,
        ALUControl => ALUControl,
        ALUSrc => ALUSrc,
        ImmSrc => ImmSrc,
        regWrite => regWrite
    );

    ALU : entity work.ALU
    port map (
        srcA => rd1_out,
        srcB => srcB,
        ALUControl => ALUControl,
        --
        ALUResult => ALUResult,
        zeroFlag => zeroFlag
    );

    immextender : entity work.immextender
    port map (
        extType => extType,
        immSrc => immSrc,
        instr => instr,
        --
        immExt => immExt
    );

    programcounter : entity work.programcounter
    port map (
        clk => clk,
        rst_l => rst_l,
        PCNext => PCNext,
        --
        PC => PC
    );

    ---MUXes
    srcB_mux : entity work.mux2
    port map (
        d0 => rd2_out,
        d1 => ImmExt,
        s => ALUSrc,
        --
        y => srcB
    );

    PCNext_mux : entity work.mux2
    port map (
        d0 => PCPlus4,
        d1 => PCTarget,
        s => PCSrc,
        --
        y => PCNext
    );

    result_mux : entity work.mux2
    port map (
        d0 => ALUResult,
        d1 => readData,
        s => resultSrc,
        --
        y => result
    );

    --Adders
    PCPlus4_adder : entity work.adder
    port map (
        a => PC_with_prefix,
        b => four,
        --
        y => PCPlus4
    );

    PCTarget_adder : entity work.adder
    port map (
        a => PC_with_prefix,
        b => ImmExt,
        --
        y => PCTarget
    );


    process(clk)
    begin
        if rising_edge(clk) then
            if rst_l = '0' then
                PC <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;

