# Tiltfile

load('ext://helm_resource', 'helm_resource', 'helm_repo')

k8s_yaml(local('helm template ./helm-charts'))

docker_build('openresty', '.', dockerfile='Dockerfile')

k8s_resource('openresty', port_forwards=8080)
