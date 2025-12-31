module i2s_receiver_4ch (
    input  wire bclk,
    input  wire lrclk,
    input  wire mic1,
    input  wire mic2,
    input  wire mic3,
    input  wire mic4,
    output reg signed [23:0] ch1,
    output reg signed [23:0] ch2,
    output reg signed [23:0] ch3,
    output reg signed [23:0] ch4
);

    reg [4:0] bit_cnt = 0;
    reg signed [23:0] shift1, shift2, shift3, shift4;

    always @(negedge bclk) begin
        shift1 <= {shift1[22:0], mic1};
        shift2 <= {shift2[22:0], mic2};
        shift3 <= {shift3[22:0], mic3};
        shift4 <= {shift4[22:0], mic4};

        bit_cnt <= bit_cnt + 1;

        if (bit_cnt == 23) begin
            ch1 <= shift1;
            ch2 <= shift2;
            ch3 <= shift3;
            ch4 <= shift4;
            bit_cnt <= 0;
        end
    end
endmodule
