BOOTSTRAP_BASE=$(SDK_BUILD_BASE)/bootstrap

ifneq (,$(wildcard /etc/redhat-release))
# dnf install slf4j osgi-core osgi-annotation osgi-compendium
BND_CLASSPATH=/usr/share/java/slf4j/slf4j-api.jar:/usr/share/java/osgi-core/osgi.core.jar:/usr/share/java/osgi-annotation/osgi.annotation.jar:/usr/share/java/osgi-compendium/osgi.cmpn.jar
else
# sudo apt install libslf4j-java libosgi-core-java libosgi-annotation-java libosgi-compendium-java
BND_CLASSPATH=/usr/share/java/slf4j-api.jar:/usr/share/java/osgi.core.jar:/usr/share/java/osgi.annotation.jar:/usr/share/java/osgi.cmpn.jar
endif 

