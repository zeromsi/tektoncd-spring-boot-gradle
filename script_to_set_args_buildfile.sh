#!/bin/bash
sed -i 's=dependencies=buildscript { repositories { maven { credentials { username '"$NEXUS_USER"' password '"$NEXUS_PASSWORD"' } url '"$NEXUS_PUBLIC_URL"' } } dependencies=g' build.g radle


cat build.gradle


