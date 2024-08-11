FROM alpine:latest AS build
RUN apk add openjdk21
COPY . .
RUN ./gradlew bootJar

FROM alpine:latest AS result
RUN apk add openjdk21
WORKDIR /app
COPY --from=build /build/libs/*.jar app.jar

EXPOSE 8072
ENTRYPOINT ["java", "-jar", "app.jar"]