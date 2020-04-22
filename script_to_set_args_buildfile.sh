#!/bin/bash
sed -i 's=mavenCentral()= \
	  maven { \
	    credentials { \
            username "'"$NEXUS_USER"'" \
            password "'"$NEXUS_PASSWORD"'" \
        } \
    url "'"$NEXUS_MAVEN_PUBLIC_URL"'" \
  }=g' build.gradle

echo "done"

