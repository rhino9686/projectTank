################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hal/CortexM3/cortex_nvic.c 

OBJS += \
./hal/CortexM3/cortex_nvic.o 

C_DEPS += \
./hal/CortexM3/cortex_nvic.d 


# Each subdirectory must supply rules for building sources it contributes
hal/CortexM3/%.o: ../hal/CortexM3/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\CMSIS -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_gpio -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm\drivers -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm\drivers\F2DSS_NVM -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_pdma -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc\drivers -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc\drivers\mss_rtc -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_timer -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal\CortexM3 -IC:\Users\celinesc\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


