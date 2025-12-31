module doa_calculator (
    input  signed [7:0] d12,
    input  signed [7:0] d13,
    output reg   [8:0] angle
);
    always @(*) begin
        if (d12 == 0)
            angle = 90;
        else if (d12 > 0)
            angle = 45;
        else
            angle = 135;
    end
endmodule
