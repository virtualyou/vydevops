#!/bin/bash
( set -ex
  kubectl apply -f userauth-ingress.yaml  
  kubectl apply -f personal-ingress.yaml  
  kubectl apply -f medical-ingress.yaml  
  kubectl apply -f financial-ingress.yaml  
  kubectl apply -f administration-ingress.yaml  
)

