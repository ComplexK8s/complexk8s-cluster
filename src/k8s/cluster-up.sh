#!/bin/bash
#

# minikube start


 ../../bin/handle-secret.sh -d -f ../../.secrets/.env.gpg
 mv ../../.secrets/.env.gpg.decrypted ./.env

# Imperative command to create env secrets
# kubectl create secret generic environment --from-env-file=.env 
# kubectl get secret environment -o yaml
# kubectl get secrets


# kubectl apply -f .


# kubectl get pods



rm ./.env