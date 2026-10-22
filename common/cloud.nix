{pkgs}:
with pkgs; [
  aws-iam-authenticator
  awscli2
  (azure-cli.withExtensions [azure-cli.extensions.account])
  k9s
  kind
  kubectl
  kubectx
  kubernetes-helm
  kustomize
  opentofu
  terraform
  terraform-docs
  tflint
  tilt
]
