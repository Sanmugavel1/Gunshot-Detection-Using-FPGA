module top_gunshot_system (
    input  wire clk_100mhz,
    input  wire mic1,
    input  wire mic2,
    input  wire mic3,
    input  wire mic4,
    output wire gunshot,
    output wire [8:0] doa_angle
);

    wire bclk, lrclk;
    wire signed [23:0] ch1, ch2, ch3, ch4;
    wire [31:0] e1, e2, e3, e4;
    wire signed [7:0] d12, d13;

    i2s_master clkgen(clk_100mhz, bclk, lrclk);

    i2s_receiver_4ch rx (
        bclk, lrclk,
        mic1, mic2, mic3, mic4,
        ch1, ch2, ch3, ch4
    );

    energy_detector ed1(ch1, e1);
    energy_detector ed2(ch2, e2);
    energy_detector ed3(ch3, e3);
    energy_detector ed4(ch4, e4);

    gunshot_trigger gt(e1, e2, e3, e4, gunshot);

    tdoa_estimator t1(ch1, ch2, d12);
    tdoa_estimator t2(ch1, ch3, d13);

    doa_calculator doa(d12, d13, doa_angle);

endmodule
