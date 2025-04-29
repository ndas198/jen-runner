FROM ghcr.io/jenkinsci/jenkinsfile-runner:latest
RUN apt update && apt install -y curl unzip
RUN mkdir /plugins
COPY plugins.txt /tmp/plugins.txt
RUN set -eux; \
    while IFS=: read -r name version; do \
        echo "Installing plugin: $name version: $version"; \
        curl -fsSL "https://updates.jenkins.io/download/plugins/${name}/${version}/${name}.hpi" -o "/plugins/${name}.hpi"; \
        mkdir -p "/usr/share/jenkins/ref/plugins/${name}.hpi"; \
        unzip -o "/plugins/${name}.hpi" -d "/usr/share/jenkins/ref/plugins/${name}.hpi"; \
    done < /tmp/plugins.txt;
