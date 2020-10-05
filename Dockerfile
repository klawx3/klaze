FROM openjdk:11
RUN apt -y update
RUN apt -y upgrade
RUN apt install -y maven
RUN mkdir /opt/klaze
COPY . /opt/klaze
WORKDIR /opt/klaze

RUN mvn dependency:purge-local-repository
CMD mvn spring-boot:run

EXPOSE 8081/tcp


