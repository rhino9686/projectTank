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
output reg HIT_INT,
input hit_data,
output reg [3:0] MOTOR,
output PWM_motor1,
output PWM_motor2

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
assign PWM_motor2 = PWM_motor1;

wire Servo_write_1 = PWRITE && PENABLE && PSEL && (PADDR[7:0] == 8'b00010000);   //enable servo 1 write at offset #0x10
wire Servo_write_2 = PWRITE && PENABLE && PSEL && (PADDR[7:0] == 8'b00010100);   //enable servo 2 write at offset #0x14
wire Motor_write = PSEL && PENABLE && (PADDR[7:0] == 8'b00110100); // enable motor at offset 0x40050034
wire Motor_pulse_width_write = PSEL && PENABLE && (PADDR[7:0] == 8'b00111000); // enable motor pulsewidth write at offset 0x40050038
//set up motor pulse width write
reg [23:0] PulseWidth = 0;

pwmMotor modulator(PCLK, PulseWidth, PWM_motor1);
always @(posedge PCLK)
begin
    if(!PRESERN)
    MOTOR[3:0] <= 4'b0000;
    else if(Motor_write)
    MOTOR <= PWDATA[3:0];
end
always @(posedge PCLK)
begin
    if(Motor_pulse_width_write)
        PulseWidth <= PWDATA[23:0];
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
            HIT_INT <= 1'b1;
            hit_count <= 0;
        end
        else begin
            HIT_INT <= 1'b0;
            hit_count <= hit_count + 1;
        end
    end
    else begin
        HIT_INT <= 1'b0;
        hit_count <= 0;
    end
end


reg [3:0] hits;
// Read hits data
always @ (posedge PCLK) begin
    PRDATA[31:4] <= 28'h0000000; // PRDATA will read hits if timer isn't being read
    PRDATA[3:0] <= hits;
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

//PWM for Motor
module pwmMotor(
input clk,
input[23:0] pulseWidth,
output reg pwm
);


`define period 100000
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
// end pwmMotor



/* TIMER MODULE (not needed now, just here in case)

// Timer for Hits
assign BUS_WRITE_EN = (PENABLE && PWRITE && PSEL && ((PADDR[7:0] == 8'b00000000) || (PADDR[7:0] == 8'b00000100) || (PADDR[7:0] == 8'b00001000))); // offset 0x40050000 - 8
assign BUS_READ_EN = (!PWRITE && PSEL && ((PADDR[7:0] == 8'b00000000) || (PADDR[7:0] == 8'b00000100) || (PADDR[7:0] == 8'b00001000))); 
//Data is ready during first cycle to make it availble on the bus when PENABLE is asserted

// TIMER STUFF

reg [31:0] compareReg;
reg [31:0] counterReg;
reg [31:0] controlReg;
reg [31:0] overflowReg;

reg overflowReset;		//Resets counterReg when new overflow value is written

wire timerEn;        //Timer Enable
wire interruptEn;    //Interrupt Enable
wire compareEn;      //Compare Enable
wire overflowEn;	 //Overflow Enable

assign timerEn 		= controlReg[0];
assign interruptEn 	= controlReg[1];
assign compareEn 	= controlReg[2];
assign overflowEn	= controlReg[3];

reg [1:0] interrupt_status;
reg reset_interrupt;
reg timer_interrupt;

reg [31:0] nextCounter;

always@(posedge PCLK)
if(~PRESERN)
  FABINT   <= 1'b0;
else
  begin
    if(timer_interrupt)
      FABINT   <= 1'b1;
    else
      FABINT   <= 1'b0;
end



always@(posedge PCLK)
if(~PRESERN)
  begin
    overflowReset <= 1'b0;
    compareReg <= 32'h00000000;
    overflowReg <= 32'h00000000;
	controlReg <= 32'h00000000;
    reset_interrupt <= 1'b0;
  end
else begin
	if(BUS_WRITE_EN) begin : WRITE
		case(PADDR[4:2])
			3'b000: // Overflow Register
                begin 
                overflowReset <= 1'b1;
				overflowReg <= PWDATA[31:0];
                end
            3'b001: // Timer Value, Read Only
                begin
                overflowReset <= 1'b0;
                end
            3'b010: // Timer Control
                begin 
                overflowReset <= 1'b0;
                controlReg <= PWDATA[31:0];
                end
            3'b011: // Compare Register
                begin
                overflowReset <= 1'b0;
                compareReg <= PWDATA[31:0];
                end
            3'b100: //Interrupt Status, Read Only
                begin
                overflowReset <= 1'b0;
                end
            3'b101: //Spare
                begin
                end
        endcase
    end
	else if(BUS_READ_EN) begin : READ
        case(PADDR[4:2])
	        3'b000: // Timer Overflow register
                begin 
		        PRDATA[31:0] <= overflowReg;
                reset_interrupt <= 1'b0;
				end
            3'b001: // Timer Value, Read Only
                begin 
                PRDATA[31:0] <= counterReg;
                reset_interrupt <= 1'b0;
				end
            3'b010: // Timer Control
                begin 
                PRDATA[31:0] <= controlReg;
                reset_interrupt <= 1'b0;
			    end
            3'b011: //Compare Register
                begin
                PRDATA[31:0] <= compareReg;
                reset_interrupt <= 1'b0;
                end
            3'b100: // Interrupt Status
                begin 
                PRDATA[31:2] <= 30'd0;;
                PRDATA[1:0] <= interrupt_status;
                reset_interrupt <= 1'b1;
                end
            3'b101: //Spare
                begin
                end
        endcase
     end
     else begin
	   overflowReset <= 1'b0;
       reset_interrupt <= 1'b0;
       
     end
end

always@*
	nextCounter = counterReg + 1;
  
always@(posedge PCLK)
if(~PRESERN) begin
	counterReg <= 32'd0;
    timer_interrupt <= 1'b0;
    interrupt_status <= 2'b00;
end
else begin
    if(reset_interrupt)begin
        interrupt_status <= 2'b00;
        timer_interrupt <= 1'b0;
    end
    else begin
        if(overflowReset) begin
            counterReg <= 32'd0;
            timer_interrupt <= 1'b0;
        end
        else if(timerEn) begin
            if(counterReg == overflowReg) begin
                counterReg <= 32'd0;
                if(interruptEn && overflowEn) begin
                    timer_interrupt <= 1'b1;
                    interrupt_status[0] <= 1'b1;
                end
                else
                    timer_interrupt <= 1'b0;
            end
            else begin
                if(counterReg == compareReg && interruptEn && compareEn) begin
                    timer_interrupt <= 1'b1;
                    interrupt_status[1] <= 1'b1;
                end
                else
                    timer_interrupt <= 1'b0;
                counterReg <= nextCounter;
            end
        end

    end
end 
*/