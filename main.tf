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

# 1. Unique skill name to prevent duplicate value errors
resource "genesyscloud_routing_skill" "support_skill" {
  name = "TF Technical Support"
}

# 2. FIXED: Placed service level parameters inside the media block as flat arguments
resource "genesyscloud_routing_queue" "support_queue" {
  name        = "Tech Support Queue"
  description = "Queue managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec      = 20
    service_level_percentage  = 0.80   # Target answering 80% of calls (satisfies the >= 0.01 API constraint)
    service_level_duration_ms = 20000  # Within 20 seconds (20000 ms)
  }
}