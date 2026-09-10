# Add this block to tie your code to the existing Genesys configuration
import {
  to = genesyscloud_architect_ivr.afi_customer
  id = "6823e346-fe8f-429a-bdb9-c7405982b3ce"
}

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

resource "genesyscloud_architect_ivr" "afi_customer" {
  name        = "AFI Customer"
  division_id = "ac2ef38b-9aab-40e9-ba47-10e121cd1d81"

  # The numbers are now successfully consolidated
  dnis = [
    "+622648635993",
    "+622648635999",
    "+622648635995"
  ]

  open_hours_flow_id = "2653f413-c551-43fa-a749-33b37df6172a"
}
