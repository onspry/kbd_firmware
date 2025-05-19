# Default to master left configuration
MASTER_LEFT ?= true
ifeq ($(strip $(MASTER_LEFT)), true)
    OPT_DEFS += -DMASTER_LEFT
endif

SERIAL_DRIVER = vendor      # Use RP2040 vendor-specific driver