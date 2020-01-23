FROM maven:3-jdk-13
RUN mkdir /app
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src src
RUN mvn package && mv target/*.jar app.jar && rm -rf src target pom.xml
CMD ["java", "-jar", "app.jar"]
