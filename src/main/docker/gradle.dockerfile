FROM adoptopenjdk:13-jdk-openj9 AS builder
RUN mkdir /app
WORKDIR /app
COPY gradlew ./
COPY gradle gradle
RUN ./gradlew --no-daemon
COPY *.gradle ./
RUN ./gradlew --no-daemon build
COPY src src
RUN ./gradlew --no-daemon assemble

FROM adoptopenjdk:13-jre-openj9
COPY --from=builder /app/build/libs/*.jar /app/app.jar
ENTRYPOINT ["java"]
CMD ["-jar", "/app/app.jar"]
