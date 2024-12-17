library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    generic (
        instrWIDTH : integer := 32;
        addrWIDTH : integer := 5
    );
    port (
        op : in std_logic_vector(6 downto 0);
        funct3 : in std_logic_vector(2 downto 0);
        funct7_bit : in std_logic;
        zeroFlag : in std_logic;

        extType : out std_logic;
        pcSrc : out std_logic;
        resultSrc : out std_logic; -- =0: ALU, =1: datamemory, =2: pcPlus4
        memWrite : out std_logic;
        ALUControl : out std_logic_vector(2 downto 0);
        ALUSrc : out std_logic;
        ImmSrc : out std_logic_vector(1 downto 0); -- =0: I instr(31:20), =1: SB instr(31:24), =2: UJ instr(31:12)
        regWrite : out std_logic
    );
end control;

architecture Behavioral of control is
    -- Internal signals
    signal funct7 : std_logic_vector(6 downto 0);
    signal rs1 : std_logic_vector(addrWIDTH - 1 downto 0);
    signal rs2 : std_logic_vector(addrWIDTH - 1 downto 0);
    signal immI : std_logic_vector(12 downto 0);
    signal immSB : std_logic_vector(7 downto 0);
    signal immUJ : std_logic_vector(20 downto 0);
    signal branch : std_logic;
    signal jump : std_logic;

begin
-- Initialize funct7 as an OR operation (or use intended logic)
funct7 <= '0' & funct7_bit & "00000"; -- Corrected logic.

    process(op, funct3)
    begin
        case op is
        -- I-type Load Instructions: lb, lh, lw, lbu, lhu
            when "0000011" => -- Convert 3 to std_logic_vector
                ImmSrc <= "00"; 
                ALUControl <= "000"; -- Add immediate extension
                memWrite <= '0'; -- Read memory
                regWrite <= '1'; -- Write to regfile
                ALUSrc <= '1'; --Extender output
                resultSrc <= '1'; -- Data memory written to regfile
                pcSrc <= '0'; --pcPlus4
                extType <= '0'; --sign extend
            
--                -- lb
--                if funct3 = "000" then
--                    -- Add specific logic for `lb`
--                -- lh
--                elsif funct3 = "001" then
--                    -- Add specific logic for `lh`
                -- lw
--                if funct3 = "010" then
                    
--                end if;
                    
--                    -- Add specific logic for `lw`
--                -- lbu
--                elsif funct3 = "100" then
--                    -- Add specific logic for `lbu`
--                -- lhu
--                elsif funct3 = "101" then
--                    -- Add specific logic for `lhu`
--                end if;
            when others =>
                -- Assign safe default values
                ImmSrc <= "00";
                ALUControl <= "000";
                memWrite <= '0';
                regWrite <= '0';
                ALUSrc <= '0';
                resultSrc <= '0';
                pcSrc <= '0';
                extType <= '0';
            end case; 
    end process;

end Behavioral;
