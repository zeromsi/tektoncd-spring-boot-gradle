FROM gradle:6.0.1-jdk8 AS build
COPY --chown=gradle:gradle . /home/gradle/src

ARG NEXUS_USER
ARG NEXUS_PASSWORD
ARG NEXUS_PUBLIC_URL
ARG NEXUS_RELEASES_URL
ARG NEXUS_SNAPSHOTS_URL

ENV NEXUS_USER $NEXUS_USER
ENV NEXUS_PASSWORD $NEXUS_PASSWORD
ENV NEXUS_PUBLIC_URL $NEXUS_PUBLIC_URL
ENV NEXUS_RELEASES_URL $NEXUS_RELEASES_URL
ENV NEXUS_SNAPSHOTS_URL $NEXUS_SNAPSHOTS_URL


RUN export NEXUS_USER
RUN export NEXUS_PASSWORD
RUN export NEXUS_PUBLIC_URL
RUN export NEXUS_RELEASES_URL
RUN export NEXUS_SNAPSHOTS_URL


WORKDIR /home/gradle/src
ADD script_to_set_args_buildfile.sh .
ADD build.gradle .
RUN /script_to_set_args_buildfile.sh

RUN gradle build --no-daemon 

FROM openjdk:8-jre-slim

EXPOSE 8080

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/tektoncd-spring-boot-gradle.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/tektoncd-spring-boot-gradle.jar"]
