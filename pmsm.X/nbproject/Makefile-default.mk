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
SOURCEFILES_QUOTED_IF_SPACED=../hal/adc.c ../hal/board_service.c ../hal/clock.c ../hal/port_config.c ../hal/pwm.c ../hal/uart1.c ../hal/measure.c ../hal/cmp.c ../hal/device_config.c ../hal/interrupt.c ../hal/uart2.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../estim.c ../fdweak.c ../pmsm.c ../diagnostics_x2cscope.c ../singleshunt.c ../Communication.c ../Status_LED.c D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/Build_info.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1360926148/adc.o ${OBJECTDIR}/_ext/1360926148/board_service.o ${OBJECTDIR}/_ext/1360926148/clock.o ${OBJECTDIR}/_ext/1360926148/port_config.o ${OBJECTDIR}/_ext/1360926148/pwm.o ${OBJECTDIR}/_ext/1360926148/uart1.o ${OBJECTDIR}/_ext/1360926148/measure.o ${OBJECTDIR}/_ext/1360926148/cmp.o ${OBJECTDIR}/_ext/1360926148/device_config.o ${OBJECTDIR}/_ext/1360926148/interrupt.o ${OBJECTDIR}/_ext/1360926148/uart2.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1472/estim.o ${OBJECTDIR}/_ext/1472/fdweak.o ${OBJECTDIR}/_ext/1472/pmsm.o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/1472/singleshunt.o ${OBJECTDIR}/_ext/1472/Communication.o ${OBJECTDIR}/_ext/1472/Status_LED.o ${OBJECTDIR}/_ext/589590699/Build_info.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1360926148/adc.o.d ${OBJECTDIR}/_ext/1360926148/board_service.o.d ${OBJECTDIR}/_ext/1360926148/clock.o.d ${OBJECTDIR}/_ext/1360926148/port_config.o.d ${OBJECTDIR}/_ext/1360926148/pwm.o.d ${OBJECTDIR}/_ext/1360926148/uart1.o.d ${OBJECTDIR}/_ext/1360926148/measure.o.d ${OBJECTDIR}/_ext/1360926148/cmp.o.d ${OBJECTDIR}/_ext/1360926148/device_config.o.d ${OBJECTDIR}/_ext/1360926148/interrupt.o.d ${OBJECTDIR}/_ext/1360926148/uart2.o.d ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d ${OBJECTDIR}/_ext/1472/estim.o.d ${OBJECTDIR}/_ext/1472/fdweak.o.d ${OBJECTDIR}/_ext/1472/pmsm.o.d ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d ${OBJECTDIR}/_ext/1472/singleshunt.o.d ${OBJECTDIR}/_ext/1472/Communication.o.d ${OBJECTDIR}/_ext/1472/Status_LED.o.d ${OBJECTDIR}/_ext/589590699/Build_info.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1360926148/adc.o ${OBJECTDIR}/_ext/1360926148/board_service.o ${OBJECTDIR}/_ext/1360926148/clock.o ${OBJECTDIR}/_ext/1360926148/port_config.o ${OBJECTDIR}/_ext/1360926148/pwm.o ${OBJECTDIR}/_ext/1360926148/uart1.o ${OBJECTDIR}/_ext/1360926148/measure.o ${OBJECTDIR}/_ext/1360926148/cmp.o ${OBJECTDIR}/_ext/1360926148/device_config.o ${OBJECTDIR}/_ext/1360926148/interrupt.o ${OBJECTDIR}/_ext/1360926148/uart2.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1472/estim.o ${OBJECTDIR}/_ext/1472/fdweak.o ${OBJECTDIR}/_ext/1472/pmsm.o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/1472/singleshunt.o ${OBJECTDIR}/_ext/1472/Communication.o ${OBJECTDIR}/_ext/1472/Status_LED.o ${OBJECTDIR}/_ext/589590699/Build_info.o

