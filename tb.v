`timescale 1ns/1ps

module tb;

reg clk = 0;
reg reset = 1;
reg [7:0] DI = 8'h00;
wire [15:0] AB;
wire [7:0] DO;
wire WE;

reg [7:0] mem [0:65535];
integer i;

cpu uut (
    .clk(clk),
    .reset(reset),
    .AB(AB),
    .DI(DI),
    .DO(DO),
    .WE(WE),
    .IRQ(1'b0),
    .NMI(1'b0),
    .RDY(1'b1)
);

always #5 clk = ~clk;

always @(posedge clk) begin
    DI <= mem[AB];
    if (WE) mem[AB] <= DO;
end

initial begin
    for (i = 0; i < 65536; i = i + 1) mem[i] = 8'hEA;

    mem[16'hFFFC] = 8'h00;
    mem[16'hFFFD] = 8'h02;

    mem[16'h0200] = 8'hA9; mem[16'h0201] = 8'h00;
    mem[16'h0202] = 8'h69; mem[16'h0203] = 8'h01;
    mem[16'h0204] = 8'h85; mem[16'h0205] = 8'h10;
    mem[16'h0206] = 8'hC9; mem[16'h0207] = 8'h0A;
    mem[16'h0208] = 8'hD0; mem[16'h0209] = 8'hF8;
    mem[16'h020A] = 8'hA0; mem[16'h020B] = 8'h07;
    mem[16'h020C] = 8'h8C; mem[16'h020D] = 8'h11; mem[16'h020E] = 8'h00;
    mem[16'h020F] = 8'h4C; mem[16'h0210] = 8'h0F; mem[16'h0211] = 8'h02;

    mem[16'h0010] = 8'h00;
    mem[16'h0011] = 8'h00;

    #52 reset = 0;
    #4000;

    $display("mem[0x10] = %0d (expect 10)", mem[16'h0010]);
    $display("mem[0x11] = %0d (expect 7)", mem[16'h0011]);
    if (mem[16'h0010] == 8'd10 && mem[16'h0011] == 8'd7)
        $display("PASS");
    else
        $display("FAIL");
    $finish;
end

endmodule
