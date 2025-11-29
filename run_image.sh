#/bin/bash

nope=0

if [ -z "$1" ]; then
    echo "Erro: Por favor, forneça um nome de contêiner como parâmetro."
    nope=1
fi

if [ -z "$2" ]; then
    echo "Erro: Por favor, forneça uma porta como parâmetro."
    nope=1
fi

if [ -z "$3" ]; then
    echo "Erro: Por favor, forneça um nome de imagem."
    nope=1
fi

if [ "$nope" -ne 0 ]; then
    echo "Uso: ./run_image.sh <contêiner> <porta> <imagem>"
    exit 1
fi

NOME=$1
PORT=$2
IMAGEM=$3

docker run -d \
  --name ${NOME} \
  -p ${PORT} \
  -it --rm ${IMAGEM} /bin/bash

sudo docker exec -it ${NOME} /bin/bash
