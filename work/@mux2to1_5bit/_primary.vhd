library verilog;
use verilog.vl_types.all;
entity Mux2to1_5bit is
    port(
        inA             : in     vl_logic_vector(4 downto 0);
        inB             : in     vl_logic_vector(4 downto 0);
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector(4 downto 0)
    );
end Mux2to1_5bit;
