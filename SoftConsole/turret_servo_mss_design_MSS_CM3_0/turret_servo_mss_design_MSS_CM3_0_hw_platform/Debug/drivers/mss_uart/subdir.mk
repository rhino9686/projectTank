################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../drivers/mss_uart/mss_uart.c 

OBJS += \
./drivers/mss_uart/mss_uart.o 

C_DEPS += \
./drivers/mss_uart/mss_uart.d 


# Each subdirectory must supply rules for building sources it contributes
drivers/mss_uart/%.o: ../drivers/mss_uart/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\CMSIS -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_gpio -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm\drivers -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm\drivers\F2DSS_NVM -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_pdma -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc\drivers -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc\drivers\mss_rtc -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_timer -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal\CortexM3 -IC:\Users\waierdg\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

