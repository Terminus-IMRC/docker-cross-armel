# docker-cross-armel

A docker image of cross-build toolchain for armel.


## Example use for Game Boy Advance

Makefile:

```makefile
all:

TARGET := test.bin

CROSS_COMPILE := docker run --rm -u "$(shell id -u):$(shell id -g)" \
                 -v "$(PWD):/root:rw" ysugi/cross-armel arm-linux-gnueabi-
TARGET_MACH := -mcpu=arm7tdmi
TARGET_ARCH := $(TARGET_MACH)

OBJCOPY := $(CROSS_COMPILE)objcopy
LD := $(CROSS_COMPILE)ld
CC := $(CROSS_COMPILE)gcc
CPPFLAGS := -pipe -W -Wall -Wextra -O2
OPTUSB := ./optusb
RM ?= rm -f

.PRECIOUS: %.o %.out

.PHONY: all
all: $(TARGET)

%.bin: %.out
	$(OBJCOPY) -O binary "$<" "$@"

%.out: gcc.ls crt.o %.o
	$(LD) $(OUTPUT_OPTION) -T $^

%.o: %.S
	$(COMPILE.S) $(CFLAGS) $(OUTPUT_OPTION) "$<"

%.o: %.c
	$(COMPILE.c) $(OUTPUT_OPTION) "$<"

.PHONY: clean
clean:
	$(RM) $(TARGET) $(TARGET:%.bin=%.out) $(TARGET:%.bin=%.o) crt.o

.PHONY: burn
burn: $(TARGET)
	@read -p 'Press RETURN to burn...'
	$(OPTUSB) "$<"
```
