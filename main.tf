# =========================================================================
# 1. TERRAFORM RUNTIME CONFIGURATION (Compatible with pipeline 1.5.7)
# =========================================================================
terraform {
  required_version = ">= 1.0.0" # Allows your pipeline's 1.5.7 version to pass
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

# =========================================================================
# 2. CALL ROUTING CONFIGURATION (Appends your new number)
# =========================================================================
resource "genesyscloud_architect_ivr" "afi_customer" {
  # Tells Terraform 1.5.7 to modify the existing routing instanced asset directly
  id                 = "6823e346-fe8f-429a-bdb9-c7405982b3ce"
  name               = "AFI Customer"
  division_id        = "ac2ef38b-9aab-40e9-ba47-10e121cd1d81"
  open_hours_flow_id = "2653f413-c551-43fa-a749-33b37df6172a"

  # All 3 numbers must exist here so the existing paths don't get deleted
  dnis = [
    "+622648635993",
    "+622648635999",
    "+622648635995"  # <-- Your newly added target number
  ]
}
