This is a Terraform blueprint for setting up the simplest Kubernetes cluster on GCP (Google Cloud Platform). The purpose of this repository is for demonstration purposes only.

## Requirements

- [Terraform](https://www.terraform.io/downloads.html)
- [Google Cloud SDK](https://cloud.google.com/sdk/)
- [Google Cloud Account](https://console.cloud.google.com)
- [Enabled Kubernetes API](https://console.cloud.google.com/apis/dashboard)

## Setup Service Account for Terraform

Open the [Service Accounts](https://console.cloud.google.com/iam-admin/serviceaccounts) and create one new Service Account (e.g. named terraform) for this usage. When selecting the role, select the Editor role from Project scope.

In the Service Account details, create a new account key. This will generate and download a json file. Place it under the `keys` directory with the name `gcp-terraform.json`. If you place it in any other place or with any other name, please feel free to change the `main.tf` file to reflect it.

## Setup the cluster

First, init the terraform context. This will setup the necessary dependencies to use Terraform with GCP.

    terraform init

Terraform Plan will give you the details of what is to be created. In this case, it will create a single resource that represents a K8s cluster in the default network, with 3 initial nodes from the default node pool.

    terraform plan

After confirming the changes, run apply them by issuing the following command:

    terraform apply

Both plan and apply will ask the user to enter the GCP Project. To avoid the interactive shell, please include the `-var` flag in the command, like so:

    terraform plan -var 'gcp_project=my_project'

It may take a while, after which the Kubernetes cluster should be created. To use this cluster with `kubectl`, it's necessary to configure the context first:

    gcloud container clusters get-credentials demo-cluster

## Get configured contexts

Likely you are using Minikube as a local K8s enviornment and GCP for development and production environments. To retrieve all the available contexts use the following command:

    kubectl config get-contexts

## Swiching between contexts

Likely you are using Minikube as a local K8s enviornment. To switch between GCP and Minikube (or any other context), execute the following command:

    kubectl config use-context minikube
    kubectl config use-context <context name>

## Deploying Containers

Please refer to [hellofromhost](https://github.com/picadoh/hellofromhost) as a simple application that can be deployed into a K8s cluster for demonstration purposes.