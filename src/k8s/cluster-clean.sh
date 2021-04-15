#!/bin/bash
#

echo 'Removing deployments...'
kubectl delete deployments --all

echo 'Removing services...'
kubectl delete services --all

echo 'Removing pods...'
kubectl delete pods --all

echo 'Removing secrets...'
kubectl delete secrets --all

echo 'Removing daemonsets...'
kubectl delete daemonset --all


echo 'Done.'
