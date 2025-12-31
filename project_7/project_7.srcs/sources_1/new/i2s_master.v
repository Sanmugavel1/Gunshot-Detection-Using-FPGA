module i2s_master (
    input  wire clk,
    output wire bclk,
    output wire lrclk
);
    clock_divider cd (
        .clk_100mhz(clk),
        .bclk(bclk),
        .lrclk(lrclk)
    );
endmodule
