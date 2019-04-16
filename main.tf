# Variables
variable "gcp_project" {
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

# Cluster
provider "google" {
  credentials = "${file("./keys/gcp-terraform.json")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

resource "google_container_cluster" "demo" {
  name               = "demo-cluster"
  network            = "default"
  zone               = "${var.zone}"

  initial_node_count = 3
}
