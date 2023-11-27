FROM maven:3.8-openjdk-8 AS build

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src src
RUN mvn clean package -DskipTests

FROM maven:3.8-openjdk-8 AS final

COPY --from=build /app/target/demo1-0.0.1-SNAPSHOT.jar demo1.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "demo1.jar"]
