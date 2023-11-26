# Docker Registry
This page journals the installation and operation of a private docker registry.

## Kubernetes
- Helm Chart docker-registry-2.2.2
- App Version 2.8.1

NOTES: installation successful however, a push did not prove successful. Either NGINX or the registry will 
not allow images above a very limited size.

Resolution will be journaled here.

Installed Nexus OSS 3 instead of Docker Registry thinking maybe this would go away. It did not. 
I've worked tonight 11/24/2023 (early) to gain access to the Docker registry I created on port 5000.

After helm this is required:
- add container port 5000 to deployment
- add container port 5000 to service

Deployment
```yaml
containerPort: 5000
```

Service
```yaml
- port: 5000
  targetPort: 5000
  protocol: TCP
  name: docker
```

Created ingress to different subdomain `docker.virtualyou.info` instead of `nexus.virtualyou.info`. And, then I logged 
into docker in the terminal, built an image, and then BOOM!

`413 Request Entity Too Large`

So, I need to resolve this. It turns out that I was using the wrong NGINX-ingress annotation in my service
ingress. I need to do a full accounting of my Kubernetes platform. My `ingress` (name) is installed at namespace 
`nginx-ingress` under Helm using chart `nginx-ingress-0.15.2` and app-version `2.4.2`. There are two versions,
one strictly NGINX and the other a derivative by Kubernetes.

I'm using the official NGINX Ingress Controller and their annotation use `nginx.org`. I have been copying ingress
yamls with `nginx.ingress.kubernetes.io` which has been incorrect for some time. I probably used the Kubernetes
version when I first started hosting Kubernetes.

Here's the annotation that fixed this problem:
```yaml
nginx.org/client-max-body-size: "0"
```
## Conclusion
The VirtualYou docker registry is hosted by Nexus `https://nexus.virtualyou.info` at `https://docker.virtualyou.info`.
