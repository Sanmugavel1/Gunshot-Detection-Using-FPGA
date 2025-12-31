module gunshot_trigger (
    input  wire [31:0] e1,
    input  wire [31:0] e2,
    input  wire [31:0] e3,
    input  wire [31:0] e4,
    output reg  detected
);
    parameter THRESHOLD = 32'd200000000;

    always @(*) begin
        detected = (e1 > THRESHOLD ||
                    e2 > THRESHOLD ||
                    e3 > THRESHOLD ||
                    e4 > THRESHOLD);
    end
endmodule
