#!/bin/sh

cat Dockerfile.head > Dockerfile


if test -f Dockerfile.pre
 then
  cat Dockerfile.pre >> Dockerfile
fi

cat ../10.node.common/Dockerfile.tail >> Dockerfile


if test -f Dockerfile.post
 then
  cat Dockerfile.post >> Dockerfile
fi

cp -rnp ../10.node.common/home .

