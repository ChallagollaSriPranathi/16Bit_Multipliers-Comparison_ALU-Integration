module booth_tb;

    reg clk, rst, start;
    reg signed [15:0] A, B;
    wire signed [31:0] P;
    wire done;

    // DUT instantiation
    booth_multiplier_seq uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .A(A),
        .B(B),
        .P(P),
        .done(done)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Initialize
        clk   = 0;
        rst   = 1;
        start = 0;
        A     = 0;
        B     = 0;

        // Release reset
        #12 rst = 0;

        // Apply test vectors
        apply_test(15, 15);
        apply_test(-16, 15);
        apply_test(15, -16);
        apply_test(-16, -16);
        apply_test(50, 70);
        apply_test(90, -45);
        apply_test(-60, 80);
        apply_test(-75, -90);
        apply_test(1000, -2000);
        apply_test(12345, 2345);
        apply_test(13, -11);
        apply_test(-12, 14);
        apply_test(-9, -9);
        apply_test(0, 15);
        apply_test(11, 0);
        apply_test(-5000, -30000);
        apply_test(-1000, -26789);
        apply_test(-2000, 25467);
        apply_test(32767, 32767);
        apply_test(-32768, -32768);
        apply_test(-32768, 32767);
        apply_test(32767, -32768);

        #100 $finish;
    end

    // Task to apply inputs and wait for result
    task apply_test(input signed [15:0] a_in, input signed [15:0] b_in);
    begin
        @(posedge clk);
        A     <= a_in;
        B     <= b_in;
        start <= 1;
        @(posedge clk);
        start <= 0;

        // Wait until done goes high
        wait(done);
        $display("%0dns: A=%d, B=%d, P=%d", $time, A, B, P);
    end
    endtask

endmodule
