library verilog;
use verilog.vl_types.all;
entity Datapath is
    port(
        clk             : in     vl_logic;
        \in\            : in     vl_logic_vector(31 downto 0);
        RegDst          : in     vl_logic;
        RegWrite        : in     vl_logic;
        ALUSrc          : in     vl_logic;
        ALUcontrol      : in     vl_logic_vector(3 downto 0);
        MemRead         : in     vl_logic;
        MemWrite        : in     vl_logic;
        MemToReg        : in     vl_logic;
        outReadData1    : out    vl_logic_vector(31 downto 0);
        outReadData2    : out    vl_logic_vector(31 downto 0);
        ALUresult       : out    vl_logic_vector(31 downto 0);
        outMuxMemToReg  : out    vl_logic_vector(31 downto 0)
    );
end Datapath;
