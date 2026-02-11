#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../src/comm/Communication.c ../src/comm/command_handler.c ../src/comm/protocol_adapter.c ../src/comm/uart_wrapper.c ../src/diag/diagnostics_x2cscope.c ../src/foc/estim.c ../src/foc/fdweak.c ../src/foc/singleshunt.c ../src/hal/adc.c ../src/hal/board_service.c ../src/hal/clock.c ../src/hal/port_config.c ../src/hal/pwm.c ../src/hal/uart1.c ../src/hal/measure.c ../src/hal/cmp.c ../src/hal/device_config.c ../src/hal/interrupt.c ../src/hal/uart2.c ../src/hal/timer1.c ../src/hal/timer2.c ../lib/freertos/tasks.c ../lib/freertos/queue.c ../lib/freertos/list.c ../lib/freertos/timers.c ../lib/freertos/event_groups.c ../lib/freertos/stream_buffer.c ../lib/freertos/portable/MPLAB/PIC24_dsPIC/port.c ../lib/freertos/portable/MPLAB/PIC24_dsPIC/portasm_PIC24.S ../lib/freertos/portable/MemMang/heap_4.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../src/motor/motor_control.c ../src/motor/motor_speed.c ../src/motor/motor_statemachine.c ../src/ui/led_blinker.c ../src/ui/led_blinker_cfg.c ../src/ui/led_blinker_drv.c ../src/ui/led_morse.c ../src/util/ring_buffer.c ../src/pmsm.c D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1019403322/Communication.o ${OBJECTDIR}/_ext/1019403322/command_handler.o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/659855552/estim.o ${OBJECTDIR}/_ext/659855552/fdweak.o ${OBJECTDIR}/_ext/659855552/singleshunt.o ${OBJECTDIR}/_ext/659857049/adc.o ${OBJECTDIR}/_ext/659857049/board_service.o ${OBJECTDIR}/_ext/659857049/clock.o ${OBJECTDIR}/_ext/659857049/port_config.o ${OBJECTDIR}/_ext/659857049/pwm.o ${OBJECTDIR}/_ext/659857049/uart1.o ${OBJECTDIR}/_ext/659857049/measure.o ${OBJECTDIR}/_ext/659857049/cmp.o ${OBJECTDIR}/_ext/659857049/device_config.o ${OBJECTDIR}/_ext/659857049/interrupt.o ${OBJECTDIR}/_ext/659857049/uart2.o ${OBJECTDIR}/_ext/659857049/timer1.o ${OBJECTDIR}/_ext/659857049/timer2.o ${OBJECTDIR}/_ext/924769355/tasks.o ${OBJECTDIR}/_ext/924769355/queue.o ${OBJECTDIR}/_ext/924769355/list.o ${OBJECTDIR}/_ext/924769355/timers.o ${OBJECTDIR}/_ext/924769355/event_groups.o ${OBJECTDIR}/_ext/924769355/stream_buffer.o ${OBJECTDIR}/_ext/246599827/port.o ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o ${OBJECTDIR}/_ext/1625629234/heap_4.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1527489797/motor_control.o ${OBJECTDIR}/_ext/1527489797/motor_speed.o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o ${OBJECTDIR}/_ext/809997874/led_blinker.o ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o ${OBJECTDIR}/_ext/809997874/led_morse.o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o ${OBJECTDIR}/_ext/1360937237/pmsm.o ${OBJECTDIR}/_ext/616499158/Build_info.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1019403322/Communication.o.d ${OBJECTDIR}/_ext/1019403322/command_handler.o.d ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d ${OBJECTDIR}/_ext/659855552/estim.o.d ${OBJECTDIR}/_ext/659855552/fdweak.o.d ${OBJECTDIR}/_ext/659855552/singleshunt.o.d ${OBJECTDIR}/_ext/659857049/adc.o.d ${OBJECTDIR}/_ext/659857049/board_service.o.d ${OBJECTDIR}/_ext/659857049/clock.o.d ${OBJECTDIR}/_ext/659857049/port_config.o.d ${OBJECTDIR}/_ext/659857049/pwm.o.d ${OBJECTDIR}/_ext/659857049/uart1.o.d ${OBJECTDIR}/_ext/659857049/measure.o.d ${OBJECTDIR}/_ext/659857049/cmp.o.d ${OBJECTDIR}/_ext/659857049/device_config.o.d ${OBJECTDIR}/_ext/659857049/interrupt.o.d ${OBJECTDIR}/_ext/659857049/uart2.o.d ${OBJECTDIR}/_ext/659857049/timer1.o.d ${OBJECTDIR}/_ext/659857049/timer2.o.d ${OBJECTDIR}/_ext/924769355/tasks.o.d ${OBJECTDIR}/_ext/924769355/queue.o.d ${OBJECTDIR}/_ext/924769355/list.o.d ${OBJECTDIR}/_ext/924769355/timers.o.d ${OBJECTDIR}/_ext/924769355/event_groups.o.d ${OBJECTDIR}/_ext/924769355/stream_buffer.o.d ${OBJECTDIR}/_ext/246599827/port.o.d ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.d ${OBJECTDIR}/_ext/1625629234/heap_4.o.d ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d ${OBJECTDIR}/_ext/1527489797/motor_control.o.d ${OBJECTDIR}/_ext/1527489797/motor_speed.o.d ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d ${OBJECTDIR}/_ext/809997874/led_blinker.o.d ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o.d ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o.d ${OBJECTDIR}/_ext/809997874/led_morse.o.d ${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d ${OBJECTDIR}/_ext/1360937237/pmsm.o.d ${OBJECTDIR}/_ext/616499158/Build_info.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1019403322/Communication.o ${OBJECTDIR}/_ext/1019403322/command_handler.o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/659855552/estim.o ${OBJECTDIR}/_ext/659855552/fdweak.o ${OBJECTDIR}/_ext/659855552/singleshunt.o ${OBJECTDIR}/_ext/659857049/adc.o ${OBJECTDIR}/_ext/659857049/board_service.o ${OBJECTDIR}/_ext/659857049/clock.o ${OBJECTDIR}/_ext/659857049/port_config.o ${OBJECTDIR}/_ext/659857049/pwm.o ${OBJECTDIR}/_ext/659857049/uart1.o ${OBJECTDIR}/_ext/659857049/measure.o ${OBJECTDIR}/_ext/659857049/cmp.o ${OBJECTDIR}/_ext/659857049/device_config.o ${OBJECTDIR}/_ext/659857049/interrupt.o ${OBJECTDIR}/_ext/659857049/uart2.o ${OBJECTDIR}/_ext/659857049/timer1.o ${OBJECTDIR}/_ext/659857049/timer2.o ${OBJECTDIR}/_ext/924769355/tasks.o ${OBJECTDIR}/_ext/924769355/queue.o ${OBJECTDIR}/_ext/924769355/list.o ${OBJECTDIR}/_ext/924769355/timers.o ${OBJECTDIR}/_ext/924769355/event_groups.o ${OBJECTDIR}/_ext/924769355/stream_buffer.o ${OBJECTDIR}/_ext/246599827/port.o ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o ${OBJECTDIR}/_ext/1625629234/heap_4.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1527489797/motor_control.o ${OBJECTDIR}/_ext/1527489797/motor_speed.o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o ${OBJECTDIR}/_ext/809997874/led_blinker.o ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o ${OBJECTDIR}/_ext/809997874/led_morse.o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o ${OBJECTDIR}/_ext/1360937237/pmsm.o ${OBJECTDIR}/_ext/616499158/Build_info.o

