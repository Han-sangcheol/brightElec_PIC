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
SOURCEFILES_QUOTED_IF_SPACED=../hal/adc.c ../hal/board_service.c ../hal/clock.c ../hal/port_config.c ../hal/pwm.c ../hal/uart1.c ../hal/measure.c ../hal/cmp.c ../hal/device_config.c ../hal/interrupt.c ../hal/uart2.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../estim.c ../fdweak.c ../pmsm.c ../diagnostics_x2cscope.c ../singleshunt.c ../Communication.c ../Status_LED.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1360926148/adc.o ${OBJECTDIR}/_ext/1360926148/board_service.o ${OBJECTDIR}/_ext/1360926148/clock.o ${OBJECTDIR}/_ext/1360926148/port_config.o ${OBJECTDIR}/_ext/1360926148/pwm.o ${OBJECTDIR}/_ext/1360926148/uart1.o ${OBJECTDIR}/_ext/1360926148/measure.o ${OBJECTDIR}/_ext/1360926148/cmp.o ${OBJECTDIR}/_ext/1360926148/device_config.o ${OBJECTDIR}/_ext/1360926148/interrupt.o ${OBJECTDIR}/_ext/1360926148/uart2.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1472/estim.o ${OBJECTDIR}/_ext/1472/fdweak.o ${OBJECTDIR}/_ext/1472/pmsm.o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/1472/singleshunt.o ${OBJECTDIR}/_ext/1472/Communication.o ${OBJECTDIR}/_ext/1472/Status_LED.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1360926148/adc.o.d ${OBJECTDIR}/_ext/1360926148/board_service.o.d ${OBJECTDIR}/_ext/1360926148/clock.o.d ${OBJECTDIR}/_ext/1360926148/port_config.o.d ${OBJECTDIR}/_ext/1360926148/pwm.o.d ${OBJECTDIR}/_ext/1360926148/uart1.o.d ${OBJECTDIR}/_ext/1360926148/measure.o.d ${OBJECTDIR}/_ext/1360926148/cmp.o.d ${OBJECTDIR}/_ext/1360926148/device_config.o.d ${OBJECTDIR}/_ext/1360926148/interrupt.o.d ${OBJECTDIR}/_ext/1360926148/uart2.o.d ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d ${OBJECTDIR}/_ext/1472/estim.o.d ${OBJECTDIR}/_ext/1472/fdweak.o.d ${OBJECTDIR}/_ext/1472/pmsm.o.d ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d ${OBJECTDIR}/_ext/1472/singleshunt.o.d ${OBJECTDIR}/_ext/1472/Communication.o.d ${OBJECTDIR}/_ext/1472/Status_LED.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1360926148/adc.o ${OBJECTDIR}/_ext/1360926148/board_service.o ${OBJECTDIR}/_ext/1360926148/clock.o ${OBJECTDIR}/_ext/1360926148/port_config.o ${OBJECTDIR}/_ext/1360926148/pwm.o ${OBJECTDIR}/_ext/1360926148/uart1.o ${OBJECTDIR}/_ext/1360926148/measure.o ${OBJECTDIR}/_ext/1360926148/cmp.o ${OBJECTDIR}/_ext/1360926148/device_config.o ${OBJECTDIR}/_ext/1360926148/interrupt.o ${OBJECTDIR}/_ext/1360926148/uart2.o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o ${OBJECTDIR}/_ext/1472/estim.o ${OBJECTDIR}/_ext/1472/fdweak.o ${OBJECTDIR}/_ext/1472/pmsm.o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o ${OBJECTDIR}/_ext/1472/singleshunt.o ${OBJECTDIR}/_ext/1472/Communication.o ${OBJECTDIR}/_ext/1472/Status_LED.o

