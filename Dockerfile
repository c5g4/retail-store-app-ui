
FROM alpine:latest as BUILD

RUN apk update
RUN apk add --no-cache openjdk17
RUN apk add maven
COPY ./ project
RUN cd project &&  mvn install 

FROM alpine:latest
RUN apk add --no-cache openjdk17
COPY --from=BUILD project/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]