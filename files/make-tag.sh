#!/bin/bash

set -e

TAG=$(cat "$BUILD/Dockerfile" | grep '^ENV VERSION' | cut -d" " -f3)

echo -e "===> Tagging $ORG/$NAME:$BUILD as $ORG/$NAME:$TAG"
docker tag $ORG/$NAME:$BUILD $ORG/$NAME:$TAG
echo -e "===> Pushing $ORG/$NAME:$TAG"
docker push $ORG/$NAME:$TAG
