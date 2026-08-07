terraform {
  required_version = ">= 1.0.0"
  required_providers {
    genesyscloud = {
      source  = "mypurecloud/genesyscloud"
      version = "~> 1.0"
    }
  }
}

variable "oauth_id" {
  type    = string
  default = ""
}

variable "oauth_secret" {
  type    = string
  default = ""
}

provider "genesyscloud" {
  oauthclient_id     = var.oauth_id != "" ? var.oauth_id : null
  oauthclient_secret = var.oauth_secret != "" ? var.oauth_secret : null
  aws_region         = "ap-northeast-1"
}

# 1. FIXED: Changed name prefix to bypass the duplicate value error
resource "genesyscloud_routing_skill" "support_skill" {
  name = "TF Technical Support"
}

# 2. FIXED: Appended service level parameters to satisfy the >= 0.01 API constraint rule
resource "genesyscloud_routing_queue" "support_queue" {
  name        = "Tech Support Queue"
  description = "Queue managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec = 20
    service_level {
      percentage = 0.80  # Target answering 80% of calls...
      duration_ms = 20000 # ...within 20 seconds
    }
  }
}