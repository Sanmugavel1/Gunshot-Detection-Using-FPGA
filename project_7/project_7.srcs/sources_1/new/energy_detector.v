module energy_detector (
    input  wire signed [23:0] sample,
    output reg  [31:0] energy
);
    always @(*) begin
        energy = sample * sample;
    end
endmodule
