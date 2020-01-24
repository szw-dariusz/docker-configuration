FROM maven:3-jdk-13
RUN mkdir /app
WORKDIR /app
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"
COPY pom.xml .
RUN mvn -T 1C dependency:go-offline
COPY src src
RUN mvn -T 1C --offline package \
    && mv target/*.jar app.jar \
    && rm -rf src target pom.xml
CMD ["java", "-jar", "app.jar"]
