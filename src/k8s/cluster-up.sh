#!/bin/bash
#

if [[ -z "$ENCRYPTION_KEY" ]]; then
    echo "Must provide ENCRYPTION_KEY in environment" 1>&2
    exit 1
fi

# minikube start


# Imperative command to allow kubernetes-nginx ingress
minikube addons enable ingress

# Secrets handling
../../bin/handle-secret.sh -d -f ../../.secrets/.env.gpg
mv ../../.secrets/.env.gpg.decrypted ./.env

# Imperative command to create env secrets in the cluster
kubectl create secret generic environment --from-env-file=.env 
kubectl get secret environment -o yaml
kubectl get secrets





kubectl apply -f .


kubectl get pods



rm ./.env