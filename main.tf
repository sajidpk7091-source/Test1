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

# 1. Unique skill name 
resource "genesyscloud_routing_skill" "support_skill" {
  name = "TF Technical Support"
}

# 2. Media Queue with Agent Member Mapped
resource "genesyscloud_routing_queue" "support_queue" {
  name        = "Tech Support Queue"
  description = "Queue managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec      = 20
    service_level_percentage  = 0.80   
    service_level_duration_ms = 20000  
  }

  # FIXED: Mapped your agent to the queue statefully using their User ID string
  members {
    user_id  = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"
    ring_num = 1 # Ring profile order priority level (First ring)
  }
}