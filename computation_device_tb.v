module computation_device_tb;

    // Inputs
    reg [3:0] x;
    reg [3:0] y;
    reg [1:0] opcode;
    reg clk;
    reg req;
    reg reset;

    // Output
    wire [3:0] result;

    // Instantiate the computation device
    computation_device uut (
        .x(x),
        .y(y),
        .opcode(opcode),
        .clk(clk),
        .req(req),
        .reset(reset),
        .result(result)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 units
    end

    // Test sequence
    initial begin
        // Initialize inputs
        x = 4'b1010;  // User-provided initial input
        y = 4'b0101;  // Secondary input
        opcode = 2'b00; // AND operation
        req = 0;
        reset = 1;

        // Apply reset
        #10 reset = 0;
        $display("%0d Initial x=%b", $time, x);

        // Test Case 1: AND operation
        #10 req = 1; 
        #10 req = 0;
        $display("%0d %b & %b = %b", $time, uut.x_prime, y, result);

        // Test Case 2: NAND operation
        opcode = 2'b01;
        y = 4'b0011;
        #10 req = 1; 
        #10 req = 0;
        $display("%0d %b NAND %b = %b", $time, uut.x_prime, y, result);

        // Test Case 3: NOR operation
        opcode = 2'b10;
        y = 4'b1111;
        #10 req = 1; 
        #10 req = 0;
        $display("%0d %b NOR %b = %b", $time, uut.x_prime, y, result);

        // Test Case 4: XOR operation
        opcode = 2'b11;
        y = 4'b0001;
        #10 req = 1; 
        #10 req = 0;
        $display("%0d %b ^ %b = %b", $time, uut.x_prime, y, result);

        // Finish simulation
        #20 $finish;
    end

endmodule
