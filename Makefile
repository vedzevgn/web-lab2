PRJ_NAME = web-lab2
SOURCE = ./target
TARGET = /Users/vedzevgn/Wildfly/standalone/deployments/
START_SERVER = /Users/vedzevgn/Wildfly/bin/standalone.bat

$(PRJ_NAME).war: pom.xml
	mvn clean package install

copy: $(SOURCE)/$(PRG_NAME).war
	cp $<.war $(TARGET)

start: copy
	$(START_SERVER)

.PHONY: copy start
