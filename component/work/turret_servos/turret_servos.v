//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Apr 12 18:55:39 2019
// Version: v11.9 11.9.0.4
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// turret_servos
module turret_servos(
    // Inputs
    MSS_RESET_N,
    SPI_1_DI,
    UART_0_RXD,
    UART_1_RXD,
    hit_data,
    // Outputs
    MOTOR,
    PWM_motor1,
    PWM_motor2,
    SPI_1_DO,
    UART_0_TXD,
    UART_1_TXD,
    pwm_out1,
    pwm_out2,
    pwm_out_IR,
    // Inouts
    SPI_1_CLK,
    SPI_1_SS
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        MSS_RESET_N;
input        SPI_1_DI;
input        UART_0_RXD;
input        UART_1_RXD;
input        hit_data;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [3:0] MOTOR;
output       PWM_motor1;
output       PWM_motor2;
output       SPI_1_DO;
output       UART_0_TXD;
output       UART_1_TXD;
output       pwm_out1;
output       pwm_out2;
output       pwm_out_IR;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout        SPI_1_CLK;
inout        SPI_1_SS;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          BUS_INTERFACE_0_FABINT;
wire          BUS_INTERFACE_0_HIT_INT;
wire   [31:0] CoreAPB3_0_APBmslave0_PADDR;
wire          CoreAPB3_0_APBmslave0_PENABLE;
wire   [31:0] CoreAPB3_0_APBmslave0_PRDATA;
wire          CoreAPB3_0_APBmslave0_PREADY;
wire          CoreAPB3_0_APBmslave0_PSELx;
wire          CoreAPB3_0_APBmslave0_PSLVERR;
wire   [31:0] CoreAPB3_0_APBmslave0_PWDATA;
wire          CoreAPB3_0_APBmslave0_PWRITE;
wire          hit_data;
wire   [3:0]  MOTOR_net_0;
wire          MSS_RESET_N;
wire          PWM_motor1_net_0;
wire          PWM_motor2_net_0;
wire          pwm_out1_net_0;
wire          pwm_out2_net_0;
wire          pwm_out_IR_net_0;
wire          SPI_1_CLK;
wire          SPI_1_DI;
wire          SPI_1_DO_net_0;
wire          SPI_1_SS;
wire          turret_servo_mss_design_0_FAB_CLK;
wire          turret_servo_mss_design_0_M2F_RESET_N;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PENABLE;
wire   [31:0] turret_servo_mss_design_0_MSS_MASTER_APB_PRDATA;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PREADY;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PSELx;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PSLVERR;
wire   [31:0] turret_servo_mss_design_0_MSS_MASTER_APB_PWDATA;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PWRITE;
wire          UART_0_RXD;
wire          UART_0_TXD_net_0;
wire          UART_1_RXD;
wire          UART_1_TXD_net_0;
wire          pwm_out1_net_1;
wire          pwm_out2_net_1;
wire          SPI_1_DO_net_1;
wire          pwm_out_IR_net_1;
wire          PWM_motor1_net_1;
wire          PWM_motor2_net_1;
wire          UART_0_TXD_net_1;
wire   [3:0]  MOTOR_net_1;
wire          UART_1_TXD_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [31:0] IADDR_const_net_0;
wire   [31:0] PRDATAS1_const_net_0;
wire   [31:0] PRDATAS2_const_net_0;
wire   [31:0] PRDATAS3_const_net_0;
wire   [31:0] PRDATAS4_const_net_0;
wire   [31:0] PRDATAS5_const_net_0;
wire   [31:0] PRDATAS6_const_net_0;
wire   [31:0] PRDATAS7_const_net_0;
wire   [31:0] PRDATAS8_const_net_0;
wire   [31:0] PRDATAS9_const_net_0;
wire   [31:0] PRDATAS10_const_net_0;
wire   [31:0] PRDATAS11_const_net_0;
wire   [31:0] PRDATAS12_const_net_0;
wire   [31:0] PRDATAS13_const_net_0;
wire   [31:0] PRDATAS14_const_net_0;
wire   [31:0] PRDATAS15_const_net_0;
wire   [31:0] PRDATAS16_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:20]turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0_31to20;
wire   [19:0] turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0_19to0;
wire   [31:0] turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0;
wire   [19:0] turret_servo_mss_design_0_MSS_MASTER_APB_PADDR;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net               = 1'b0;
assign VCC_net               = 1'b1;
assign IADDR_const_net_0     = 32'h00000000;
assign PRDATAS1_const_net_0  = 32'h00000000;
assign PRDATAS2_const_net_0  = 32'h00000000;
assign PRDATAS3_const_net_0  = 32'h00000000;
assign PRDATAS4_const_net_0  = 32'h00000000;
assign PRDATAS5_const_net_0  = 32'h00000000;
assign PRDATAS6_const_net_0  = 32'h00000000;
assign PRDATAS7_const_net_0  = 32'h00000000;
assign PRDATAS8_const_net_0  = 32'h00000000;
assign PRDATAS9_const_net_0  = 32'h00000000;
assign PRDATAS10_const_net_0 = 32'h00000000;
assign PRDATAS11_const_net_0 = 32'h00000000;
assign PRDATAS12_const_net_0 = 32'h00000000;
assign PRDATAS13_const_net_0 = 32'h00000000;
assign PRDATAS14_const_net_0 = 32'h00000000;
assign PRDATAS15_const_net_0 = 32'h00000000;
assign PRDATAS16_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign pwm_out1_net_1   = pwm_out1_net_0;
assign pwm_out1         = pwm_out1_net_1;
assign pwm_out2_net_1   = pwm_out2_net_0;
assign pwm_out2         = pwm_out2_net_1;
assign SPI_1_DO_net_1   = SPI_1_DO_net_0;
assign SPI_1_DO         = SPI_1_DO_net_1;
assign pwm_out_IR_net_1 = pwm_out_IR_net_0;
assign pwm_out_IR       = pwm_out_IR_net_1;
assign PWM_motor1_net_1 = PWM_motor1_net_0;
assign PWM_motor1       = PWM_motor1_net_1;
assign PWM_motor2_net_1 = PWM_motor2_net_0;
assign PWM_motor2       = PWM_motor2_net_1;
assign UART_0_TXD_net_1 = UART_0_TXD_net_0;
assign UART_0_TXD       = UART_0_TXD_net_1;
assign MOTOR_net_1      = MOTOR_net_0;
assign MOTOR[3:0]       = MOTOR_net_1;
assign UART_1_TXD_net_1 = UART_1_TXD_net_0;
assign UART_1_TXD       = UART_1_TXD_net_1;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0_31to20 = 12'h0;
assign turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0_19to0 = turret_servo_mss_design_0_MSS_MASTER_APB_PADDR[19:0];
assign turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0 = { turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0_31to20, turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0_19to0 };

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------BUS_INTERFACE
BUS_INTERFACE BUS_INTERFACE_0(
        // Inputs
        .PCLK       ( turret_servo_mss_design_0_FAB_CLK ),
        .PRESERN    ( turret_servo_mss_design_0_M2F_RESET_N ),
        .PSEL       ( CoreAPB3_0_APBmslave0_PSELx ),
        .PENABLE    ( CoreAPB3_0_APBmslave0_PENABLE ),
        .PWRITE     ( CoreAPB3_0_APBmslave0_PWRITE ),
        .hit_data   ( hit_data ),
        .PADDR      ( CoreAPB3_0_APBmslave0_PADDR ),
        .PWDATA     ( CoreAPB3_0_APBmslave0_PWDATA ),
        // Outputs
        .PREADY     ( CoreAPB3_0_APBmslave0_PREADY ),
        .PSLVERR    ( CoreAPB3_0_APBmslave0_PSLVERR ),
        .pwm_out_IR ( pwm_out_IR_net_0 ),
        .pwm_out1   ( pwm_out1_net_0 ),
        .pwm_out2   ( pwm_out2_net_0 ),
        .FABINT     ( BUS_INTERFACE_0_FABINT ),
        .HIT_INT    ( BUS_INTERFACE_0_HIT_INT ),
        .PWM_motor1 ( PWM_motor1_net_0 ),
        .PWM_motor2 ( PWM_motor2_net_0 ),
        .PRDATA     ( CoreAPB3_0_APBmslave0_PRDATA ),
        .MOTOR      ( MOTOR_net_0 ) 
        );

