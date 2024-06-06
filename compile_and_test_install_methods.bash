#!/bin/bash

set -e

export SINGLEM_VERSION=$1
echo "Testing SingleM version $SINGLEM_VERSION"

# Test conda install
echo "Testing conda install .."
sed "s/SINGLEM_VERSION/$SINGLEM_VERSION/g" Dockerfile.conda.in > Dockerfile.conda
docker build --no-cache --progress=plain -f Dockerfile.conda . &> conda.build.log

# Test PyPI install
echo "Testing PyPI install .."
sed "s/SINGLEM_VERSION/$SINGLEM_VERSION/g" Dockerfile.pypi.in > Dockerfile.pypi
docker build --no-cache --progress=plain -f Dockerfile.pypi . &> pypi.build.log

echo "Downloading test data .."
wget --quiet https://github.com/wwood/singlem/raw/1d204f7ef1b90435a51cdadc18d37791fbff4c9b/docker/test.fna

Test docker install. Easier here than within a Dockerfile
echo "Testing docker install .."
chmod g+rw . # Docker needs this to write to the mounted volume - diamond uses it as a temp directory
bash -c "docker pull wwood/singlem:$SINGLEM_VERSION && docker run -v `pwd`:/data wwood/singlem:$SINGLEM_VERSION pipe --sequences /data/test.fna --otu-table /dev/stdout" &> docker.build.log

# Test apptainer install. Too annoying to run this within a Dockerfile and simple enough here.
echo "Testing apptainer install .."
rm -f singlem_$SINGLEM_VERSION.sif
bash -c 'apptainer pull docker://wwood/singlem:$SINGLEM_VERSION && apptainer run --cleanenv -B `pwd`:`pwd` singlem_$SINGLEM_VERSION.sif pipe --sequences `pwd`/test.fna --otu-table /dev/stdout' > apptainer.build.stdout.log 2> apptainer.build.stderr.log
