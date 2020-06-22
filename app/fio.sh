#!/bin/bash

    - echo "=============================docker fio============================================================="
    # - sudo docker build -t dockerfoam:fio . --file Dockerfile.alpine
    - sudo make build-image
    - sudo docker image ls
    # - sudo docker run dockerfoam/fio /jobs/rand-read.fio
    #     - |
    #         if [[ "$TRAVIS_BRANCH" == "dev" ]]; then
    #           sudo docker login -u $DOCKER_USERNAME -p $DOCKER_TOKEN ;
    #           make push-image ;
    #         fi    
    - echo "=============================docker fio============================================================="