//--------CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.1.100
CoreAPB3 #( 
        .APB_DWIDTH      ( 32 ),
        .APBSLOT0ENABLE  ( 1 ),
        .APBSLOT1ENABLE  ( 0 ),
        .APBSLOT2ENABLE  ( 0 ),
        .APBSLOT3ENABLE  ( 0 ),
        .APBSLOT4ENABLE  ( 0 ),
        .APBSLOT5ENABLE  ( 0 ),
        .APBSLOT6ENABLE  ( 0 ),
        .APBSLOT7ENABLE  ( 0 ),
        .APBSLOT8ENABLE  ( 0 ),
        .APBSLOT9ENABLE  ( 0 ),
        .APBSLOT10ENABLE ( 0 ),
        .APBSLOT11ENABLE ( 0 ),
        .APBSLOT12ENABLE ( 0 ),
        .APBSLOT13ENABLE ( 0 ),
        .APBSLOT14ENABLE ( 0 ),
        .APBSLOT15ENABLE ( 0 ),
        .FAMILY          ( 18 ),
        .IADDR_OPTION    ( 0 ),
        .MADDR_BITS      ( 12 ),
        .SC_0            ( 0 ),
        .SC_1            ( 0 ),
        .SC_2            ( 0 ),
        .SC_3            ( 0 ),
        .SC_4            ( 0 ),
        .SC_5            ( 0 ),
        .SC_6            ( 0 ),
        .SC_7            ( 0 ),
        .SC_8            ( 0 ),
        .SC_9            ( 0 ),
        .SC_10           ( 0 ),
        .SC_11           ( 0 ),
        .SC_12           ( 0 ),
        .SC_13           ( 0 ),
        .SC_14           ( 0 ),
        .SC_15           ( 0 ),
        .UPR_NIBBLE_POSN ( 2 ) )
