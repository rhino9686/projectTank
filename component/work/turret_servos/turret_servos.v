//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Apr 18 15:54:42 2019
// Version: v11.9 11.9.0.4
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// turret_servos
module turret_servos(
    // Inputs
    MSS_RESET_N,
    RX,
    SPICLKI,
    SPISDI,
    SPISSI,
    SPI_1_DI,
    UART_0_RXD,
    UART_1_RXD,
    hit_data,
    // Outputs
    MOTOR,
    PWM_motor1,
    SPISCLKO,
    SPISDO,
    SPI_1_DO,
    TX,
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
input        RX;
input        SPICLKI;
input        SPISDI;
input        SPISSI;
input        SPI_1_DI;
input        UART_0_RXD;
input        UART_1_RXD;
input        hit_data;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [3:0] MOTOR;
output       PWM_motor1;
output       SPISCLKO;
output       SPISDO;
output       SPI_1_DO;
output       TX;
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
wire          BUS_INTERFACE_0_FABINT_0;
wire          BUS_INTERFACE_0_HIT_INT;
wire          CoreAPB3_0_APBmslave0_PENABLE;
wire   [31:0] CoreAPB3_0_APBmslave0_PRDATA;
wire          CoreAPB3_0_APBmslave0_PREADY;
wire          CoreAPB3_0_APBmslave0_PSELx;
wire          CoreAPB3_0_APBmslave0_PSLVERR;
wire          CoreAPB3_0_APBmslave0_PWRITE;
wire          CoreAPB3_0_APBmslave1_PREADY;
wire          CoreAPB3_0_APBmslave1_PSELx;
wire          CoreAPB3_0_APBmslave1_PSLVERR;
wire   [31:0] CoreAPB3_0_APBmslave2_PRDATA;
wire          CoreAPB3_0_APBmslave2_PREADY;
wire          CoreAPB3_0_APBmslave2_PSELx;
wire          CoreAPB3_0_APBmslave2_PSLVERR;
wire          CoreAPB3_0_APBmslave3_0_PSELx;
wire          hit_data;
wire   [3:0]  MOTOR_net_0;
wire          MSS_RESET_N;
wire          PWM_motor1_net_0;
wire          pwm_out1_net_0;
wire          pwm_out2_net_0;
wire          pwm_out_IR_net_0;
wire          RX;
wire          SPI_1_CLK;
wire          SPI_1_DI;
wire          SPI_1_DO_net_0;
wire          SPI_1_SS;
wire          SPICLKI;
wire          SPISCLKO_net_0;
wire          SPISDI;
wire          SPISDO_net_0;
wire   [7:0]  SPISS;
wire          SPISSI;
wire          turret_servo_mss_design_0_FAB_CLK;
wire          turret_servo_mss_design_0_M2F_RESET_N;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PENABLE;
wire   [31:0] turret_servo_mss_design_0_MSS_MASTER_APB_PRDATA;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PREADY;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PSELx;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PSLVERR;
wire   [31:0] turret_servo_mss_design_0_MSS_MASTER_APB_PWDATA;
wire          turret_servo_mss_design_0_MSS_MASTER_APB_PWRITE;
wire          TX_net_0;
wire          UART_0_RXD;
wire          UART_0_TXD_net_0;
wire          UART_1_RXD;
wire          UART_1_TXD_net_0;
wire          pwm_out1_net_1;
wire          pwm_out2_net_1;
wire          SPI_1_DO_net_1;
wire          pwm_out_IR_net_1;
wire          PWM_motor1_net_1;
wire          UART_0_TXD_net_1;
wire          UART_1_TXD_net_1;
wire          TX_net_1;
wire          SPISDO_net_1;
wire          SPISCLKO_net_1;
wire   [3:0]  MOTOR_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [31:0] IADDR_const_net_0;
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
wire   [6:0]  CoreAPB3_0_APBmslave0_PADDR_1_6to0;
wire   [6:0]  CoreAPB3_0_APBmslave0_PADDR_1;
wire   [4:0]  CoreAPB3_0_APBmslave0_PADDR_0_4to0;
wire   [4:0]  CoreAPB3_0_APBmslave0_PADDR_0;
wire   [31:0] CoreAPB3_0_APBmslave0_PADDR;
wire   [31:0] CoreAPB3_0_APBmslave0_PWDATA;
wire   [7:0]  CoreAPB3_0_APBmslave0_PWDATA_0_7to0;
wire   [7:0]  CoreAPB3_0_APBmslave0_PWDATA_0;
wire   [7:0]  CoreAPB3_0_APBmslave1_PRDATA;
wire   [31:8] CoreAPB3_0_APBmslave1_PRDATA_0_31to8;
wire   [7:0]  CoreAPB3_0_APBmslave1_PRDATA_0_7to0;
wire   [31:0] CoreAPB3_0_APBmslave1_PRDATA_0;
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
assign UART_0_TXD_net_1 = UART_0_TXD_net_0;
assign UART_0_TXD       = UART_0_TXD_net_1;
assign UART_1_TXD_net_1 = UART_1_TXD_net_0;
assign UART_1_TXD       = UART_1_TXD_net_1;
assign TX_net_1         = TX_net_0;
assign TX               = TX_net_1;
assign SPISDO_net_1     = SPISDO_net_0;
assign SPISDO           = SPISDO_net_1;
assign SPISCLKO_net_1   = SPISCLKO_net_0;
assign SPISCLKO         = SPISCLKO_net_1;
assign MOTOR_net_1      = MOTOR_net_0;
assign MOTOR[3:0]       = MOTOR_net_1;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign CoreAPB3_0_APBmslave0_PADDR_1_6to0 = CoreAPB3_0_APBmslave0_PADDR[6:0];
assign CoreAPB3_0_APBmslave0_PADDR_1 = { CoreAPB3_0_APBmslave0_PADDR_1_6to0 };
assign CoreAPB3_0_APBmslave0_PADDR_0_4to0 = CoreAPB3_0_APBmslave0_PADDR[4:0];
assign CoreAPB3_0_APBmslave0_PADDR_0 = { CoreAPB3_0_APBmslave0_PADDR_0_4to0 };

assign CoreAPB3_0_APBmslave0_PWDATA_0_7to0 = CoreAPB3_0_APBmslave0_PWDATA[7:0];
assign CoreAPB3_0_APBmslave0_PWDATA_0 = { CoreAPB3_0_APBmslave0_PWDATA_0_7to0 };

assign CoreAPB3_0_APBmslave1_PRDATA_0_31to8 = 24'h0;
assign CoreAPB3_0_APBmslave1_PRDATA_0_7to0 = CoreAPB3_0_APBmslave1_PRDATA[7:0];
assign CoreAPB3_0_APBmslave1_PRDATA_0 = { CoreAPB3_0_APBmslave1_PRDATA_0_31to8, CoreAPB3_0_APBmslave1_PRDATA_0_7to0 };

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
        .PADDR      ( CoreAPB3_0_APBmslave0_PADDR ),
        .PWDATA     ( CoreAPB3_0_APBmslave0_PWDATA ),
        .hit_data   ( hit_data ),
        // Outputs
        .PREADY     ( CoreAPB3_0_APBmslave0_PREADY ),
        .PSLVERR    ( CoreAPB3_0_APBmslave0_PSLVERR ),
        .PRDATA     ( CoreAPB3_0_APBmslave0_PRDATA ),
        .pwm_out_IR ( pwm_out_IR_net_0 ),
        .pwm_out1   ( pwm_out1_net_0 ),
        .pwm_out2   ( pwm_out2_net_0 ),
        .FABINT     ( BUS_INTERFACE_0_FABINT_0 ),
        .HIT_INT    ( BUS_INTERFACE_0_HIT_INT ),
        .MOTOR      ( MOTOR_net_0 ),
        .PWM_motor1 ( PWM_motor1_net_0 ) 
        );

