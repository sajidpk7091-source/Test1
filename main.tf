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

# 1. Changed name prefix to bypass the duplicate value error
resource "genesyscloud_routing_skill" "support_skill" {
  name = "TF Technical Support"
}

# 2. FIXED: Moved service level properties out of media block down to root level attributes
resource "genesyscloud_routing_queue" "support_queue" {
  name                        = "Tech Support Queue"
  description                 = "Queue managed via Terraform CI/CD"
  
  # Root-level service constraint parameters matching Genesys schema rules
  service_level_percentage    = 0.80   # Target answering 80% of calls...
  service_level_duration_ms   = 20000  # ...within 20000 milliseconds (20 seconds)

  media_settings_call {
    alerting_timeout_sec = 20
  }
}