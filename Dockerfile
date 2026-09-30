FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests


FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY --from=build \
     /app/target/clinic-manager.war \
     /usr/local/tomcat/webapps/clinic-manager.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
