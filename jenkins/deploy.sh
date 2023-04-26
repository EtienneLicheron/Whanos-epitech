#!/bin/bash

language=""
isDockerfile=false

files=$(ls)

name=$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]')

for file in $files
do
    case $file in
        Dockerfile)
            isDockerfile=true
            ;;
        Makefile)
            language="C"
            break
            ;;
        pom.xml)
            language="Java"
            break
            ;;
        package.json)
            language="JavaScript"
            break
            ;;
        requirements.txt)
            language="Python"
            break
            ;;
        *)
            ;;
    esac
done

appls=$(ls ./app/)

for appl in $appls
do
    if [ $appl == "main.bf" ]
    then
        language="Befunge"
        break
    fi
done

echo "Language: $language"

echo "Is Dockerfile: $isDockerfile"

if [ $isDockerfile == false ]
then
    case $language in
        C)
            docker build -f ../../../images/c/Dockerfile.standalone -t $name .
            docker tag $name whanos2025.azurecr.io/$name
            docker login -u $AZURE_USERNAME -p $AZURE_PASSWORD whanos2025.azurecr.io
            docker push whanos2025.azurecr.io/$name
            ;;
        Java)
            docker build -f ../../../images/java/Dockerfile.standalone -t $name .
            docker tag $name whanos2025.azurecr.io/$name
            docker login -u $AZURE_USERNAME -p $AZURE_PASSWORD whanos2025.azurecr.io
            docker push whanos2025.azurecr.io/$name
            ;;
        JavaScript)
            docker build -f ../../../images/javascript/Dockerfile.standalone -t $name .
            docker tag $name whanos2025.azurecr.io/$name
            docker login -u $AZURE_USERNAME -p $AZURE_PASSWORD whanos2025.azurecr.io
            docker push whanos2025.azurecr.io/$name
            ;;
        Python)
            docker build -f ../../../images/python/Dockerfile.standalone -t $name .
            docker tag $name whanos2025.azurecr.io/$name
            docker login -u $AZURE_USERNAME -p $AZURE_PASSWORD whanos2025.azurecr.io
            docker push whanos2025.azurecr.io/$name
            ;;
        Befunge)
            docker build -f ../../../images/befunge/Dockerfile.standalone -t $name .
            docker tag $name whanos2025.azurecr.io/$name
            docker login -u $AZURE_USERNAME -p $AZURE_PASSWORD whanos2025.azurecr.io
            docker push whanos2025.azurecr.io/$name
            ;;
        *)
            echo "No language found"
            ;;
    esac
fi