# Source Files
SOURCEFILES=../hal/adc.c ../hal/board_service.c ../hal/clock.c ../hal/port_config.c ../hal/pwm.c ../hal/uart1.c ../hal/measure.c ../hal/cmp.c ../hal/device_config.c ../hal/interrupt.c ../hal/uart2.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../estim.c ../fdweak.c ../pmsm.c ../diagnostics_x2cscope.c ../singleshunt.c ../Communication.c ../Status_LED.c D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/Build_info.c



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
${OBJECTDIR}/_ext/1360926148/adc.o: ../hal/adc.c  .generated_files/flags/default/60c29f6c313dbd4b91e28f09dafa886357778c19 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/adc.c  -o ${OBJECTDIR}/_ext/1360926148/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/adc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/board_service.o: ../hal/board_service.c  .generated_files/flags/default/498dee12087ce3d603571f700a45eee605afff4f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/board_service.c  -o ${OBJECTDIR}/_ext/1360926148/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/board_service.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/clock.o: ../hal/clock.c  .generated_files/flags/default/a46c70909939886368ce247f90afe4ec23ccee6b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/clock.c  -o ${OBJECTDIR}/_ext/1360926148/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/clock.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/port_config.o: ../hal/port_config.c  .generated_files/flags/default/d8d09d1d9f5f307cf5d3714d6a29049f802cc970 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/port_config.c  -o ${OBJECTDIR}/_ext/1360926148/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/port_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/pwm.o: ../hal/pwm.c  .generated_files/flags/default/453c368b72bd50444c0a890b5a9218bb8f4946c7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/pwm.c  -o ${OBJECTDIR}/_ext/1360926148/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/pwm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/uart1.o: ../hal/uart1.c  .generated_files/flags/default/383138186443e602ee86623d6e7aaa6e6d4bdadd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart1.c  -o ${OBJECTDIR}/_ext/1360926148/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart1.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/measure.o: ../hal/measure.c  .generated_files/flags/default/36d1f741b21085d5640eb81a1ff8fabafa4194ee .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/measure.c  -o ${OBJECTDIR}/_ext/1360926148/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/measure.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/cmp.o: ../hal/cmp.c  .generated_files/flags/default/2c4cb78202974540749f77e24d6721c343338f7a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/cmp.c  -o ${OBJECTDIR}/_ext/1360926148/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/cmp.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/device_config.o: ../hal/device_config.c  .generated_files/flags/default/d08b21539a252b4a2267d9b406c831d145c6ee16 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/device_config.c  -o ${OBJECTDIR}/_ext/1360926148/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/device_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/interrupt.o: ../hal/interrupt.c  .generated_files/flags/default/59a715a5156ecaaeb2753f10ed30d0098d6323ef .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/interrupt.c  -o ${OBJECTDIR}/_ext/1360926148/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/interrupt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/uart2.o: ../hal/uart2.c  .generated_files/flags/default/1296dc6c8e1a0a06262ab21ae4237e341d7eacc6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart2.c  -o ${OBJECTDIR}/_ext/1360926148/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart2.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/estim.o: ../estim.c  .generated_files/flags/default/c1bba50c765c4957572bbb96e5261c87294b8ba .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../estim.c  -o ${OBJECTDIR}/_ext/1472/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/estim.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fdweak.o: ../fdweak.c  .generated_files/flags/default/b28dce45185235ba580340800b4d8aa81c63934e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fdweak.c  -o ${OBJECTDIR}/_ext/1472/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fdweak.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/pmsm.o: ../pmsm.c  .generated_files/flags/default/6f75e8070b02e03f7000af99361393bacd140462 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../pmsm.c  -o ${OBJECTDIR}/_ext/1472/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/pmsm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o: ../diagnostics_x2cscope.c  .generated_files/flags/default/bd33da576d21d8ed6ba03ab639dba9baa00f6a1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/singleshunt.o: ../singleshunt.c  .generated_files/flags/default/e92b0a695365534e0a57cbe2d8df3a6aeb0b44d8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../singleshunt.c  -o ${OBJECTDIR}/_ext/1472/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/singleshunt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/Communication.o: ../Communication.c  .generated_files/flags/default/84d73180099fc7170519cfd8aec4c1126040020a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Communication.c  -o ${OBJECTDIR}/_ext/1472/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Communication.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/Status_LED.o: ../Status_LED.c  .generated_files/flags/default/300e2bbba09316aa2b442574c8a6444f91b22747 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Status_LED.c  -o ${OBJECTDIR}/_ext/1472/Status_LED.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Status_LED.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/589590699/Build_info.o: D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/Build_info.c  .generated_files/flags/default/4919e14b3883b482ea97f628e451a343ab829fdb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/589590699" 
	@${RM} ${OBJECTDIR}/_ext/589590699/Build_info.o.d 
	@${RM} ${OBJECTDIR}/_ext/589590699/Build_info.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/Build_info.c  -o ${OBJECTDIR}/_ext/589590699/Build_info.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/589590699/Build_info.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