# Source Files
SOURCEFILES=../hal/adc.c ../hal/board_service.c ../hal/clock.c ../hal/port_config.c ../hal/pwm.c ../hal/uart1.c ../hal/measure.c ../hal/cmp.c ../hal/device_config.c ../hal/interrupt.c ../hal/uart2.c ../lib/motor_control/mc_clarke_dspic.s ../lib/motor_control/mc_invclarke_dspic.s ../lib/motor_control/mc_invpark_dspic.s ../lib/motor_control/mc_park_dspic.s ../lib/motor_control/mc_piupdate_dspic.s ../lib/motor_control/mc_sinecos_ram_dspic.s ../lib/motor_control/mc_sinetable_flash_dspic.s ../lib/motor_control/mc_sinetable_ram_dspic.s ../lib/motor_control/mc_svgen_dspic.s ../estim.c ../fdweak.c ../pmsm.c ../diagnostics_x2cscope.c ../singleshunt.c ../Communication.c ../Status_LED.c



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
${OBJECTDIR}/_ext/1360926148/adc.o: ../hal/adc.c  .generated_files/flags/default/8a66606cca23dcdf586668ee51d8a878d09aa2c0 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/adc.c  -o ${OBJECTDIR}/_ext/1360926148/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/adc.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/board_service.o: ../hal/board_service.c  .generated_files/flags/default/a38213f1e4c2012a06518fc464aebc309e6c146b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/board_service.c  -o ${OBJECTDIR}/_ext/1360926148/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/board_service.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/clock.o: ../hal/clock.c  .generated_files/flags/default/833b80df1816c7584d8eaeb1f33371bab2001e7c .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/clock.c  -o ${OBJECTDIR}/_ext/1360926148/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/clock.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/port_config.o: ../hal/port_config.c  .generated_files/flags/default/1b8d0ce6440112bf348be17a4591be4528b9befc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/port_config.c  -o ${OBJECTDIR}/_ext/1360926148/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/port_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/pwm.o: ../hal/pwm.c  .generated_files/flags/default/abf1e35674bb8c55e0575c376c8371885646994e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/pwm.c  -o ${OBJECTDIR}/_ext/1360926148/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/pwm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/uart1.o: ../hal/uart1.c  .generated_files/flags/default/4a079a360fb90035fc7bf7ab4aa0693178ad9488 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart1.c  -o ${OBJECTDIR}/_ext/1360926148/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart1.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/measure.o: ../hal/measure.c  .generated_files/flags/default/afea7603e976a173bdf46eeac0de09fa463bf263 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/measure.c  -o ${OBJECTDIR}/_ext/1360926148/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/measure.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/cmp.o: ../hal/cmp.c  .generated_files/flags/default/f8411b06eda6759b79e8dec6e226d9f8ddb7fd35 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/cmp.c  -o ${OBJECTDIR}/_ext/1360926148/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/cmp.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/device_config.o: ../hal/device_config.c  .generated_files/flags/default/e8d630eb934f8a7b052109ddfce77879421ffdff .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/device_config.c  -o ${OBJECTDIR}/_ext/1360926148/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/device_config.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/interrupt.o: ../hal/interrupt.c  .generated_files/flags/default/27b2399d775ab0f2909a5c0cd8823012c25ed4b6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/interrupt.c  -o ${OBJECTDIR}/_ext/1360926148/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/interrupt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/uart2.o: ../hal/uart2.c  .generated_files/flags/default/9e06553e57ed666462ee57267ca006d815859d16 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart2.c  -o ${OBJECTDIR}/_ext/1360926148/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart2.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/estim.o: ../estim.c  .generated_files/flags/default/562b2473e06f6361788b6711a9367bfc90d7259e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../estim.c  -o ${OBJECTDIR}/_ext/1472/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/estim.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/fdweak.o: ../fdweak.c  .generated_files/flags/default/616b5f6f4979104ff9bc57b72ecdbbae867b9982 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fdweak.c  -o ${OBJECTDIR}/_ext/1472/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fdweak.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/pmsm.o: ../pmsm.c  .generated_files/flags/default/fa971aee7c9030be898b56f517318fe68d4e5f9e .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../pmsm.c  -o ${OBJECTDIR}/_ext/1472/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/pmsm.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o: ../diagnostics_x2cscope.c  .generated_files/flags/default/77212478e545da528d82cb99bfa1366a088c3cd7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/singleshunt.o: ../singleshunt.c  .generated_files/flags/default/5036302a1d3c1373f441f1f3757f5ce992b9eebc .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../singleshunt.c  -o ${OBJECTDIR}/_ext/1472/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/singleshunt.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/Communication.o: ../Communication.c  .generated_files/flags/default/dd5079eb4133c14d9833a2ef29a158addb61a3f8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Communication.c  -o ${OBJECTDIR}/_ext/1472/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Communication.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/Status_LED.o: ../Status_LED.c  .generated_files/flags/default/1b36653c2b3543e0e62b68167d054028bd48d093 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Status_LED.c  -o ${OBJECTDIR}/_ext/1472/Status_LED.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Status_LED.o.d"      -g -D__DEBUG   -mno-eds-warn  -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
else
${OBJECTDIR}/_ext/1360926148/adc.o: ../hal/adc.c  .generated_files/flags/default/c05cde6a40a7b5608cee9ed2c479d48327cad954 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/adc.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/adc.c  -o ${OBJECTDIR}/_ext/1360926148/adc.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/adc.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/board_service.o: ../hal/board_service.c  .generated_files/flags/default/292a8634b2b4b289d289993654c2978598068ac2 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/board_service.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/board_service.c  -o ${OBJECTDIR}/_ext/1360926148/board_service.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/board_service.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/clock.o: ../hal/clock.c  .generated_files/flags/default/2df891841fe403eb59c83913b1b481b13b01c981 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/clock.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/clock.c  -o ${OBJECTDIR}/_ext/1360926148/clock.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/clock.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/port_config.o: ../hal/port_config.c  .generated_files/flags/default/6d2df70d4ddc7cf150f00ccef797147182c01932 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/port_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/port_config.c  -o ${OBJECTDIR}/_ext/1360926148/port_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/port_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/pwm.o: ../hal/pwm.c  .generated_files/flags/default/d2c264ced08c4a3694bda5ee7fa94e654fd866c5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/pwm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/pwm.c  -o ${OBJECTDIR}/_ext/1360926148/pwm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/pwm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/uart1.o: ../hal/uart1.c  .generated_files/flags/default/4b287673bbd33f7b657ff8e2bf6c7fe086322a57 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart1.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart1.c  -o ${OBJECTDIR}/_ext/1360926148/uart1.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart1.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/measure.o: ../hal/measure.c  .generated_files/flags/default/d5d655bb70b5f068cf34d4a035a4b116f69918db .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/measure.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/measure.c  -o ${OBJECTDIR}/_ext/1360926148/measure.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/measure.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/cmp.o: ../hal/cmp.c  .generated_files/flags/default/cd52c4886250062ef7746e7c912908f66aec8b1b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/cmp.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/cmp.c  -o ${OBJECTDIR}/_ext/1360926148/cmp.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/cmp.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/device_config.o: ../hal/device_config.c  .generated_files/flags/default/5227985d9b3a5bb326ba1bea37fb9a55f1101224 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/device_config.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/device_config.c  -o ${OBJECTDIR}/_ext/1360926148/device_config.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/device_config.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/interrupt.o: ../hal/interrupt.c  .generated_files/flags/default/8d7a07c318e147da0e30a17ec5d81ce2431c8fd .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/interrupt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/interrupt.c  -o ${OBJECTDIR}/_ext/1360926148/interrupt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/interrupt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1360926148/uart2.o: ../hal/uart2.c  .generated_files/flags/default/c7648fc2dcd018702c8caa7aec408076da50fbf8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1360926148" 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360926148/uart2.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../hal/uart2.c  -o ${OBJECTDIR}/_ext/1360926148/uart2.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1360926148/uart2.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/estim.o: ../estim.c  .generated_files/flags/default/21c09463fc5609b0d43946beafbeaf7da0957270 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/estim.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../estim.c  -o ${OBJECTDIR}/_ext/1472/estim.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/estim.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/fdweak.o: ../fdweak.c  .generated_files/flags/default/6cfcaeb0602aa64094a638b634cae15655b7b0cb .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/fdweak.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../fdweak.c  -o ${OBJECTDIR}/_ext/1472/fdweak.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/fdweak.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/pmsm.o: ../pmsm.c  .generated_files/flags/default/5f1980674480598f3dd3e2423164d941984975af .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/pmsm.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../pmsm.c  -o ${OBJECTDIR}/_ext/1472/pmsm.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/pmsm.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o: ../diagnostics_x2cscope.c  .generated_files/flags/default/5244e27779442c296f7185e4df9c46ef1805c69f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../diagnostics_x2cscope.c  -o ${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/diagnostics_x2cscope.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/singleshunt.o: ../singleshunt.c  .generated_files/flags/default/9b144e943569b35e8613f575093644c56b591bf8 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/singleshunt.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../singleshunt.c  -o ${OBJECTDIR}/_ext/1472/singleshunt.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/singleshunt.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/Communication.o: ../Communication.c  .generated_files/flags/default/2d202b65dd7e121780dff24b698b52837b9a420a .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Communication.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Communication.c  -o ${OBJECTDIR}/_ext/1472/Communication.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Communication.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
${OBJECTDIR}/_ext/1472/Status_LED.o: ../Status_LED.c  .generated_files/flags/default/11469af5c4881eb783656c1b249f9c42623e4f89 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/Status_LED.o 
	${MP_CC} $(MP_EXTRA_CC_PRE)  ../Status_LED.c  -o ${OBJECTDIR}/_ext/1472/Status_LED.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -MP -MMD -MF "${OBJECTDIR}/_ext/1472/Status_LED.o.d"      -mno-eds-warn  -g -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -O0 -I"../" -I"../hal" -I"../lib/motor_control" -I"../lib/x2c_scope" -msmart-io=1 -Wall -msfr-warn=off   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o: ../lib/motor_control/mc_clarke_dspic.s  .generated_files/flags/default/c9e95a80ce9f384e74d07233edb9ff29531a995f .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_clarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o: ../lib/motor_control/mc_invclarke_dspic.s  .generated_files/flags/default/9d78fe357bd010093f9076a782e6a488ae7209e7 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invclarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o: ../lib/motor_control/mc_invpark_dspic.s  .generated_files/flags/default/d4aa1ac0468a275cc3782e58451e41ffcd55b6aa .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invpark_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_park_dspic.o: ../lib/motor_control/mc_park_dspic.s  .generated_files/flags/default/55abcb424a679eeb82280072755e871a34edfef9 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_park_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o: ../lib/motor_control/mc_piupdate_dspic.s  .generated_files/flags/default/1215aec0a0e417f548d4f7edda0d402e72b22ea1 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_piupdate_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o: ../lib/motor_control/mc_sinecos_ram_dspic.s  .generated_files/flags/default/b8ff5e787f1012c8bbd4a96b14b3bcb3bd23dd33 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinecos_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o: ../lib/motor_control/mc_sinetable_flash_dspic.s  .generated_files/flags/default/320534256c28066398cf7dd91d5ebc324048b628 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_flash_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o: ../lib/motor_control/mc_sinetable_ram_dspic.s  .generated_files/flags/default/68e6e5b8604b68d15a5f2fdb032daf07cc318b83 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o: ../lib/motor_control/mc_svgen_dspic.s  .generated_files/flags/default/d97e63c8dd90bc516ce2f41a06c49ed887498e36 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_svgen_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -D__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d",--defsym=__MPLAB_BUILD=1,--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