CoreAPB3_0(
        // Inputs
        .PRESETN    ( GND_net ), // tied to 1'b0 from definition
        .PCLK       ( GND_net ), // tied to 1'b0 from definition
        .PWRITE     ( turret_servo_mss_design_0_MSS_MASTER_APB_PWRITE ),
        .PENABLE    ( turret_servo_mss_design_0_MSS_MASTER_APB_PENABLE ),
        .PSEL       ( turret_servo_mss_design_0_MSS_MASTER_APB_PSELx ),
        .PREADYS0   ( CoreAPB3_0_APBmslave0_PREADY ),
        .PSLVERRS0  ( CoreAPB3_0_APBmslave0_PSLVERR ),
        .PREADYS1   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS1  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS2   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS2  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS3   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS3  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS4   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS4  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS5   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS5  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS6   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS6  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS7   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS7  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS8   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS8  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS9   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS9  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS10  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS10 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS11  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS11 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS12  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS12 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS13  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS13 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS14  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS14 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS15  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS15 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS16  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS16 ( GND_net ), // tied to 1'b0 from definition
        .PADDR      ( turret_servo_mss_design_0_MSS_MASTER_APB_PADDR_0 ),
        .PWDATA     ( turret_servo_mss_design_0_MSS_MASTER_APB_PWDATA ),
        .PRDATAS0   ( CoreAPB3_0_APBmslave0_PRDATA ),
        .PRDATAS1   ( PRDATAS1_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS2   ( PRDATAS2_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS3   ( PRDATAS3_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS4   ( PRDATAS4_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS5   ( PRDATAS5_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS6   ( PRDATAS6_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS7   ( PRDATAS7_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS8   ( PRDATAS8_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS9   ( PRDATAS9_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS10  ( PRDATAS10_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS11  ( PRDATAS11_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS12  ( PRDATAS12_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS13  ( PRDATAS13_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS14  ( PRDATAS14_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS15  ( PRDATAS15_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS16  ( PRDATAS16_const_net_0 ), // tied to 32'h00000000 from definition
        .IADDR      ( IADDR_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .PREADY     ( turret_servo_mss_design_0_MSS_MASTER_APB_PREADY ),
        .PSLVERR    ( turret_servo_mss_design_0_MSS_MASTER_APB_PSLVERR ),
        .PWRITES    ( CoreAPB3_0_APBmslave0_PWRITE ),
        .PENABLES   ( CoreAPB3_0_APBmslave0_PENABLE ),
        .PSELS0     ( CoreAPB3_0_APBmslave0_PSELx ),
        .PSELS1     (  ),
        .PSELS2     (  ),
        .PSELS3     (  ),
        .PSELS4     (  ),
        .PSELS5     (  ),
        .PSELS6     (  ),
        .PSELS7     (  ),
        .PSELS8     (  ),
        .PSELS9     (  ),
        .PSELS10    (  ),
        .PSELS11    (  ),
        .PSELS12    (  ),
        .PSELS13    (  ),
        .PSELS14    (  ),
        .PSELS15    (  ),
        .PSELS16    (  ),
        .PRDATA     ( turret_servo_mss_design_0_MSS_MASTER_APB_PRDATA ),
        .PADDRS     ( CoreAPB3_0_APBmslave0_PADDR ),
        .PWDATAS    ( CoreAPB3_0_APBmslave0_PWDATA ) 
        );

//--------turret_servo_mss_design
turret_servo_mss_design turret_servo_mss_design_0(
        // Inputs
        .MSS_RESET_N ( MSS_RESET_N ),
        .MSSPREADY   ( turret_servo_mss_design_0_MSS_MASTER_APB_PREADY ),
        .MSSPSLVERR  ( turret_servo_mss_design_0_MSS_MASTER_APB_PSLVERR ),
        .SPI_1_DI    ( SPI_1_DI ),
        .FABINT      ( BUS_INTERFACE_0_FABINT ),
        .F2M_GPI_0   ( BUS_INTERFACE_0_HIT_INT ),
        .UART_0_RXD  ( UART_0_RXD ),
        .MSSPRDATA   ( turret_servo_mss_design_0_MSS_MASTER_APB_PRDATA ),
        .UART_1_RXD  ( UART_1_RXD ),
        // Outputs
        .FAB_CLK     ( turret_servo_mss_design_0_FAB_CLK ),
        .MSSPSEL     ( turret_servo_mss_design_0_MSS_MASTER_APB_PSELx ),
        .MSSPENABLE  ( turret_servo_mss_design_0_MSS_MASTER_APB_PENABLE ),
        .MSSPWRITE   ( turret_servo_mss_design_0_MSS_MASTER_APB_PWRITE ),
        .M2F_RESET_N ( turret_servo_mss_design_0_M2F_RESET_N ),
        .SPI_1_DO    ( SPI_1_DO_net_0 ),
        .UART_0_TXD  ( UART_0_TXD_net_0 ),
        .MSSPADDR    ( turret_servo_mss_design_0_MSS_MASTER_APB_PADDR ),
        .MSSPWDATA   ( turret_servo_mss_design_0_MSS_MASTER_APB_PWDATA ),
        .UART_1_TXD  ( UART_1_TXD_net_0 ),
        // Inouts
        .SPI_1_CLK   ( SPI_1_CLK ),
        .SPI_1_SS    ( SPI_1_SS ) 
        );


endmodule
