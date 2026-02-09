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
SOURCEFILES_QUOTED_IF_SPACED=../src/comm/Communication.c ../src/comm/command_handler.c ../src/comm/protocol_adapter.c ../src/comm/uart_wrapper.c ../src/diag/diagnostics_x2cscope.c ../src/foc/estim.c ../src/foc/fdweak.c ../src/foc/singleshunt.c ../src/hal/adc.c ../src/hal/board_service.c ../src/hal/clock.c ../src/hal/port_config.c ../src/hal/pwm.c ../src/hal/uart1.c ../src/hal/measure.c ../src/hal/cmp.c ../src/hal/device_config.c ../src/hal/interrupt.c ../src/hal/uart2.c ../src/hal/timer1.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../src/motor/motor_control.c ../src/motor/motor_speed.c ../src/motor/motor_statemachine.c ../src/ui/Status_LED.c ../src/util/ring_buffer.c ../src/pmsm.c D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1019403322/Communication.o ${OBJECTDIR}/_ext/1019403322/command_handler.o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/659855552/estim.o ${OBJECTDIR}/_ext/659855552/fdweak.o ${OBJECTDIR}/_ext/659855552/singleshunt.o ${OBJECTDIR}/_ext/659857049/adc.o ${OBJECTDIR}/_ext/659857049/board_service.o ${OBJECTDIR}/_ext/659857049/clock.o ${OBJECTDIR}/_ext/659857049/port_config.o ${OBJECTDIR}/_ext/659857049/pwm.o ${OBJECTDIR}/_ext/659857049/uart1.o ${OBJECTDIR}/_ext/659857049/measure.o ${OBJECTDIR}/_ext/659857049/cmp.o ${OBJECTDIR}/_ext/659857049/device_config.o ${OBJECTDIR}/_ext/659857049/interrupt.o ${OBJECTDIR}/_ext/659857049/uart2.o ${OBJECTDIR}/_ext/659857049/timer1.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1527489797/motor_control.o ${OBJECTDIR}/_ext/1527489797/motor_speed.o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o ${OBJECTDIR}/_ext/809997874/Status_LED.o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o ${OBJECTDIR}/_ext/1360937237/pmsm.o ${OBJECTDIR}/_ext/616499158/Build_info.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1019403322/Communication.o.d ${OBJECTDIR}/_ext/1019403322/command_handler.o.d ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d ${OBJECTDIR}/_ext/659855552/estim.o.d ${OBJECTDIR}/_ext/659855552/fdweak.o.d ${OBJECTDIR}/_ext/659855552/singleshunt.o.d ${OBJECTDIR}/_ext/659857049/adc.o.d ${OBJECTDIR}/_ext/659857049/board_service.o.d ${OBJECTDIR}/_ext/659857049/clock.o.d ${OBJECTDIR}/_ext/659857049/port_config.o.d ${OBJECTDIR}/_ext/659857049/pwm.o.d ${OBJECTDIR}/_ext/659857049/uart1.o.d ${OBJECTDIR}/_ext/659857049/measure.o.d ${OBJECTDIR}/_ext/659857049/cmp.o.d ${OBJECTDIR}/_ext/659857049/device_config.o.d ${OBJECTDIR}/_ext/659857049/interrupt.o.d ${OBJECTDIR}/_ext/659857049/uart2.o.d ${OBJECTDIR}/_ext/659857049/timer1.o.d ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d ${OBJECTDIR}/_ext/1527489797/motor_control.o.d ${OBJECTDIR}/_ext/1527489797/motor_speed.o.d ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d ${OBJECTDIR}/_ext/809997874/Status_LED.o.d ${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d ${OBJECTDIR}/_ext/1360937237/pmsm.o.d ${OBJECTDIR}/_ext/616499158/Build_info.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1019403322/Communication.o ${OBJECTDIR}/_ext/1019403322/command_handler.o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/659855552/estim.o ${OBJECTDIR}/_ext/659855552/fdweak.o ${OBJECTDIR}/_ext/659855552/singleshunt.o ${OBJECTDIR}/_ext/659857049/adc.o ${OBJECTDIR}/_ext/659857049/board_service.o ${OBJECTDIR}/_ext/659857049/clock.o ${OBJECTDIR}/_ext/659857049/port_config.o ${OBJECTDIR}/_ext/659857049/pwm.o ${OBJECTDIR}/_ext/659857049/uart1.o ${OBJECTDIR}/_ext/659857049/measure.o ${OBJECTDIR}/_ext/659857049/cmp.o ${OBJECTDIR}/_ext/659857049/device_config.o ${OBJECTDIR}/_ext/659857049/interrupt.o ${OBJECTDIR}/_ext/659857049/uart2.o ${OBJECTDIR}/_ext/659857049/timer1.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1527489797/motor_control.o ${OBJECTDIR}/_ext/1527489797/motor_speed.o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o ${OBJECTDIR}/_ext/809997874/Status_LED.o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o ${OBJECTDIR}/_ext/1360937237/pmsm.o ${OBJECTDIR}/_ext/616499158/Build_info.o

# Source Files
SOURCEFILES=../src/comm/Communication.c ../src/comm/command_handler.c ../src/comm/protocol_adapter.c ../src/comm/uart_wrapper.c ../src/diag/diagnostics_x2cscope.c ../src/foc/estim.c ../src/foc/fdweak.c ../src/foc/singleshunt.c ../src/hal/adc.c ../src/hal/board_service.c ../src/hal/clock.c ../src/hal/port_config.c ../src/hal/pwm.c ../src/hal/uart1.c ../src/hal/measure.c ../src/hal/cmp.c ../src/hal/device_config.c ../src/hal/interrupt.c ../src/hal/uart2.c ../src/hal/timer1.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../src/motor/motor_control.c ../src/motor/motor_speed.c ../src/motor/motor_statemachine.c ../src/ui/Status_LED.c ../src/util/ring_buffer.c ../src/pmsm.c D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c



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
${OBJECTDIR}/_ext/1019403322/Communication.o: ../src/comm/Communication.c  .generated_files/flags/default/8cbb27a63f83954a800598297847810e96bd9a0b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/Communication.c  -o ${OBJECTDIR}/_ext/1019403322/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/Communication.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/command_handler.o: ../src/comm/command_handler.c  .generated_files/flags/default/e0d539486d48ee633f92259a986733ccf513c46a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/command_handler.c  -o ${OBJECTDIR}/_ext/1019403322/command_handler.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/command_handler.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/protocol_adapter.o: ../src/comm/protocol_adapter.c  .generated_files/flags/default/eb5021ebf488dedf6f4ffecaec3d731fedbe7f7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/protocol_adapter.c  -o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/uart_wrapper.o: ../src/comm/uart_wrapper.c  .generated_files/flags/default/4dc005cf8cab09d9c4e835c1a012f93c48cc36e0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/uart_wrapper.c  -o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o: ../src/diag/diagnostics_x2cscope.c  .generated_files/flags/default/edb1459dbb5823e79f1ddb252dc50f27c302ad36 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019379675" 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/diag/diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/estim.o: ../src/foc/estim.c  .generated_files/flags/default/85f7c581f4ab996d2e7cfd783461b168b1c52b59 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/estim.c  -o ${OBJECTDIR}/_ext/659855552/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/estim.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/fdweak.o: ../src/foc/fdweak.c  .generated_files/flags/default/1f2794c8372ff8697a64a09bbddc491daf150b50 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/fdweak.c  -o ${OBJECTDIR}/_ext/659855552/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/fdweak.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/singleshunt.o: ../src/foc/singleshunt.c  .generated_files/flags/default/9c0659da2490df594348141eef1128a54dc3a293 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/singleshunt.c  -o ${OBJECTDIR}/_ext/659855552/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/singleshunt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/adc.o: ../src/hal/adc.c  .generated_files/flags/default/9266658653cfac70cacd656e039c786fc7180c90 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/adc.c  -o ${OBJECTDIR}/_ext/659857049/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/adc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/board_service.o: ../src/hal/board_service.c  .generated_files/flags/default/f07ffad7c822ee8f6ff5d020bf79d62112260b6d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/board_service.c  -o ${OBJECTDIR}/_ext/659857049/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/board_service.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/clock.o: ../src/hal/clock.c  .generated_files/flags/default/b5a00dec12c521201480355465e2f9905ea29180 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/clock.c  -o ${OBJECTDIR}/_ext/659857049/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/clock.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/port_config.o: ../src/hal/port_config.c  .generated_files/flags/default/ec1ff0ed133241afd09a7e150409997c6d3fd858 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/port_config.c  -o ${OBJECTDIR}/_ext/659857049/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/port_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/pwm.o: ../src/hal/pwm.c  .generated_files/flags/default/42ca7650e141b505fafd3d4694604e394ca11012 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/pwm.c  -o ${OBJECTDIR}/_ext/659857049/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/pwm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart1.o: ../src/hal/uart1.c  .generated_files/flags/default/652bf150a3f6047e3b5fe3acf385c18a2b396bbf .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart1.c  -o ${OBJECTDIR}/_ext/659857049/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart1.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/measure.o: ../src/hal/measure.c  .generated_files/flags/default/943a884b88cb5d1914cb446498244c666c7c3286 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/measure.c  -o ${OBJECTDIR}/_ext/659857049/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/measure.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/cmp.o: ../src/hal/cmp.c  .generated_files/flags/default/66ad18e4127cc3bb247a276a77c7104c8b9c97b2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/cmp.c  -o ${OBJECTDIR}/_ext/659857049/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/cmp.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/device_config.o: ../src/hal/device_config.c  .generated_files/flags/default/762b8154692dbd4d3b97192cb76c437463374c3a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/device_config.c  -o ${OBJECTDIR}/_ext/659857049/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/device_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/interrupt.o: ../src/hal/interrupt.c  .generated_files/flags/default/2e47cb6f36e7c1d599f1c04939f249e889966550 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/interrupt.c  -o ${OBJECTDIR}/_ext/659857049/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/interrupt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart2.o: ../src/hal/uart2.c  .generated_files/flags/default/65de00ea205b03f33d6388388ecb17f799a52955 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart2.c  -o ${OBJECTDIR}/_ext/659857049/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart2.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/timer1.o: ../src/hal/timer1.c  .generated_files/flags/default/42158467827dd77865245bcc742b88acd4b12559 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/timer1.c  -o ${OBJECTDIR}/_ext/659857049/timer1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/timer1.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_control.o: ../src/motor/motor_control.c  .generated_files/flags/default/d61b8b9d50669725dba0e289e9044b72f60f810e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_control.c  -o ${OBJECTDIR}/_ext/1527489797/motor_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_control.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_speed.o: ../src/motor/motor_speed.c  .generated_files/flags/default/7a233c81df1d8105285de2d3f7da321ed454062 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_speed.c  -o ${OBJECTDIR}/_ext/1527489797/motor_speed.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_speed.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_statemachine.o: ../src/motor/motor_statemachine.c  .generated_files/flags/default/a2a73ba7c31776bc73ef5ac2fe16320ab20b5b41 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_statemachine.c  -o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/Status_LED.o: ../src/ui/Status_LED.c  .generated_files/flags/default/83daade689f8da886936d7ee18c2cc5d307d913c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/Status_LED.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/Status_LED.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/Status_LED.c  -o ${OBJECTDIR}/_ext/809997874/Status_LED.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/Status_LED.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1018862404/ring_buffer.o: ../src/util/ring_buffer.c  .generated_files/flags/default/6dcdda70e207ce0472c96d135454df50bc6e7c27 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1018862404" 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/util/ring_buffer.c  -o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/pmsm.o: ../src/pmsm.c  .generated_files/flags/default/d295a8dc1619e0268b605da6e87e4c63860c0bf2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/pmsm.c  -o ${OBJECTDIR}/_ext/1360937237/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/pmsm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/616499158/Build_info.o: D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  .generated_files/flags/default/76afe4dc4013066b331566e1045125944560e537 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/616499158" 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o.d 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  -o ${OBJECTDIR}/_ext/616499158/Build_info.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/616499158/Build_info.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1019403322/Communication.o: ../src/comm/Communication.c  .generated_files/flags/default/8851f720db8b7b899f8c98ff6f1745c90b74f30c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/Communication.c  -o ${OBJECTDIR}/_ext/1019403322/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/Communication.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/command_handler.o: ../src/comm/command_handler.c  .generated_files/flags/default/b043b0dbe05ce93c1b89b1f749624a3bfae10d0f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/command_handler.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/command_handler.c  -o ${OBJECTDIR}/_ext/1019403322/command_handler.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/command_handler.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/protocol_adapter.o: ../src/comm/protocol_adapter.c  .generated_files/flags/default/4fa72c748b294c10ee9c4bef671d45306d59bf32 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/protocol_adapter.c  -o ${OBJECTDIR}/_ext/1019403322/protocol_adapter.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/protocol_adapter.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019403322/uart_wrapper.o: ../src/comm/uart_wrapper.c  .generated_files/flags/default/e00ab9a5b458b5addefca0313743f248788eafc8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019403322" 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/comm/uart_wrapper.c  -o ${OBJECTDIR}/_ext/1019403322/uart_wrapper.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019403322/uart_wrapper.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o: ../src/diag/diagnostics_x2cscope.c  .generated_files/flags/default/e79bf199b490c558bc880ca157dfca97069ae62 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1019379675" 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/diag/diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1019379675/diagnostics_x2cscope.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/estim.o: ../src/foc/estim.c  .generated_files/flags/default/14bc4381dfb213af3236856936117b4ba940521 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/estim.c  -o ${OBJECTDIR}/_ext/659855552/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/estim.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/fdweak.o: ../src/foc/fdweak.c  .generated_files/flags/default/872700695bbe0328e10172587aa4aa5f30b03314 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/fdweak.c  -o ${OBJECTDIR}/_ext/659855552/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/fdweak.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659855552/singleshunt.o: ../src/foc/singleshunt.c  .generated_files/flags/default/73a9b18f28415c749ce85e6676e22c33a1fad00a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659855552" 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659855552/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/foc/singleshunt.c  -o ${OBJECTDIR}/_ext/659855552/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659855552/singleshunt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/adc.o: ../src/hal/adc.c  .generated_files/flags/default/16a4a683de2b743aafedf19896bb7e5c93513ca6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/adc.c  -o ${OBJECTDIR}/_ext/659857049/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/adc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/board_service.o: ../src/hal/board_service.c  .generated_files/flags/default/71c0dd86fc8df1ae3f6dd7cc019529762583fe75 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/board_service.c  -o ${OBJECTDIR}/_ext/659857049/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/board_service.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/clock.o: ../src/hal/clock.c  .generated_files/flags/default/f11c5c348d6edbf4fd3394475bd16a1665f68249 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/clock.c  -o ${OBJECTDIR}/_ext/659857049/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/port_config.o: ../src/hal/port_config.c  .generated_files/flags/default/7128fb6fa5c52f1879fc1d1b5700e6751da4b467 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/port_config.c  -o ${OBJECTDIR}/_ext/659857049/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/port_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/pwm.o: ../src/hal/pwm.c  .generated_files/flags/default/7a44aa5a88530d663f9fc228facb671e66145ef4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/pwm.c  -o ${OBJECTDIR}/_ext/659857049/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/pwm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart1.o: ../src/hal/uart1.c  .generated_files/flags/default/d3a6ed183e2d340ccb728ef78706e57320a6be43 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart1.c  -o ${OBJECTDIR}/_ext/659857049/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/measure.o: ../src/hal/measure.c  .generated_files/flags/default/42253ef6e3dfdcc72af73451003cff379cbac4ac .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/measure.c  -o ${OBJECTDIR}/_ext/659857049/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/measure.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/cmp.o: ../src/hal/cmp.c  .generated_files/flags/default/d0ae3136399b373f52fa069ad838fb1dc9be4458 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/cmp.c  -o ${OBJECTDIR}/_ext/659857049/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/cmp.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/device_config.o: ../src/hal/device_config.c  .generated_files/flags/default/c333c1e32a651e0e3f5ac067d4a539323fd6b198 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/device_config.c  -o ${OBJECTDIR}/_ext/659857049/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/device_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/interrupt.o: ../src/hal/interrupt.c  .generated_files/flags/default/5a813f8585cef3c50fa5b75cb16d4c68c702fa3f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/interrupt.c  -o ${OBJECTDIR}/_ext/659857049/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/interrupt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/uart2.o: ../src/hal/uart2.c  .generated_files/flags/default/34da0607e9803a5d028ca58636f3e5214e16f82a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/uart2.c  -o ${OBJECTDIR}/_ext/659857049/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/uart2.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/659857049/timer1.o: ../src/hal/timer1.c  .generated_files/flags/default/b3977a6b2c8e64c7990c4c34920b61f49146d143 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/659857049" 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o.d 
	@${RM} ${OBJECTDIR}/_ext/659857049/timer1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/hal/timer1.c  -o ${OBJECTDIR}/_ext/659857049/timer1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/659857049/timer1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_control.o: ../src/motor/motor_control.c  .generated_files/flags/default/8f42ab81d6e30f762ceb18ca6f5b0e5a7090b33e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_control.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_control.c  -o ${OBJECTDIR}/_ext/1527489797/motor_control.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_control.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_speed.o: ../src/motor/motor_speed.c  .generated_files/flags/default/4591b39893b9bd3716a93560cabd71c8cf856b81 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_speed.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_speed.c  -o ${OBJECTDIR}/_ext/1527489797/motor_speed.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_speed.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1527489797/motor_statemachine.o: ../src/motor/motor_statemachine.c  .generated_files/flags/default/48dc7b59be46a6a02f9a0511717b1486b9019ae6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1527489797" 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d 
	@${RM} ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/motor/motor_statemachine.c  -o ${OBJECTDIR}/_ext/1527489797/motor_statemachine.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1527489797/motor_statemachine.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/809997874/Status_LED.o: ../src/ui/Status_LED.c  .generated_files/flags/default/f1439cb76fb3b308fe013b3c029658a967c220a5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/809997874" 
	@${RM} ${OBJECTDIR}/_ext/809997874/Status_LED.o.d 
	@${RM} ${OBJECTDIR}/_ext/809997874/Status_LED.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/ui/Status_LED.c  -o ${OBJECTDIR}/_ext/809997874/Status_LED.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/809997874/Status_LED.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1018862404/ring_buffer.o: ../src/util/ring_buffer.c  .generated_files/flags/default/a5cda7d8bc9ea9fb66a49727faa1e61ca3d82820 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1018862404" 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d 
	@${RM} ${OBJECTDIR}/_ext/1018862404/ring_buffer.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/util/ring_buffer.c  -o ${OBJECTDIR}/_ext/1018862404/ring_buffer.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1018862404/ring_buffer.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360937237/pmsm.o: ../src/pmsm.c  .generated_files/flags/default/783b556b407655d8eab5777d688f02259cc225dc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../src/pmsm.c  -o ${OBJECTDIR}/_ext/1360937237/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/pmsm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/616499158/Build_info.o: D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  .generated_files/flags/default/c938e0048fd5ab1f348e0a07bfd73187b2c2b320 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/616499158" 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o.d 
	@${RM} ${OBJECTDIR}/_ext/616499158/Build_info.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/src/Build_info.c  -o ${OBJECTDIR}/_ext/616499158/Build_info.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/616499158/Build_info.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../src" -I"../src/hal" -I"../src/foc" -I"../src/motor" -I"../src/comm" -I"../src/util" -I"../src/ui" -I"../src/diag" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o: ../lib/motor_control/mc_clarke_dspic.s  .generated_files/flags/default/8892cb4b9de258d403d43283b5e85aaa550c0a6a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_clarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o: ../lib/motor_control/mc_invclarke_dspic.s  .generated_files/flags/default/c7ee55f992893e1feb8b3c208b5753ad96b06f25 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invclarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o: ../lib/motor_control/mc_invpark_dspic.s  .generated_files/flags/default/d4024ae0e8acdc88374d80ec716a57a530936df0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invpark_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_park_dspic.o: ../lib/motor_control/mc_park_dspic.s  .generated_files/flags/default/2ae8fd2a64f3b94aeb38f78e771ed6fac3015036 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_park_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o: ../lib/motor_control/mc_piupdate_dspic.s  .generated_files/flags/default/feb035fe01b74bc2a329c89d0505a27320d262 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_piupdate_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o: ../lib/motor_control/mc_sinecos_ram_dspic.s  .generated_files/flags/default/3a36ea6afedb44e405f4dd5fc9ce51700815e3c4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinecos_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o: ../lib/motor_control/mc_sinetable_flash_dspic.s  .generated_files/flags/default/f569b89deb2f9128b5ebdc8d30fab3cf33219317 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_flash_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o: ../lib/motor_control/mc_sinetable_ram_dspic.s  .generated_files/flags/default/8c6b7edb5b3ba1fe9d2ac5a4015acd5989556133 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o: ../lib/motor_control/mc_svgen_dspic.s  .generated_files/flags/default/4ca03edd22c46dd3981b3f87553b619b114baeb8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_svgen_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o: ../lib/motor_control/mc_clarke_dspic.s  .generated_files/flags/default/563f562b80247964ccc960ce864df139f1d91e6f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_clarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o: ../lib/motor_control/mc_invclarke_dspic.s  .generated_files/flags/default/d570bdc9d7071b8e11895af88ab0b79a3feaa64c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invclarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o: ../lib/motor_control/mc_invpark_dspic.s  .generated_files/flags/default/234b09c29a222193febb5f2d4f8bbf3e97fa1808 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invpark_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_park_dspic.o: ../lib/motor_control/mc_park_dspic.s  .generated_files/flags/default/e9baf8ab17fe6e8ac35ac8640e922c5b6eba6e8b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_park_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o: ../lib/motor_control/mc_piupdate_dspic.s  .generated_files/flags/default/88dcbba585299df0883f0bd42f05552e9bccaa64 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_piupdate_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o: ../lib/motor_control/mc_sinecos_ram_dspic.s  .generated_files/flags/default/3e1bf27d247d748ca8f20ac3cf17cb7855855fae .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinecos_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o: ../lib/motor_control/mc_sinetable_flash_dspic.s  .generated_files/flags/default/38dca6d8354933ecd6d46c5057e98ef6eec78630 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_flash_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o: ../lib/motor_control/mc_sinetable_ram_dspic.s  .generated_files/flags/default/e263268ed1b62bb2d60cc3561cf4fd192d8d7bd9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o: ../lib/motor_control/mc_svgen_dspic.s  .generated_files/flags/default/9a4ca380853b430bc1917f8821d07472fd7110b2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_svgen_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST)  -mdfp="${DFP_DIR}/xc16"
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemblePreproc
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
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