else
${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o: ../lib/motor_control/mc_clarke_dspic.s  .generated_files/flags/default/43016c42a4145cb05171fff1420c394ddfd566ca .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_clarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_clarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o: ../lib/motor_control/mc_invclarke_dspic.s  .generated_files/flags/default/df8a2e618f5ee7b907688b48a7139f64493cac41 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invclarke_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invclarke_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o: ../lib/motor_control/mc_invpark_dspic.s  .generated_files/flags/default/296c24a96194891fe67771eb3099fb567919e155 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_invpark_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_invpark_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_park_dspic.o: ../lib/motor_control/mc_park_dspic.s  .generated_files/flags/default/4e1747659db32dc6f5269780279123c60ebced26 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_park_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_park_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_park_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o: ../lib/motor_control/mc_piupdate_dspic.s  .generated_files/flags/default/a9c78688a4a0236efcfdadd83541a2e5ec60e9a5 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_piupdate_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_piupdate_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o: ../lib/motor_control/mc_sinecos_ram_dspic.s  .generated_files/flags/default/d180437b2f7ebf0ebd0748ad3e82140090909339 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinecos_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinecos_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o: ../lib/motor_control/mc_sinetable_flash_dspic.s  .generated_files/flags/default/aac166b781f4abffb5fe9ff067ab350b4cb77e4b .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_flash_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_flash_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o: ../lib/motor_control/mc_sinetable_ram_dspic.s  .generated_files/flags/default/8e05d0f5771aff7904d3cf88874969e79c140fa4 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_sinetable_ram_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_sinetable_ram_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o: ../lib/motor_control/mc_svgen_dspic.s  .generated_files/flags/default/9a88ad9ee6b53f6146e4df62612899742d571dd6 .generated_files/flags/default/da39a3ee5e6b4b0d3255bfef95601890afd80709
	@${MKDIR} "${OBJECTDIR}/_ext/666432250" 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d 
	@${RM} ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o 
	${MP_CC} $(MP_EXTRA_AS_PRE)  ../lib/motor_control/mc_svgen_dspic.s  -o ${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o  -c -mcpu=$(MP_PROCESSOR_OPTION)  -omf=elf -DXPRJ_default=$(CND_CONF)    -I"../lib/motor_control" -Wa,-MD,"${OBJECTDIR}/_ext/666432250/mc_svgen_dspic.o.d",--defsym=__MPLAB_BUILD=1,-g,--no-relax$(MP_EXTRA_AS_POST) 
	
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
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -D__DEBUG=__DEBUG   -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)   -mreserve=data@0x1000:0x101B -mreserve=data@0x101C:0x101D -mreserve=data@0x101E:0x101F -mreserve=data@0x1020:0x1021 -mreserve=data@0x1022:0x1023 -mreserve=data@0x1024:0x1027 -mreserve=data@0x1028:0x104F   -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D__DEBUG=__DEBUG,,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library=q,--library=x2cscope-33ck,--library-path="../lib/x2c_scope",--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  
	
else
${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -o ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}      -mcpu=$(MP_PROCESSOR_OPTION)        -omf=elf -DXPRJ_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--local-stack,,--defsym=__MPLAB_BUILD=1,$(MP_LINKER_FILE_OPTION),--stack=16,--check-sections,--data-init,--pack-data,--handles,--isr,--no-gc-sections,--fill-upper=0,--stackguard=16,--library=q,--library=x2cscope-33ck,--library-path="../lib/x2c_scope",--no-force-link,--smart-io,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--report-mem,--memorysummary,${DISTDIR}/memoryfile.xml$(MP_EXTRA_LD_POST)  
	${MP_CC_DIR}\\xc16-bin2hex ${DISTDIR}/pmsm.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} -a  -omf=elf   
	
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
