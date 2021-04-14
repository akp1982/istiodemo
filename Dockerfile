#FROM adoptopenjdk:11-jre-hotspot as builder
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} application.jar
#RUN java -Djarmode=layertools -jar application.jar extract

#FROM adoptopenjdk:11-jre-hotspot
#COPY --from=builder dependencies/ ./
#COPY --from=builder snapshot-dependencies/ ./
#COPY --from=builder spring-boot-loader/ ./
#COPY --from=builder application/ ./
#ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]



#FROM java:8
#EXPOSE 8080
#ADD ./target/istiodemo-0.0.1-SNAPSHOT.jar istio-docker-app.jar
#ENTRYPOINT ["java", "-jar", "istio-docker-app.jar"]



# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
FROM maven:3.5-jdk-8-alpine as builder

# Copy local code to the container image.
WORKDIR /istiodemo
COPY pom.xml ./
COPY src ./src/

# Build a release artifact.
RUN mvn package -DskipTests

# Use AdoptOpenJDK for base image.
# It's important to use OpenJDK 8u191 or above that has container support enabled.
# https://hub.docker.com/r/adoptopenjdk/openjdk8
# https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds
FROM adoptopenjdk/openjdk8:jdk8u202-b08-alpine-slim

# Copy the jar to the production image from the builder stage.
COPY --from=builder /istiodemo/target/istiodemo-*.jar /istiodemo1.jar

# Run the web service on container startup.
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-Dserver.port=${PORT}","-jar","/istiodemo1.jar"]
