FROM jenkins/jenkins:lts

USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

USER jenkins
COPY images/ /usr/share/jenkins/ref/images/
COPY jenkins/deploy.sh /usr/share/jenkins/ref/deploy.sh
COPY --chown=jenkins:jenkins jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false -Dpermissive-script-security.enabled=no_security
COPY jenkins/seed.groovy /usr/share/jenkins/ref/seed.groovy
COPY jenkins/jenkins-casc.yaml /usr/share/jenkins/ref/jenkins-casc.yaml
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/jenkins-casc.yaml

RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt