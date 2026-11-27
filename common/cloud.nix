{pkgs, ...}: {
  home.packages = with pkgs; [
    aws-iam-authenticator
    awscli2
    (azure-cli.withExtensions [azure-cli.extensions.account azure-cli.extensions.resource-graph])
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
  ];
}
