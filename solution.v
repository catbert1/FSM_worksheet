module computation_device (input wire [3 : 0] x,
                    input wire [3 : 0] y,
                    input wire [1 : 0] opcode,
                    input wire  clk,
                    input wire req,
                    input wire reset,
                    output wire [3 : 0] result);

reg [3:0] res;
reg [3:0] x_prime;
 
always @(posedge reset)begin
    x_prime = x;
    res = x;
end

always @(posedge clk) begin
    
    if(req)begin
        case (opcode)
            2'b00: res = x_prime & y;
            2'b01: res = ~(x_prime & y);
            2'b10: res = ~(x_prime | y);
            2'b11: res = x_prime^y;
        endcase
    end 
end

always @(negedge req)begin
    x_prime = res;
end

assign result = res;

endmodule