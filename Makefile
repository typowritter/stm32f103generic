##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.10.0-B14] date: [Wed Aug 19 11:13:50 CST 2020]
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

######################################
# target
######################################
TARGET = main


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Og -w


#######################################
# paths
#######################################
# Build path
BUILD_DIR = build

######################################
# source
######################################
# C sources
C_SOURCES =  \
User/src/main.c \
User/src/stm32f10x_it.c \
User/src/bsp_tty.c \
Libraries/CMSIS/system_stm32f10x.c \
Libraries/CMSIS/core_cm3.c \
Libraries/FWlib/src/stm32f10x_wwdg.c \
Libraries/FWlib/src/stm32f10x_usart.c \
Libraries/FWlib/src/stm32f10x_tim.c \
Libraries/FWlib/src/stm32f10x_spi.c \
Libraries/FWlib/src/stm32f10x_sdio.c \
Libraries/FWlib/src/stm32f10x_rtc.c \
Libraries/FWlib/src/stm32f10x_rcc.c \
Libraries/FWlib/src/stm32f10x_pwr.c \
Libraries/FWlib/src/stm32f10x_iwdg.c \
Libraries/FWlib/src/stm32f10x_i2c.c \
Libraries/FWlib/src/stm32f10x_gpio.c \
Libraries/FWlib/src/stm32f10x_fsmc.c \
Libraries/FWlib/src/stm32f10x_flash.c \
Libraries/FWlib/src/stm32f10x_exti.c \
Libraries/FWlib/src/stm32f10x_dma.c \
Libraries/FWlib/src/stm32f10x_dbgmcu.c \
Libraries/FWlib/src/stm32f10x_dac.c \
Libraries/FWlib/src/stm32f10x_crc.c \
Libraries/FWlib/src/stm32f10x_cec.c \
Libraries/FWlib/src/stm32f10x_can.c \
Libraries/FWlib/src/stm32f10x_bkp.c \
Libraries/FWlib/src/stm32f10x_adc.c \
Libraries/FWlib/src/misc.c


# ASM sources
ASM_SOURCES =  \
startup_stm32f103xe.s


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S

#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m3

# fpu
# NONE for Cortex-M0/M0+/M3

# float-abi


# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS =

# C defines
# C_DEFS =  \
# -DUSE_HAL_DRIVER \
# -DSTM32F103xE

C_DEFS =  \
-DSTM32F10X_HD \
-DUSE_STDPERIPH_DRIVER

# AS includes
AS_INCLUDES =

# C includes
C_INCLUDES =  \
-ILibraries/CMSIS \
-ILibraries/FWlib/inc \
-IUser/inc

# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = STM32F103VETx_FLASH.ld

# libraries
LIBS = -lc -lm -lnosys
LIBDIR =
LDFLAGS = $(MCU) -specs=nano.specs -u _printf_float -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@

$(BUILD_DIR):
	mkdir $@

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)

#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