# Source Files
SOURCEFILES=../src/comm/Communication.c ../src/comm/command_handler.c ../src/comm/protocol_adapter.c ../src/comm/uart_wrapper.c ../src/diag/diagnostics_x2cscope.c ../src/foc/estim.c ../src/foc/fdweak.c ../src/foc/singleshunt.c ../src/hal/adc.c ../src/hal/board_service.c ../src/hal/clock.c ../src/hal/port_config.c ../src/hal/pwm.c ../src/hal/uart1.c ../src/hal/measure.c ../src/hal/cmp.c ../src/hal/device_config.c ../src/hal/interrupt.c ../src/hal/uart2.c ../src/hal/timer1.c ../src/hal/timer2.c ../lib/freertos/tasks.c ../lib/freertos/queue.c ../lib/freertos/list.c ../lib/freertos/timers.c ../lib/freertos/event_groups.c ../lib/freertos/stream_buffer.c ../lib/freertos/portable/MPLAB/PIC24_dsPIC/port.c ../lib/freertos/portable/MPLAB/PIC24_dsPIC/portasm_PIC24.S ../lib/freertos/portable/MemMang/heap_4.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../src/motor/motor_control.c ../src/motor/motor_speed.c ../src/motor/motor_statemachine.c ../src/ui/led_blinker.c ../src/ui/led_blinker_cfg.c ../src/ui/led_blinker_drv.c ../src/ui/led_morse.c ../src/util/ring_buffer.c ../src/pmsm.c D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=33CK256MP508
MP_LINKER_FILE_OPTION=,--script=p33CK256MP508.gld
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1019403322/Communication.o: ../src/comm/Communication.c  .generated_files/flags/default/4ea0e3cfe081fcbb17517dfd7839141dbe14422d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/Communication.c  -o ${OBJECTDIR}/_ext/1019403322/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/Communication.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/command_handler.o: ../src/comm/command_handler.c  .generated_files/flags/default/d933aaced6b448c90c71a8a32cdfb250de46bcf2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/command_handler.c  -o ${OBJECTDIR}/_ext/1019403322/command_handler.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/command_handler.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/protocol_adapter.o: ../src/comm/protocol_adapter.c  .generated_files/flags/default/5c37faff4dadfdf33a5c89480141aec786f32583 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/protocol_adapter.c  -o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/uart_wrapper.o: ../src/comm/uart_wrapper.c  .generated_files/flags/default/b461a9c2b794ce63737e1bfbec1785b42a2cc1eb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/uart_wrapper.c  -o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o: ../src/diag/diagnostics_x2cscope.c  .generated_files/flags/default/f06390ccbe74c60c924e2913e587fe618671dfd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019379675" 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/diag/diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/estim.o: ../src/foc/estim.c  .generated_files/flags/default/34bf30a5cbc1392c1175d9a79d99145126feb0a6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/estim.c  -o ${OBJECTDIR}/_ext/659855552/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/estim.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/fdweak.o: ../src/foc/fdweak.c  .generated_files/flags/default/3dedb9d93ba38c86f88b883bef6d128f86ed8c9d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/fdweak.c  -o ${OBJECTDIR}/_ext/659855552/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/fdweak.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/singleshunt.o: ../src/foc/singleshunt.c  .generated_files/flags/default/9d2f360e23961bbb495ef916ddb3722b36c0da45 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/singleshunt.c  -o ${OBJECTDIR}/_ext/659855552/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/singleshunt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/adc.o: ../src/hal/adc.c  .generated_files/flags/default/7f74a7bcead265f6c703b72f0c7156185c3bcea0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/adc.c  -o ${OBJECTDIR}/_ext/659857049/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/adc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/board_service.o: ../src/hal/board_service.c  .generated_files/flags/default/f67a6fb007114d2279052906c610ab66f23a356a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/board_service.c  -o ${OBJECTDIR}/_ext/659857049/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/board_service.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/clock.o: ../src/hal/clock.c  .generated_files/flags/default/9317010e34a2ab806601fc271e65ee66d37b844 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/clock.c  -o ${OBJECTDIR}/_ext/659857049/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/clock.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/port_config.o: ../src/hal/port_config.c  .generated_files/flags/default/8ec6b5e6deef848e415a861a835d1ac540af778a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/port_config.c  -o ${OBJECTDIR}/_ext/659857049/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/port_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/pwm.o: ../src/hal/pwm.c  .generated_files/flags/default/c8afff498da660a9c86feb7dd4ef2c432b3ad887 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/pwm.c  -o ${OBJECTDIR}/_ext/659857049/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/pwm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart1.o: ../src/hal/uart1.c  .generated_files/flags/default/d9eb704b02ae0a1e53b0b6a244d6176a559e5d48 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart1.c  -o ${OBJECTDIR}/_ext/659857049/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart1.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/measure.o: ../src/hal/measure.c  .generated_files/flags/default/bb1593e1e2e5dbbf8fae6fabce0280d68ee611a2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/measure.c  -o ${OBJECTDIR}/_ext/659857049/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/measure.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/cmp.o: ../src/hal/cmp.c  .generated_files/flags/default/c052fbdd815c7fb11a1c351e87c1806a78480db7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/cmp.c  -o ${OBJECTDIR}/_ext/659857049/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/cmp.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/device_config.o: ../src/hal/device_config.c  .generated_files/flags/default/fc11c4e1869de3208115f4e65ae5438a3775cbe3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/device_config.c  -o ${OBJECTDIR}/_ext/659857049/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/device_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/interrupt.o: ../src/hal/interrupt.c  .generated_files/flags/default/e7262b7bd0515da1fb4089195c8097461b4b2ba8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/interrupt.c  -o ${OBJECTDIR}/_ext/659857049/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/interrupt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart2.o: ../src/hal/uart2.c  .generated_files/flags/default/e487309fab99402a3a0b78164c06db07f99b8a42 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart2.c  -o ${OBJECTDIR}/_ext/659857049/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart2.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/timer1.o: ../src/hal/timer1.c  .generated_files/flags/default/7e2a097a49e59df1084e2532b27b0dbbf512ec42 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/timer1.c  -o ${OBJECTDIR}/_ext/659857049/timer1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/timer1.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/timer2.o: ../src/hal/timer2.c  .generated_files/flags/default/86fb258785f400c0d179b5038eff4e8264d51c4e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer2.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/timer2.c  -o ${OBJECTDIR}/_ext/659857049/timer2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/timer2.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/tasks.o: ../lib/freertos/tasks.c  .generated_files/flags/default/2d7ef9d2b826971fe83a21ddca8d4d26592e9bdd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/tasks.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/tasks.c  -o ${OBJECTDIR}/_ext/924769355/tasks.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/tasks.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/queue.o: ../lib/freertos/queue.c  .generated_files/flags/default/762484b6a59f0ac77afb086f59bee04f6b2278b1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/queue.c  -o ${OBJECTDIR}/_ext/924769355/queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/queue.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/list.o: ../lib/freertos/list.c  .generated_files/flags/default/8ad511583e90d4ec88bf919aa4e58f5c36cd8a2f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/list.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/list.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/list.c  -o ${OBJECTDIR}/_ext/924769355/list.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/list.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/timers.o: ../lib/freertos/timers.c  .generated_files/flags/default/1f909c3939a75bf6ed01472925140949cfed173f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/timers.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/timers.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/timers.c  -o ${OBJECTDIR}/_ext/924769355/timers.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/timers.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/event_groups.o: ../lib/freertos/event_groups.c  .generated_files/flags/default/f2d0988a52f73986e4fc0676aeaaf5158797f865 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/event_groups.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/event_groups.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/event_groups.c  -o ${OBJECTDIR}/_ext/924769355/event_groups.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/event_groups.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/stream_buffer.o: ../lib/freertos/stream_buffer.c  .generated_files/flags/default/c985aebe026f839803067be7863a125259e6fa55 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/stream_buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/stream_buffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/stream_buffer.c  -o ${OBJECTDIR}/_ext/924769355/stream_buffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/stream_buffer.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/246599827/port.o: ../lib/freertos/portable/MPLAB/PIC24_dsPIC/port.c  .generated_files/flags/default/788baa8c4c98d25aeef91ff5a90ead50334fd10d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/246599827" 
	@${RM} ${OBJECTDIR}/_ext/246599827/port.o.d 
	@${RM} ${OBJECTDIR}/_ext/246599827/port.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/portable/MPLAB/PIC24_dsPIC/port.c  -o ${OBJECTDIR}/_ext/246599827/port.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/246599827/port.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1625629234/heap_4.o: ../lib/freertos/portable/MemMang/heap_4.c  .generated_files/flags/default/c1a37c0025cffb0eb7946e79ed7505e0d31aaae0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1625629234" 
	@${RM} ${OBJECTDIR}/_ext/1625629234/heap_4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1625629234/heap_4.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/portable/MemMang/heap_4.c  -o ${OBJECTDIR}/_ext/1625629234/heap_4.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1625629234/heap_4.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_control.o: ../src/motor/motor_control.c  .generated_files/flags/default/3d65dd0ad628dd9afe7449d45968796ff3eda8c3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_control.c  -o ${OBJECTDIR}/_ext/1527489797/motor_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_control.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_speed.o: ../src/motor/motor_speed.c  .generated_files/flags/default/30e0f8717ce9a45770f23bc8de448a7cb456a105 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_speed.c  -o ${OBJECTDIR}/_ext/1527489797/motor_speed.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_speed.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_statemachine.o: ../src/motor/motor_statemachine.c  .generated_files/flags/default/9004a55ca018c7dad7de6d33198f342bfcd28622 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_statemachine.c  -o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_blinker.o: ../src/ui/led_blinker.c  .generated_files/flags/default/d2bf12b53bae3e7fea2549286b82af50322057c0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_blinker.c  -o ${OBJECTDIR}/_ext/809997874/led_blinker.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_blinker.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o: ../src/ui/led_blinker_cfg.c  .generated_files/flags/default/b90d6fa6d57fa6f0c9d558459c7d92c9e12c036b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_blinker_cfg.c  -o ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_blinker_drv.o: ../src/ui/led_blinker_drv.c  .generated_files/flags/default/160b97fefb8c1457e28ef7adf43b23cfb177398 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_blinker_drv.c  -o ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_blinker_drv.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_morse.o: ../src/ui/led_morse.c  .generated_files/flags/default/9fcdaaa395e7d1c83ae06fdf05af791d2230d476 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_morse.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_morse.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_morse.c  -o ${OBJECTDIR}/_ext/809997874/led_morse.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_morse.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1018862404/ring_buffer.o: ../src/util/ring_buffer.c  .generated_files/flags/default/83d0db0ede7ea1c717194d0b74533f40590064ed .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1018862404" 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/util/ring_buffer.c  -o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/pmsm.o: ../src/pmsm.c  .generated_files/flags/default/383c5f5fb7509a952b497c04b5f8d58c4335dc59 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/pmsm.c  -o ${OBJECTDIR}/_ext/1360937237/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/pmsm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/616499158/Build_info.o: D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  .generated_files/flags/default/c9b92d2e726fd41f32a3883958d9b7cdb331bad5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/616499158" 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o.d 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  -o ${OBJECTDIR}/_ext/616499158/Build_info.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/616499158/Build_info.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1019403322/Communication.o: ../src/comm/Communication.c  .generated_files/flags/default/f9aef9c24273be537a4dbb0629b44ad4e715a3d2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/Communication.c  -o ${OBJECTDIR}/_ext/1019403322/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/Communication.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/command_handler.o: ../src/comm/command_handler.c  .generated_files/flags/default/de37fcdf6885c7d3f24bded85b6e16e526c91ee3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/command_handler.c  -o ${OBJECTDIR}/_ext/1019403322/command_handler.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/command_handler.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/protocol_adapter.o: ../src/comm/protocol_adapter.c  .generated_files/flags/default/27234c4398f070b7720afa1d4282a123a41b4948 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/protocol_adapter.c  -o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/uart_wrapper.o: ../src/comm/uart_wrapper.c  .generated_files/flags/default/337b39e2b7c46766cb2f9ef3c4cd6e7c6c7e3585 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/uart_wrapper.c  -o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o: ../src/diag/diagnostics_x2cscope.c  .generated_files/flags/default/3c4d6e1fdb201874bc8952f6c137a132a2a0e113 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019379675" 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/diag/diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/estim.o: ../src/foc/estim.c  .generated_files/flags/default/e5edaa8a82496fd7cf153c18106538b756427445 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/estim.c  -o ${OBJECTDIR}/_ext/659855552/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/estim.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/fdweak.o: ../src/foc/fdweak.c  .generated_files/flags/default/24126eb4d8630cb3ca7bb6e5b84bf16e40aa15ce .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/fdweak.c  -o ${OBJECTDIR}/_ext/659855552/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/fdweak.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/singleshunt.o: ../src/foc/singleshunt.c  .generated_files/flags/default/864e4925ab92d1898bd22071922e60ba0502971c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/singleshunt.c  -o ${OBJECTDIR}/_ext/659855552/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/singleshunt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/adc.o: ../src/hal/adc.c  .generated_files/flags/default/730c23196d9fef0c001d581f19894e93dd1b85c1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/adc.c  -o ${OBJECTDIR}/_ext/659857049/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/adc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/board_service.o: ../src/hal/board_service.c  .generated_files/flags/default/cc1382c14621c1c7c0d94c8dd2b3519065127817 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/board_service.c  -o ${OBJECTDIR}/_ext/659857049/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/board_service.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/clock.o: ../src/hal/clock.c  .generated_files/flags/default/d6a54da01a3b7b249b3021da2e0c81fad30c3d70 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/clock.c  -o ${OBJECTDIR}/_ext/659857049/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/port_config.o: ../src/hal/port_config.c  .generated_files/flags/default/36be6b0c585b14cb8eaa169448ef973133f9c235 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/port_config.c  -o ${OBJECTDIR}/_ext/659857049/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/port_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/pwm.o: ../src/hal/pwm.c  .generated_files/flags/default/a9f33cdc829341823946cc34081dcca568583ad8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/pwm.c  -o ${OBJECTDIR}/_ext/659857049/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/pwm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart1.o: ../src/hal/uart1.c  .generated_files/flags/default/db9cfaa6d87ca7b0b008889930d875165bd15bc8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart1.c  -o ${OBJECTDIR}/_ext/659857049/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/measure.o: ../src/hal/measure.c  .generated_files/flags/default/ff9ea961649613d44120b0a6d620163f33502f1c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/measure.c  -o ${OBJECTDIR}/_ext/659857049/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/measure.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/cmp.o: ../src/hal/cmp.c  .generated_files/flags/default/e80c92cd985d4889c7ca4d603f57f938c46c472b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/cmp.c  -o ${OBJECTDIR}/_ext/659857049/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/cmp.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/device_config.o: ../src/hal/device_config.c  .generated_files/flags/default/327c33829fab72b5e4f236c629952f019a38abf8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/device_config.c  -o ${OBJECTDIR}/_ext/659857049/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/device_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/interrupt.o: ../src/hal/interrupt.c  .generated_files/flags/default/27b36e4d554141a65d214c7226274af4602dcf7d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/interrupt.c  -o ${OBJECTDIR}/_ext/659857049/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/interrupt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart2.o: ../src/hal/uart2.c  .generated_files/flags/default/977f6686e4b8b9bfb4b272b7c0fa89d1db6966ae .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart2.c  -o ${OBJECTDIR}/_ext/659857049/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart2.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/timer1.o: ../src/hal/timer1.c  .generated_files/flags/default/7f38b020998da74d128609d596dd7b70f8a9a0da .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/timer1.c  -o ${OBJECTDIR}/_ext/659857049/timer1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/timer1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/timer2.o: ../src/hal/timer2.c  .generated_files/flags/default/b2469a61a9dc5fe20d089ca7ee71f09f7a8197e1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer2.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/timer2.c  -o ${OBJECTDIR}/_ext/659857049/timer2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/timer2.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/tasks.o: ../lib/freertos/tasks.c  .generated_files/flags/default/8af729dfef39d94c886813e0c4b9ad31b20efe46 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/tasks.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/tasks.c  -o ${OBJECTDIR}/_ext/924769355/tasks.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/tasks.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/queue.o: ../lib/freertos/queue.c  .generated_files/flags/default/df1d89c2e34f943adfd2483f262f8fe073e897ab .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/queue.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/queue.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/queue.c  -o ${OBJECTDIR}/_ext/924769355/queue.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/queue.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/list.o: ../lib/freertos/list.c  .generated_files/flags/default/2a671feff478c0013c099ed5b0d588d7eeb3ec3e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/list.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/list.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/list.c  -o ${OBJECTDIR}/_ext/924769355/list.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/list.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/timers.o: ../lib/freertos/timers.c  .generated_files/flags/default/770edca8662f1e80a8a8269e4b72b7b1b5094630 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/timers.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/timers.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/timers.c  -o ${OBJECTDIR}/_ext/924769355/timers.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/timers.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/event_groups.o: ../lib/freertos/event_groups.c  .generated_files/flags/default/d89ed0840a856bde9d4847a545c741ebdcd38f9b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/event_groups.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/event_groups.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/event_groups.c  -o ${OBJECTDIR}/_ext/924769355/event_groups.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/event_groups.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/924769355/stream_buffer.o: ../lib/freertos/stream_buffer.c  .generated_files/flags/default/e2b15701cd300a3c2f8bb48527315d1fc9c9ce66 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/924769355" 
	@${RM} ${OBJECTDIR}/_ext/924769355/stream_buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/924769355/stream_buffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/stream_buffer.c  -o ${OBJECTDIR}/_ext/924769355/stream_buffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/924769355/stream_buffer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/246599827/port.o: ../lib/freertos/portable/MPLAB/PIC24_dsPIC/port.c  .generated_files/flags/default/40d4dd54fe75094d4742e335593b55d86ed537ae .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/246599827" 
	@${RM} ${OBJECTDIR}/_ext/246599827/port.o.d 
	@${RM} ${OBJECTDIR}/_ext/246599827/port.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/portable/MPLAB/PIC24_dsPIC/port.c  -o ${OBJECTDIR}/_ext/246599827/port.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/246599827/port.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1625629234/heap_4.o: ../lib/freertos/portable/MemMang/heap_4.c  .generated_files/flags/default/d0314e7e13b4820719118f40a8b027ce33b999c8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1625629234" 
	@${RM} ${OBJECTDIR}/_ext/1625629234/heap_4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1625629234/heap_4.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../lib/freertos/portable/MemMang/heap_4.c  -o ${OBJECTDIR}/_ext/1625629234/heap_4.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1625629234/heap_4.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_control.o: ../src/motor/motor_control.c  .generated_files/flags/default/f0477d8c90aaa65d4fd6fea867f5c3607db698ca .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_control.c  -o ${OBJECTDIR}/_ext/1527489797/motor_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_control.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_speed.o: ../src/motor/motor_speed.c  .generated_files/flags/default/b0f6a7bddc1b709a86e7f0c5fce2b948d5901378 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_speed.c  -o ${OBJECTDIR}/_ext/1527489797/motor_speed.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_speed.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_statemachine.o: ../src/motor/motor_statemachine.c  .generated_files/flags/default/2ccc90cf40bb20d81bd0673164f6e3bb020b77ea .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_statemachine.c  -o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_blinker.o: ../src/ui/led_blinker.c  .generated_files/flags/default/5523f979741df05e3041751984e0abcafbc16b99 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_blinker.c  -o ${OBJECTDIR}/_ext/809997874/led_blinker.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_blinker.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o: ../src/ui/led_blinker_cfg.c  .generated_files/flags/default/65fe237d60498a13959417f3e3fd303bc9459055 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_blinker_cfg.c  -o ${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_blinker_cfg.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_blinker_drv.o: ../src/ui/led_blinker_drv.c  .generated_files/flags/default/d152b82431c8ee3ca1eda9ee534f7b1af0dff567 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_blinker_drv.c  -o ${OBJECTDIR}/_ext/809997874/led_blinker_drv.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_blinker_drv.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/led_morse.o: ../src/ui/led_morse.c  .generated_files/flags/default/fa5b61d95b5b310750e512ca9dc0a612fae15a9f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_morse.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/led_morse.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/led_morse.c  -o ${OBJECTDIR}/_ext/809997874/led_morse.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/led_morse.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1018862404/ring_buffer.o: ../src/util/ring_buffer.c  .generated_files/flags/default/76c080c3c0283512dc79f7af5a7de12ff1db2ab8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1018862404" 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/util/ring_buffer.c  -o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/pmsm.o: ../src/pmsm.c  .generated_files/flags/default/6db5176eb87a660be8f844911259dc9c29f77922 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/pmsm.c  -o ${OBJECTDIR}/_ext/1360937237/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/pmsm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/616499158/Build_info.o: D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  .generated_files/flags/default/50e28efef99a8910595082f16e672bdbad7eb24f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/616499158" 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o.d 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  -o ${OBJECTDIR}/_ext/616499158/Build_info.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/616499158/Build_info.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o: ../lib/motor_control/mc_clarke_dspic.s  .generated_files/flags/default/6f40848a34180cec55a001fc622302643f445083 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_clarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o: ../lib/motor_control/mc_invclarke_dspic.s  .generated_files/flags/default/cc533982b5cd85014c38b23828b27bb1ae8e6ddc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invclarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o: ../lib/motor_control/mc_invpark_dspic.s  .generated_files/flags/default/9d0c15acadcf21ffd34dd68ada5c62088a561f40 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invpark_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_park_dspic.o: ../lib/motor_control/mc_park_dspic.s  .generated_files/flags/default/adacba646f0619a7ff274ac0e4c4af29184e70f9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_park_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o: ../lib/motor_control/mc_piupdate_dspic.s  .generated_files/flags/default/2d69e9c3320288c4125ecb820d478b9c9f316069 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_piupdate_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o: ../lib/motor_control/mc_sinecos_ram_dspic.s  .generated_files/flags/default/8024138f742a978a23bb59ff2008687672366111 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinecos_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o: ../lib/motor_control/mc_sinetable_flash_dspic.s  .generated_files/flags/default/a5f7ab5cb4592f34dac0cec365aa3ca0632eb2c3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_flash_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o: ../lib/motor_control/mc_sinetable_ram_dspic.s  .generated_files/flags/default/ba139f30e969660fc6d8e53d26e26dd0d4473dd3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o: ../lib/motor_control/mc_svgen_dspic.s  .generated_files/flags/default/8c0502e4a8b659cd526ac0bdd06a0ea098baaa9e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_svgen_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o: ../lib/motor_control/mc_clarke_dspic.s  .generated_files/flags/default/a7f12c80f8ac1117885718bacd9ed94388341f05 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_clarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o: ../lib/motor_control/mc_invclarke_dspic.s  .generated_files/flags/default/d7396e92a0003313680e726b082090fbe08f3520 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invclarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o: ../lib/motor_control/mc_invpark_dspic.s  .generated_files/flags/default/c360850ad859faaccbf409b57284b23cbf822aa3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invpark_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_park_dspic.o: ../lib/motor_control/mc_park_dspic.s  .generated_files/flags/default/3755e8c7718d5916da3f9f63c208a8586cd5b20 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_park_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o: ../lib/motor_control/mc_piupdate_dspic.s  .generated_files/flags/default/34840f10236451e150473ed4818dd14bb28ae5a6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_piupdate_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o: ../lib/motor_control/mc_sinecos_ram_dspic.s  .generated_files/flags/default/ad65b78d54e38aa4b33e7939d234e3027b69cb6c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinecos_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o: ../lib/motor_control/mc_sinetable_flash_dspic.s  .generated_files/flags/default/748f3dcdc569880b990159193fec45268a153482 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_flash_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o: ../lib/motor_control/mc_sinetable_ram_dspic.s  .generated_files/flags/default/cc450748d264aaf8d26af81917e6cb8183aa5a33 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o: ../lib/motor_control/mc_svgen_dspic.s  .generated_files/flags/default/e2804a5d307319104d669fe81f44562ea348b052 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_svgen_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/246599827/portasm_PIC24.o: ../lib/freertos/portable/MPLAB/PIC24_dsPIC/portasm_PIC24.S  .generated_files/flags/default/249b4f8b54e0d7a3495acecd18f04b4de3208a90 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/246599827" 
	@${RM} ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.d 
	@${RM} ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/freertos/portable/MPLAB/PIC24_dsPIC/portasm_PIC24.S  -o ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.d"  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.asm.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/246599827/portasm_PIC24.o: ../lib/freertos/portable/MPLAB/PIC24_dsPIC/portasm_PIC24.S  .generated_files/flags/default/ec8ebf8d9738aa5f744ca55f02d45c2b591632b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/246599827" 
	@${RM} ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.d 
	@${RM} ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/freertos/portable/MPLAB/PIC24_dsPIC/portasm_PIC24.S  -o ${OBJECTDIR}/_ext/246599827/portasm_PIC24.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.d"  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -I"../lib/freertos/include" -I"../lib/freertos/portable/MPLAB/PIC24_dsPIC" -I"../src/config" -Wa,-MD,"${OBJECTDIR}/_ext/246599827/portasm_PIC24.o.asm.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x1000:0x101B -mreserve=data@0x101C:0x101D -mreserve=data@0x101E:0x101F -mreserve=data@0x1020:0x1021 -mreserve=data@0x1022:0x1023 -mreserve=data@0x1024:0x1027 -mreserve=data@0x1028:0x104F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library=q,--library=x2cscope-33ck,--library-path="../lib/x2c_scope",--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	
else
${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library=q,--library=x2cscope-33ck,--library-path="../lib/x2c_scope",--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  -mdfp="${DFP_DIR}/xc16" 
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   -mdfp="${DFP_DIR}/xc16" 
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
