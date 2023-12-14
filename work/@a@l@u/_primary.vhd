library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        inA             : in     vl_logic_vector(31 downto 0);
        inB             : in     vl_logic_vector(31 downto 0);
        ALUControl      : in     vl_logic_vector(3 downto 0);
        ALUResult       : out    vl_logic_vector(31 downto 0)
    );
end ALU;
