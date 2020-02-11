#!/bin/bash
sed -i 's=buildscript { =
buildscript {
	repositories { 
		maven { 
			credentials { 
				username '"$NEXUS_USER"' 
				password '"$NEXUS_PASSWORD"' 
				} 
			url '"$NEXUS_PUBLIC_URL"' 
		} 
	} =g' build.g radle

sed -i 's=dependencies {
	implementation=
repositories { 
	maven { 
		credentials { 
			username '"$NEXUS_USER"' 
			password '"$NEXUS_PASSWORD"' 
			} 
		url '"$NEXUS_PUBLIC_URL"'
		} 
	} 
dependencies {
	implementation=g' build.gradle

cat build.gradle