//--------CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.1.100
CoreAPB3 #( 
        .APB_DWIDTH      ( 32 ),
        .APBSLOT0ENABLE  ( 1 ),
        .APBSLOT1ENABLE  ( 1 ),
        .APBSLOT2ENABLE  ( 1 ),
        .APBSLOT3ENABLE  ( 1 ),
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
        .PREADYS1   ( CoreAPB3_0_APBmslave1_PREADY ),
        .PSLVERRS1  ( CoreAPB3_0_APBmslave1_PSLVERR ),
        .PREADYS2   ( CoreAPB3_0_APBmslave2_PREADY ),
        .PSLVERRS2  ( CoreAPB3_0_APBmslave2_PSLVERR ),
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
        .PRDATAS1   ( CoreAPB3_0_APBmslave1_PRDATA_0 ),
        .PRDATAS2   ( CoreAPB3_0_APBmslave2_PRDATA ),
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
        .PSELS1     ( CoreAPB3_0_APBmslave1_PSELx ),
        .PSELS2     ( CoreAPB3_0_APBmslave2_PSELx ),
        .PSELS3     ( CoreAPB3_0_APBmslave3_0_PSELx ),
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

//--------CORESPI   -   Actel:DirectCore:CORESPI:5.2.104
CORESPI #( 
        .APB_DWIDTH        ( 32 ),
        .CFG_CLK           ( 255 ),
        .CFG_FIFO_DEPTH    ( 4 ),
        .CFG_FRAME_SIZE    ( 32 ),
        .CFG_MODE          ( 0 ),
        .CFG_MOT_MODE      ( 3 ),
        .CFG_MOT_SSEL      ( 0 ),
        .CFG_NSC_OPERATION ( 0 ),
        .CFG_TI_JMB_FRAMES ( 0 ),
        .CFG_TI_NSC_CUSTOM ( 0 ),
        .CFG_TI_NSC_FRC    ( 0 ) )
