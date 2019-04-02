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
//output wire SW1_debounced,
//output wire SW2_debounced,
output pwm_out1,
output pwm_out2,
input SW1,					// port to switch
input SW2
); 

`define ten_deg 10000 // 5 deg = 5000
`define min 60000
`define max 240000

reg [17:0] pulseWidth1;
reg [17:0] pulseWidth2;
assign PSLVERR = 0;
assign PREADY = 1;


wire Servo_write_1 = PWRITE && PENABLE && PSEL && (PADDR[7:0] == 8'b00010000);   //enable servo 1 write at offset #0x10
wire Servo_write_2 = PWRITE && PENABLE && PSEL && (PADDR[7:0] == 8'b00010100);   //enable servo 2 write at offset #0x14
wire SW1_debounced, SW2_debounced;


Button_Debouncer b1(PCLK, SW1, SW1_debounced);
Button_Debouncer b2(PCLK, SW2, SW2_debounced);

always @(posedge PCLK)
begin
    PRDATA[31:2] <= 8'h00000000;
    PRDATA[1] <= SW2_debounced;
    PRDATA[0] <= SW1_debounced;
end


// r/l
always @(posedge PCLK)
begin
    if(!PRESERN)
        pulseWidth1 <= `min;
    else if (Servo_write_1)
    begin
        pulseWidth1 <= 60000 + (100 * PWDATA[10:0]); // 0-180 deg. (by 1e-6 deg every time)
    end
end

// up/down
always @(posedge PCLK)
begin
    if(!PRESERN)
        pulseWidth2 <= `min;
    else if (Servo_write_2)
    begin
        pulseWidth2 <= 60000 + (100 * PWDATA[10:0]); // 60-120 deg. (by 1e-6 deg every time)
    end
end


pwm p(PCLK, pulseWidth1, pwm_out1);
pwm p1(PCLK, pulseWidth2, pwm_out2);


endmodule



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




//
// *** Button debouncer. ***
// Changes in the input are ignored until they have been consistent for 2^16 clocks.
//
module Button_Debouncer(
    input clk,
    input PB_in, // button input
    output reg PB_out // debounced output
);

reg [15:0] PB_cnt; // 16-bit counter
reg [1:0] sync; // used as two flip-flops to synchronize
                // button to the clk domain.

// First use two flipflops to synchronize the PB signal the "clk" clock domain
always @(posedge clk)
    sync[1:0] <= {sync[0],~PB_in};

wire PB_idle = (PB_out==sync[1]); // See if we have a new input state for PB
wire PB_cnt_max = &PB_cnt;  // true when all bits of PB_cnt are 1's
                            // using & in this way is a
                            // "reduction operation"
                            // When the push-button is pushed or released, we increment the counter.
                            // The counter has to be maxed out before we decide that the push-button
                            // state has changed


always @(posedge clk) begin
    if(PB_idle)
        PB_cnt<= 16'd0; // input and output are the same so clear counter
    else 
    begin
        PB_cnt<= PB_cnt + 16'd1; // input different than output, count

        if(PB_cnt_max)
            PB_out<= ~PB_out; // if the counter is maxed out, change PB output
    end
end

endmodule