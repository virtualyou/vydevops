#!/bin/bash
( set -ex
  kubectl apply -f userauth-deploy.yaml
  kubectl apply -f personal-deploy.yaml
  kubectl apply -f medical-deploy.yaml
  kubectl apply -f financial-deploy.yaml
  kubectl apply -f administration-deploy.yaml
)

