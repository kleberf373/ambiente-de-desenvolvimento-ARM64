# ambiente-de-desenvolvimento-ARM64
um ambiente docker para a produção de jogos em arm64

## dependências:
- qemu-user-static
- binfmt-support
- docker

## setup

primeiro a instalação do docker e suas dependências:

```bash
sudo apt-get update && sudo apt-get install -y ca-certificates \
curl \
gnupg

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo apt-get install -y qemu-user-static binfmt-support
```

Logo após execute setup.sh com seu nome como parâmetro:

```bash
./setup.sh <nome>
```

E então execute run_image.sh:

```bash
./run_image.sh <contêiner> <porta> <imagem>
```

assim estará utilizando a imagem para desenvolver jogos voltados à raspbian (raspberry pi os).
