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



FROM java:8
EXPOSE 8080
ADD /target/istiodemo-0.0.1-SNAPSHOT.jar istio-docker-app.jar
ENTRYPOINT ["java", "-jar", "istio-docker-app.jar"]