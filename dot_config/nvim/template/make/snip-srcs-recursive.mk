
SRCROOTS = src test
SRCS = $(foreach root, $(SRCROOTS), $(shell find $(root) -name '*.clj'))
