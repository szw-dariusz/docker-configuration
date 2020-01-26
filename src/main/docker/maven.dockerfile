FROM maven:3-jdk-13 AS builder
RUN mkdir /app
WORKDIR /app
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
COPY pom.xml .
RUN mvn -T 1C dependency:go-offline
COPY src src
RUN mvn -T 1C --offline package

FROM adoptopenjdk:13-jre-openj9
COPY --from=builder /app/target/*.jar /app/app.jar
ENTRYPOINT ["java"]
CMD ["-jar", "/app/app.jar"]
