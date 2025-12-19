
module barrel_shifter(
    input logic [7:0] data,
    input logic [2:0] shift_amt,
    output logic [7:0] out
);

    always_comb begin
        out = (data << shift_amt) | (data >> (8 - shift_amt));
    end

endmodule

