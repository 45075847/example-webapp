FROM eclipse-temurin:8-jre-alpine
MAINTAINER Your Name <you@example.com>

ADD target/uberjar/example-webapp.jar /example-webapp/app.jar

EXPOSE 3000

CMD ["java", "-jar", "/example-webapp/app.jar"]
