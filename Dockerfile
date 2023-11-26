FROM maven:3.8-openjdk-8 AS build
COPY . .
RUN mvn clean package -Dskiptests

# Debugging commands
RUN ls /target
RUN find /target

FROM openjdk:8-jre-slim-stretch
COPY --from=build /target/demo1-0.0.1-SNAPSHOT.jar demo1.jar
EXPOSE 8080
ENTRYPOINT [ "java","-jar","demo1.jar" ]