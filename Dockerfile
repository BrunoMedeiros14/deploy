FROM maven:3.9.5-eclipse-temurin-21 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src src
RUN mvn package -DskipTests
  
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=builder app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]