CORESPI_0(
        // Inputs
        .PCLK       ( turret_servo_mss_design_0_FAB_CLK ),
        .PRESETN    ( turret_servo_mss_design_0_M2F_RESET_N ),
        .PSEL       ( CoreAPB3_0_APBmslave2_PSELx ),
        .PENABLE    ( CoreAPB3_0_APBmslave0_PENABLE ),
        .PWRITE     ( CoreAPB3_0_APBmslave0_PWRITE ),
        .SPISSI     ( SPISSI ),
        .SPISDI     ( SPISDI ),
        .SPICLKI    ( SPICLKI ),
        .PADDR      ( CoreAPB3_0_APBmslave0_PADDR_1 ),
        .PWDATA     ( CoreAPB3_0_APBmslave0_PWDATA ),
        // Outputs
        .PREADY     ( CoreAPB3_0_APBmslave2_PREADY ),
        .PSLVERR    ( CoreAPB3_0_APBmslave2_PSLVERR ),
        .SPIINT     (  ),
        .SPIRXAVAIL (  ),
        .SPITXRFM   (  ),
        .SPISCLKO   ( SPISCLKO_net_0 ),
        .SPIOEN     (  ),
        .SPISDO     ( SPISDO_net_0 ),
        .SPIMODE    (  ),
        .PRDATA     ( CoreAPB3_0_APBmslave2_PRDATA ),
        .SPISS      ( SPISS ) 
        );

//--------turret_servos_CoreUARTapb_0_CoreUARTapb   -   Actel:DirectCore:CoreUARTapb:5.6.102
turret_servos_CoreUARTapb_0_CoreUARTapb #( 
        .BAUD_VAL_FRCTN    ( 0 ),
        .BAUD_VAL_FRCTN_EN ( 0 ),
        .BAUD_VALUE        ( 1 ),
        .FAMILY            ( 18 ),
        .FIXEDMODE         ( 0 ),
        .PRG_BIT8          ( 0 ),
        .PRG_PARITY        ( 0 ),
        .RX_FIFO           ( 1 ),
        .RX_LEGACY_MODE    ( 0 ),
        .TX_FIFO           ( 1 ) )
CoreUARTapb_0(
        // Inputs
        .PCLK        ( turret_servo_mss_design_0_FAB_CLK ),
        .PRESETN     ( turret_servo_mss_design_0_M2F_RESET_N ),
        .PSEL        ( CoreAPB3_0_APBmslave1_PSELx ),
        .PENABLE     ( CoreAPB3_0_APBmslave0_PENABLE ),
        .PWRITE      ( CoreAPB3_0_APBmslave0_PWRITE ),
        .RX          ( RX ),
        .PADDR       ( CoreAPB3_0_APBmslave0_PADDR_0 ),
        .PWDATA      ( CoreAPB3_0_APBmslave0_PWDATA_0 ),
        // Outputs
        .TXRDY       (  ),
        .RXRDY       (  ),
        .PARITY_ERR  (  ),
        .OVERFLOW    (  ),
        .TX          ( TX_net_0 ),
        .PREADY      ( CoreAPB3_0_APBmslave1_PREADY ),
        .PSLVERR     ( CoreAPB3_0_APBmslave1_PSLVERR ),
        .FRAMING_ERR (  ),
        .PRDATA      ( CoreAPB3_0_APBmslave1_PRDATA ) 
        );

//--------turret_servo_mss_design
turret_servo_mss_design turret_servo_mss_design_0(
        // Inputs
        .MSS_RESET_N ( MSS_RESET_N ),
        .MSSPREADY   ( turret_servo_mss_design_0_MSS_MASTER_APB_PREADY ),
        .MSSPSLVERR  ( turret_servo_mss_design_0_MSS_MASTER_APB_PSLVERR ),
        .SPI_1_DI    ( SPI_1_DI ),
        .F2M_GPI_0   ( BUS_INTERFACE_0_HIT_INT ),
        .UART_0_RXD  ( UART_0_RXD ),
        .UART_1_RXD  ( UART_1_RXD ),
        .MSSPRDATA   ( turret_servo_mss_design_0_MSS_MASTER_APB_PRDATA ),
        .FABINT      ( BUS_INTERFACE_0_FABINT_0 ),
        // Outputs
        .FAB_CLK     ( turret_servo_mss_design_0_FAB_CLK ),
        .MSSPSEL     ( turret_servo_mss_design_0_MSS_MASTER_APB_PSELx ),
        .MSSPENABLE  ( turret_servo_mss_design_0_MSS_MASTER_APB_PENABLE ),
        .MSSPWRITE   ( turret_servo_mss_design_0_MSS_MASTER_APB_PWRITE ),
        .M2F_RESET_N ( turret_servo_mss_design_0_M2F_RESET_N ),
        .SPI_1_DO    ( SPI_1_DO_net_0 ),
        .UART_0_TXD  ( UART_0_TXD_net_0 ),
        .UART_1_TXD  ( UART_1_TXD_net_0 ),
        .MSSPADDR    ( turret_servo_mss_design_0_MSS_MASTER_APB_PADDR ),
        .MSSPWDATA   ( turret_servo_mss_design_0_MSS_MASTER_APB_PWDATA ),
        // Inouts
        .SPI_1_CLK   ( SPI_1_CLK ),
        .SPI_1_SS    ( SPI_1_SS ) 
        );


endmodule
