#!/bin/bash
sed -i 's=mavenCentral()= "'"\n"'"
	  maven { "'"\n"'"
	    credentials { "'"\n"'"
            username "'"$NEXUS_USER"'" "'"\n"'"
            password "'"$NEXUS_PASSWORD"'" "'"\n"'"
        } "'"\n"'"
    url "'"$NEXUS_PUBLIC_URL"'" "'"\n"'"
  }=g' build.gradle


cat build.gradle


