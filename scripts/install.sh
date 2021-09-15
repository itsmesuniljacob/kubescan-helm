#! /bin/bash -e

cd $HELM_PLUGIN_DIR
version="$(cat plugin.yaml | grep "version" | cut -d '"' -f 2)"
echo "Installing kube-scan v${version} ..."

unameOut="$(uname -s)"

case "${unameOut}" in
    Linux*)     os=Linux;;
    Darwin*)    os=Darwin;;
    *)          os="UNKNOWN:${unameOut}"
esac

arch=`uname -m`
url="https://github.com/controlplaneio/kubesec/releases/download/v${version}/kubesec_${os}_${arch}.tar.gz"

if [ "$url" = "" ]
then
    echo "Unsupported OS / architecture: ${os}_${arch}"
    exit 1
fi

filename=`echo ${url} | sed -e "s/^.*\///g"`

if [ -n $(command -v curl) ]
then
    curl -sSL -O $url
elif [ -n $(command -v wget) ]
then
    wget -q $url
else
    echo "Need curl or wget"
    exit -1
fi

rm -rf bin && mkdir bin && tar xzvf $filename -C bin > /dev/null && rm -f $filename

echo "Kuubesec.io ${version} is installed."
echo
echo "See https://kubesec.io/ for getting started."