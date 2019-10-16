# Define Leiningen binary
LEINBIN = /usr/local/bin/lein

all: main.js page/page.js

# Compile main.js with Leiningen
main.js: project.clj src/asciinema/gif/*.cljs src/asciinema/gif/*.clj
	$(LEINBIN) cljsbuild once main

# Compile page.js with Leiningen
page/page.js: project.clj src/asciinema/gif/*.cljs src/asciinema/gif/*.clj
	$(LEINBIN) cljsbuild once page

# Publish to npmjs.org
publish: all
	npm publish

# Install Leiningen to /usr/local/bin/lein
lein-install:
	echo -e '\e[1m*** Installing Leiningen...\e[0m\n' && \
	curl -sLko $(LEINBIN) https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
	chmod +x $(LEINBIN) && \
	$(LEINBIN) && \
	echo -e "\n\e[1m*** Leiningen installed to $(LEINBIN).\e[0m"

# Run Leiningen upgrade command
lein-upgrade:
	echo -e '\e[1m*** Running Leiningen upgrader...\e[0m\n' && \
	echo -e 'y\n' | $(LEINBIN) upgrade && \
	echo -e "\n\e[1m*** Leiningen upgraded.\e[0m"

.PHONY: lein-install lein-upgrade all publish
