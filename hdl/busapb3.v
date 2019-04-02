// busapb3.v

module BUS_INTERFACE(

/*** APB3 BUS INTERFACE ***/
input PCLK, 				// clock
input PRESERN, 				// system reset
input PSEL, 				// peripheral select
input PENABLE, 				// distinguishes access phase
output wire PREADY, 		// peripheral ready signal
output wire PSLVERR,		// error signal
input PWRITE,				// distinguishes read and write cycles
input [31:0] PADDR,			// I/O address
input wire [31:0] PWDATA,	// data from processor to I/O device (32 bits)
output reg [31:0] PRDATA,	// data to processor from I/O device (32-bits)

/*** I/O PORTS DECLARATION ***/	
output pwm_out_IR,
output pwm_out1,
output pwm_out2,
output reg FABINT,
input hit_data
); 

`define ten_deg 10000 // 5 deg = 5000
`define min 60000
`define max 240000

`define half_dc 892
`define khz_56 1785
`define khz_38 2632

reg [17:0] pulseWidth1;
reg [17:0] pulseWidth2;
assign PSLVERR = 0;
assign PREADY = 1;


wire Servo_write_1 = PWRITE && PENABLE && PSEL && (PADDR[7:0] == 8'b00010000);   //enable servo 1 write at offset #0x10
wire Servo_write_2 = PWRITE && PENABLE && PSEL && (PADDR[7:0] == 8'b00010100);   //enable servo 2 write at offset #0x14

// Read hits all the time
reg [3:0] hits;
always @(posedge PCLK)
begin
    PRDATA[31:4] <= 28'h0000000;
    PRDATA[3:0] <= hits;
end

// Frequency and hits write conditions
wire freq_write = PWRITE & PSEL & PENABLE & (PADDR[7:0] == 8'h20);
wire hits_write = PWRITE & PSEL & PENABLE & (PADDR[7:0] == 8'h24);

// Two frequencies (just here for now)
wire from_pwm_56, from_pwm_38;
pwm_IR p2(PCLK, (`khz_56 / 2), `khz_56, from_pwm_56);
pwm_IR p3(PCLK, (`khz_38 / 2), `khz_38, from_pwm_38);

// Select frequency to send on pwm_out_IR
assign pwm_out_IR = (freq == 56) ? (from_pwm_56) : ((freq == 38) ? from_pwm_38 : 0);
reg [5:0] freq;

always @ (posedge PCLK) begin
    if (~PRESERN)
        freq <= 0;
    else if (freq_write) begin
        if (PWDATA[5:0] == 56)
            freq <= 56;
        else if (PWDATA[5:0] == 38)
            freq <= 38;
        else if (PWDATA[5:0] == 0)
            freq <= 0;
    end
end

// Hit interrupt
reg [25:0] hit_count;
always @ (posedge PCLK) begin
    if (hit_data == 0) begin
        if (hit_count[25:0] == 10000000) begin // Hit for .1 seconds to start, may decrease (large for glitches)
            FABINT <= 1'b1;
            hit_count <= 0;
        end
        else begin
            FABINT <= 1'b0;
            hit_count <= hit_count + 1;
        end
    end
    else begin
        FABINT <= 1'b0;
        hit_count <= 0;
    end
end

// Write hits data
always @ (posedge PCLK) begin
    if (~PRESERN)
        hits <= 0;
    else if (hits_write)
        hits <= PWDATA[3:0];
end

// right/left servos
always @(posedge PCLK)
begin
    if(!PRESERN)
        pulseWidth1 <= `min;
    else if (Servo_write_1)
    begin
        pulseWidth1 <= 60000 + (100 * PWDATA[10:0]); // 0-180 deg. (by 1e-6 deg every time)
    end
end

// up/down servos
always @(posedge PCLK)
begin
    if(!PRESERN)
        pulseWidth2 <= `min;
    else if (Servo_write_2)
    begin
        pulseWidth2 <= 60000 + (100 * PWDATA[10:0]); // 60-120 deg. (by 1e-6 deg every time)
    end
end

// PWMs for servos
pwm p(PCLK, pulseWidth1, pwm_out1);
pwm p1(PCLK, pulseWidth2, pwm_out2);
endmodule


// PWM for servos
module pwm(
    input clk,
    input [17:0] pulseWidth,
    output reg pwm
);

`define period 2000000

reg [31:0] count;
always @(posedge clk)
begin
 if (count == `period)
    count <= 0;
 else
    count <= count + 1;
 if (count < pulseWidth)
    pwm <= 1;
 else
    pwm <= 0;
end
endmodule
// end pwm


// PWM for IR
module pwm_IR(
    input clk,
    input [17:0] pulseWidth,
    input [11:0] period,
    output reg pwm
);


reg [31:0] count;
always @(posedge clk)
begin
 if (count == period)
    count <= 0;
 else
    count <= count + 1;
 if (count < pulseWidth)
    pwm <= 1;
 else
    pwm <= 0;
end
endmodule
// end pwm_IR