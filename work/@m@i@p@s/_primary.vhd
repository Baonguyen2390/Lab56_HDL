library verilog;
use verilog.vl_types.all;
entity MIPS is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic_vector(31 downto 0);
        outReadData1    : out    vl_logic_vector(31 downto 0);
        outReadData2    : out    vl_logic_vector(31 downto 0);
        ALUresult       : out    vl_logic_vector(31 downto 0);
        outMuxMemToReg  : out    vl_logic_vector(31 downto 0)
    );
end MIPS;
