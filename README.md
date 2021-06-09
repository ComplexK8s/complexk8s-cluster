<h1 align="center">Welcome to complexk8s-cluster 👋</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-blue.svg?cacheSeconds=2592000" />
</p>

> ComplexK8s Cluster project


## Cluster creation - Steps


```sh
$ export ENCRYPTION_KEY=<ENCRYPTION_KEY>
$ minikube start
$ kubectl apply -f ./src/k8s
$ kubectl get pods
```

## Getting the cluster IP
```sh
$ minikube ip
```


## Terraform Stack

### Creating
```sh
$ terraform plan
$ terraform apply
```
### Destroying
```sh
$ terraform destroy
```


### Installing Terraform

```sh
$ wget https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip
$ sudo apt install zip -y
$ sudo unzip terraform_0.14.3_linux_amd64.zip
$ sudo mv terraform /usr/local/bin/
$ terraform version
```

## Installing Minikube

```sh
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube
$ sudo usermod -aG docker $USER && newgrp docker
$ minikube start
```


## Installing Kubectl

```sh
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
$ sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
$ kubectl version
```

## Installing eksctl

```sh
$ curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
$ sudo mv /tmp/eksctl /usr/local/bin
$ eksctl version
```

### Dashboard
```shell
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
$ kubectl proxy
```


http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/.  

## References

* [Getting Started with Amazon Elastic Kubernetes Service (EKS)] (https://medium.com/rafay-systems/getting-started-with-amazon-elastic-kubernetes-service-eks-b059cceb50a1)

## Show your support

Give a ⭐️ if this project helped you!

***
_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_