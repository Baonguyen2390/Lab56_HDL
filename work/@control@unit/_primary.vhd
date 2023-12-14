library verilog;
use verilog.vl_types.all;
entity ControlUnit is
    port(
        op              : in     vl_logic_vector(5 downto 0);
        RegDst          : out    vl_logic;
        RegWrite        : out    vl_logic;
        ALUSrc          : out    vl_logic;
        ALUcontrol      : out    vl_logic_vector(3 downto 0);
        MemWrite        : out    vl_logic;
        MemRead         : out    vl_logic;
        MemToReg        : out    vl_logic
    );
end ControlUnit;
