# Default target
all: build

# Target: dummy
build:
	@echo "make build"

# Target: dummy
check:
	@echo "make check"

# Target: dummy
clean:
	@echo "make clean"

teamcityCheck:
	cd .teamcity && mvn teamcity-configs:generate
