#!/bin/bash
sed -i 's=dependencies=repositories { maven { credentials { username '"$NEXUS_USER"' password '"$NEXUS_PASSWORD"' } url '"$NEXUS_PUBLIC_URL"' } } dependencies=g' build.gradle


cat build.gradle


