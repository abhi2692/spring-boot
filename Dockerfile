
FROM maven:3.6.3-jdk-8-slim AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn package -DskipTests

FROM openjdk:8-jdk-alpine

COPY --from=build /app/target/simple-springboot-app-0.0.1-SNAPSHOT.jar /simple-springboot-app.jar

# Run the web service on container startup.
CMD ["java", "-jar", "./simple-springboot-app.jar"]