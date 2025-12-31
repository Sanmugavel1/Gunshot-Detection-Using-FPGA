module tdoa_estimator (
    input  wire signed [23:0] a,
    input  wire signed [23:0] b,
    output reg  signed [7:0] delay
);
    always @(*) begin
        if (a > b)
            delay = 1;
        else if (a < b)
            delay = -1;
        else
            delay = 0;
    end
endmodule
