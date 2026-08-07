terraform {
  required_version = ">= 1.0.0"
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.0"
    }
  }
}

provider "genesyscloud" {
  # Credentials are provided automatically via the environment variables 
  # defined in deploy.yml
}

# 1. Create a Routing Skill
resource "genesyscloud_routing_skill" "support_skill" {
  name = "Technical Support"
}

# 2. Create a Media Queue
resource "genesyscloud_routing_queue" "support_queue" {
  name        = "Tech Support Queue"
  description = "Queue managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec = 20
  }
}
