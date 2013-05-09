NAME=pmbd
obj-m = $(NAME).o
KVERSION = $(shell uname -r)

all:
	make -C /lib/modules/$(KVERSION)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(KVERSION)/build M=$(PWD) clean

install:
	if [ -f $(NAME).ko ]; then \
		if ! cp $(NAME).ko /lib/modules/$(KVERSION)/kernel/drivers/block; \
		then exit 1; fi; \
	fi;
	/sbin/depmod -a

uninstall:
	if [ -f /lib/modules/$(KVERSION)/kernel/drivers/block/$(NAME).ko ]; then \
		if ! rm -f /lib/modules/$(KVERSION)/kernel/drivers/block/$(NAME).ko; \
		then exit 1; fi; \
	fi; 
	/sbin/depmod -a

