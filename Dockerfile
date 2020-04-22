FROM gradle:6.0.1-jdk8 AS build
COPY --chown=gradle:gradle . /home/gradle/src

ARG NEXUS_USER
ARG NEXUS_PASSWORD
ARG NEXUS_MAVEN_PUBLIC_URL
ARG NEXUS_MAVEN_RELEASES_URL
ARG NEXUS_MAVEN_SNAPSHOTS_URL

ENV NEXUS_USER $NEXUS_USER
ENV NEXUS_PASSWORD $NEXUS_PASSWORD
ENV NEXUS_MAVEN_PUBLIC_URL $NEXUS_MAVEN_PUBLIC_URL
ENV NEXUS_MAVEN_RELEASES_URL $NEXUS_MAVEN_RELEASES_URL
ENV NEXUS_MAVEN_SNAPSHOTS_URL $NEXUS_MAVEN_SNAPSHOTS_URL

WORKDIR /home/gradle/src

ADD script_to_set_args_buildfile.sh .

RUN status=$(curl -Is --write-out %{http_code}  --silent --output /dev/null $NEXUS_MAVEN_PUBLIC_URL --connect-timeout 1 | head -1) \
&& echo "$status" \
&& if [ $status = "401" ] ; then sh ./script_to_set_args_buildfile.sh ; else echo $status; fi 

RUN gradle build --no-daemon -x test

FROM openjdk:8-jre-slim

EXPOSE 8080

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/tektoncd-spring-boot-gradle.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/tektoncd-spring-boot-gradle.jar"]
