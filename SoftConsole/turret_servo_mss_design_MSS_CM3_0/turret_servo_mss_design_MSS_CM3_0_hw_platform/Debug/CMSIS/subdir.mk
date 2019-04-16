################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../CMSIS/brownout_isr.c \
../CMSIS/core_cm3.c \
../CMSIS/system_a2fxxxm3.c 

OBJS += \
./CMSIS/brownout_isr.o \
./CMSIS/core_cm3.o \
./CMSIS/system_a2fxxxm3.o 

C_DEPS += \
./CMSIS/brownout_isr.d \
./CMSIS/core_cm3.d \
./CMSIS/system_a2fxxxm3.d 


# Each subdirectory must supply rules for building sources it contributes
CMSIS/%.o: ../CMSIS/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU C Compiler'
	arm-none-eabi-gcc -mthumb -mcpu=cortex-m3 -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\CMSIS -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\CMSIS\startup_gcc -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_gpio -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm\drivers -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_nvm\drivers\F2DSS_NVM -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_pdma -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc\drivers -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_rtc\drivers\mss_rtc -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\drivers\mss_timer -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal\CortexM3 -IC:\Users\rpuyat\Desktop\ps2_turret_ir_integration\SoftConsole\turret_servo_mss_design_MSS_CM3_0\turret_servo_mss_design_MSS_CM3_0_hw_platform\hal\CortexM3\GNU -O0 -ffunction-sections -fdata-sections -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o"$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


