module clock_divider (
    input  wire clk_100mhz,
    output reg  bclk,      // ~3.072 MHz
    output reg  lrclk      // 48 kHz
);
    integer cnt = 0;

    always @(posedge clk_100mhz) begin
        cnt <= cnt + 1;

        if (cnt % 16 == 0)
            bclk <= ~bclk;

        if (cnt % 1024 == 0)
            lrclk <= ~lrclk;
    end
endmodule
