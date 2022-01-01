#
# Build stage
#
FROM maven:3.8.4-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:8-jdk-alpine
COPY --from=build /home/app/target/javulna-1.0-SNAPSHOT.jar /usr/local/lib/javulna.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/javulna.jar"]