#!/bin/bash
( set -ex
  kubectl -n virtualyou expose deploy userauth --port=3001 
  kubectl -n virtualyou expose deploy personal --port=3002 
  kubectl -n virtualyou expose deploy medical --port=3003 
  kubectl -n virtualyou expose deploy financial --port=3004 
  kubectl -n virtualyou expose deploy administration --port=3005 
)