else
${OBJECTDIR}/_ext/1360926148/adc.o: ../hal/adc.c  .generated_files/flags/default/dedbe26199ac4566a8e9fd3a46a07f6edc33bc5d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/adc.c  -o ${OBJECTDIR}/_ext/1360926148/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/adc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/board_service.o: ../hal/board_service.c  .generated_files/flags/default/efa5879084a26b17ee783df4b3ea090736b7dcd0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/board_service.c  -o ${OBJECTDIR}/_ext/1360926148/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/board_service.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/clock.o: ../hal/clock.c  .generated_files/flags/default/76bcd84abced44e0cf1a6ef9f782b81c851f284a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/clock.c  -o ${OBJECTDIR}/_ext/1360926148/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/port_config.o: ../hal/port_config.c  .generated_files/flags/default/f5b7dc77b234f7c05040b001cc9b2fd2f73eded6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/port_config.c  -o ${OBJECTDIR}/_ext/1360926148/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/port_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/pwm.o: ../hal/pwm.c  .generated_files/flags/default/e0ff175f1e04c2715e7a57974d58d85e9214aeaa .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/pwm.c  -o ${OBJECTDIR}/_ext/1360926148/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/pwm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/uart1.o: ../hal/uart1.c  .generated_files/flags/default/8ed380196841a517fbce09b0ba5bcad6f2f6d355 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart1.c  -o ${OBJECTDIR}/_ext/1360926148/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/measure.o: ../hal/measure.c  .generated_files/flags/default/1a9c29d2a233c7c6e69cd82617176db96659601e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/measure.c  -o ${OBJECTDIR}/_ext/1360926148/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/measure.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/cmp.o: ../hal/cmp.c  .generated_files/flags/default/9e337e6a49a82493b1bb67f9690fa475b3f2cb4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/cmp.c  -o ${OBJECTDIR}/_ext/1360926148/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/cmp.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/device_config.o: ../hal/device_config.c  .generated_files/flags/default/6cadc9d854a2f9b807ce30092be1ff2dba269da2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/device_config.c  -o ${OBJECTDIR}/_ext/1360926148/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/device_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/interrupt.o: ../hal/interrupt.c  .generated_files/flags/default/7ff64282657d9eda957f902a81bf9bbf8fe3411c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/interrupt.c  -o ${OBJECTDIR}/_ext/1360926148/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/interrupt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1360926148/uart2.o: ../hal/uart2.c  .generated_files/flags/default/51016eb7a6799ba84c2b37666cd8ee869c7576f4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart2.c  -o ${OBJECTDIR}/_ext/1360926148/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart2.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/estim.o: ../estim.c  .generated_files/flags/default/e0ec68ca1e090eaec4ad3d23d9e73ff3789c3c2b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../estim.c  -o ${OBJECTDIR}/_ext/1472/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/estim.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/fdweak.o: ../fdweak.c  .generated_files/flags/default/f74efff51032d2ee8bd1fe5f553daa4ba58049dc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fdweak.c  -o ${OBJECTDIR}/_ext/1472/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fdweak.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/pmsm.o: ../pmsm.c  .generated_files/flags/default/e55953096c39af3ea49d2d35ed986e0438d3ce4c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../pmsm.c  -o ${OBJECTDIR}/_ext/1472/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/pmsm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o: ../diagnostics_x2cscope.c  .generated_files/flags/default/dc2870cabae7ff5791725717efb676261150e1b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/singleshunt.o: ../singleshunt.c  .generated_files/flags/default/f2457d81a138208b52631cba583c020743ff77a3 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../singleshunt.c  -o ${OBJECTDIR}/_ext/1472/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/singleshunt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/Communication.o: ../Communication.c  .generated_files/flags/default/df3d4f2dd41632300072f99c83c722fde5f90d5d .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Communication.c  -o ${OBJECTDIR}/_ext/1472/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Communication.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/1472/Status_LED.o: ../Status_LED.c  .generated_files/flags/default/4cc650f097d41da23fc67ed0d42f826f668d5c02 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Status_LED.c  -o ${OBJECTDIR}/_ext/1472/Status_LED.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Status_LED.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
${OBJECTDIR}/_ext/589590699/Build_info.o: D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/Build_info.c  .generated_files/flags/default/583035789da557f167a5d17f01e651d68f689da4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/589590699" 
	@${RM} ${OBJECTDIR}/_ext/589590699/Build_info.o.d 
	@${RM} ${OBJECTDIR}/_ext/589590699/Build_info.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  D:/Dentium/04_instrument/02_ELMotor_dsPIC/02_Program/AN1292_dsPIC33CK256MP508_ElecLow/Build_info.c  -o ${OBJECTDIR}/_ext/589590699/Build_info.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/589590699/Build_info.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off    -mdfp="${DFP_DIR}/xc16"
	
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
