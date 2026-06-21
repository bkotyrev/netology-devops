# Yandex.Cloud init
```powershell
yc init
yc config profile list
yc config profile get <NAME
yc config profile activate <NAME>

yc vpc network create --name netology-net1 --labels my-label=netology --description "First Network"
yc vpc network list

yc vpc subnet create --name netology-subnet-a --network-name netology-net1 --zone ru-central1-a --range 10.1.2.0/24 --description "Netology Subnet 1"
yc vpc subnet list
```

# Packer using JSON config
```powershell
$env:YC_TOKEN = yc iam create-token

packer plugins install github.com/hashicorp/yandex 1.1.3
packer validate .\ubuntu-24-docker.json
packer build .\ubuntu-24-docker.json

yc compute image list
```

# Packer using HCL config
```powershell
$env:YC_TOKEN = yc iam create-token

packer init .
packer validate .\ubuntu-24-docker.pkr.hcl
packer build .\ubuntu-24-docker.pkr.hcl

yc compute image list
```

# Run instance
```powershell
yc compute instance create `
  --name vm-ubuntu-docker `
  --zone ru-central1-a `
  --cores 2 `
  --memory 2GB `
  --core-fraction 20 `
  --network-interface subnet-id=e9b6jt8bg9122u169c0f,nat-ip-version=ipv4 `
  --create-boot-disk name=boot-ubuntu-docker-01,type=network-hdd,size=20GB,image-name=ubuntu-24-docker,auto-delete=true `
  --ssh-key $env:USERPROFILE\.ssh\id_ed25519.pub

yc compute instance list

yc compute instance stop vm-ubuntu-docker 
yc compute instance update vm-ubuntu-docker --preemptible=true
yc compute instance start vm-ubuntu-docker 

ssh -i "$env:USERPROFILE\.ssh\id_ed25519" yc-user@<EXTERNAL_IP>
docker --version
docker compose version
sudo docker run hello-world
```  

# Cleanup resources
```powershell
yc compute instance delete vm-ubuntu-docker
yc compute image delete ubuntu-24-docker
```