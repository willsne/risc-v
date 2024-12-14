library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control is
    generic (
        instrWIDTH : integer := 32
        addrWIDTH : integer := 5
    );
    port (
        op : in std_logic_vector(6 downto 0);
        funct3 : in std_logic_vector(2 downto 0);
        funct7_bit : in std_logic_vector(6 downto 0);
        zeroFlag : in std_logic;

        extType : out std_logic;
        pcSrc : out std_logic;
        resultSrc : out std_logic; -- =0: ALU, =1: datamemory, =2: pcPlus4
        memWrite : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0);
        ALUSrc : out std_logic;
        ImmSrc : out std_logic_vector(1 downto 0); -- =0: I instr(31:20), =1: SB instr(31:24), =2: UJ instr(31:12)
        regWrite : out std_logic;
    );
end control;

architecture Behavioral of control is

    --- Internal signals
    signal op : std_logic_vector(6 downto 0);
    signal funct7 : std_logic_vector(6 downto 0) := '0000000' or ('0' & funct7_bit & '00000');
    signal funct3 : std_logic_vector(2 downto 0);

    signal rs1 : std_logic_vector(addrWIDTH - 1 downto 0);
    signal rs2 : std_logic_vector(addrWIDTH - 1 downto 0);
    signal immI : std_logic_vector(12 downto 0);
    signal immSB : std_logic_vector(7 downto 0);
    signal immUJ : std_logic_vector(20 downto 0);
    signal branch : std_logic;
    signal jump : std_logic;

begin
    
    process(op);
    begin
        extType <= funct3(2)
        case op is
            -- I-type Load Instructions: lb, lh, lw, lbu, lhu
            when std_logic_vector(to_unsigned(3, op'length)) =>
                ImmSrc <= '00';
                ALUControl <='000'; -- add immExt 
                memWrite <= '0' --read mem
                regWrite <= '1'; --write to regfile
                ALUSrc <= '1';
                resultSrc <= '1'; --datamem rd is is written to regfile instead of aluresult (which is the address)

                --lb
                if funct3 = '000' then
                    
                --lh
                elsif funct3 = '001' then
                    resultSrc <= '1';
                    ALUControl <= xxx
                    ALUSrc <= x
                    regWrite <= '1';
                --lw
                elsif funct3 = '010' then
                    resultSrc <= '1';
                    ALUControl <= xxx
                    ALUSrc <= x
                    regWrite <= '1';
                --lbu
                elsif funct3 = '100' then
                    resultSrc <= '1';
                    ALUControl <= xx
                    ALUSrc <= xx
                    regWrite <= '1';
                --lhu
                elsif funct3 = '101' then
                    resultSrc <= '1';
                    ALUControl <= xx
                    ALUSrc <= xx
                    regWrite <= '1';
                end if;
            -- I-type Immediate Instructions: addi, slti, sltiu, xori, ori, andi
            when std_logic_vector(to_unsigned(19, op'length)) =>
                pcSrc <= '0';
                resultSrc <= 
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= '00';
                regWrite <=

            -- U-type Immediate Instructions: auipc
            when std_logic_vector(to_unsigned(23, op'length)) =>
                pcSrc <= '0';
                resultSrc <=  
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= 
                regWrite <=

            -- S-type Store Instructions: sb, sh, sw
            when std_logic_vector(to_unsigned(35, op'length)) =>
                ImmSrc <= '01'
                --sb
                if funct3 = '000' then
                    pcSrc <= '0';
                    resultSrc <= '1';
                    memWrite <= '0'
                    ALUControl <= xx
                    ALUSrc <= '1'
                    ImmSrc <= '01'
                    regWrite <= '1';
                --sh
                elsif funct3 = '001' then
                    pcSrc <= '0';
                    resultSrc <= '1';
                    memWrite <= '0'
                    ALUControl <= xxx
                    ALUSrc <= x
                    ImmSrc <= xx
                    regWrite <= '1';
                --sw
                elsif funct3 = '100' then
                    pcSrc <= '0';
                    resultSrc <= x
                    memWrite <= '1'
                    ALUControl <= xx
                    ALUSrc <= xx
                    ImmSrc <= '1';
                    regWrite <= '0';
                end if;

            -- R-type Register Instructions: add, sub, sll, srl, sra, etc.
            when std_logic_vector(to_unsigned(51, op'length)) =>
                --ImmSrc <= 
                pcSrc <= '0';
                resultSrc <=  
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= 
                regWrite <=

            -- U-type Immediate Instructions: lui
            when std_logic_vector(to_unsigned(55, op'length)) =>
                pcSrc <= '0';
                resultSrc <=  
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= 
                regWrite <=

            -- B-type Branch Instructions: beq, bne, blt, bge, bltu, bgeu
            when std_logic_vector(to_unsigned(99, op'length)) =>
                pcSrc <= '1'
                resultSrc <=  
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= '10';
                regWrite <=

            -- I-type Jump and Link Register: jalr
            when std_logic_vector(to_unsigned(103, op'length)) =>
                pcSrc <= '1';
                resultSrc <=  
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= '00';
                regWrite <=

            -- J-type Jump and Link: jal
            when std_logic_vector(to_unsigned(111, op'length)) =>
                pcSrc <= '1';
                resultSrc <=  
                memWrite <= 
                ALUControl <= 
                ALUSrc <= 
                ImmSrc <= '11';
                regWrite <=  
        end case;
    end process; 

end Behavioral;
