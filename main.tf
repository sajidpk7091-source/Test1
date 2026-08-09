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

# =========================================================================
# SECTION 1: ROUTING SKILLS DEFINITIONS
# =========================================================================

resource "genesyscloud_routing_skill" "skill_1" {
  name = "Sales Skill v1" # Change to your preferred Skill 1 Name
}

resource "genesyscloud_routing_skill" "skill_2" {
  name = "Billing Skill v1" # Change to your preferred Skill 2 Name
}

resource "genesyscloud_routing_skill" "skill_3" {
  name = "Retention Skill v1" # Change to your preferred Skill 3 Name
}

# =========================================================================
# SECTION 2: ROUTING QUEUES DEFINITIONS WITH 5 AGENTS MAPPED
# =========================================================================

# ---- QUEUE 1 ----
resource "genesyscloud_routing_queue" "queue_1" {
  name        = "Sales Queue v1" # Change to your preferred Queue 1 Name
  description = "Managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec      = 20
    service_level_percentage  = 0.80   
    service_level_duration_ms = 20000  
  }

  # Copy and paste this block style for all 5 of your existing agents
  members { user_id = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"; ring_num = 1 } # Agent 1
  members { user_id = "1678db58-141e-400d-ba4b-5fd94b060c2a"; ring_num = 1 } # Agent 2
  members { user_id = "c471d185-f4bf-4c16-a848-c470a039f624"; ring_num = 1 } # Agent 3
  members { user_id = "11f1ca67-69e6-447c-8d87-b82aab833f86"; ring_num = 1 } # Agent 4
  members { user_id = "2a18e8d6-df0d-44b4-af7c-7631c875ffb5"; ring_num = 1 } # Agent 5
}

# ---- QUEUE 2 ----
resource "genesyscloud_routing_queue" "queue_2" {
  name        = "Billing Queue v1" # Change to your preferred Queue 2 Name
  description = "Managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec      = 20
    service_level_percentage  = 0.80   
    service_level_duration_ms = 20000  
  }

  
 members { user_id = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"; ring_num = 1 } # Agent 1
  members { user_id = "1678db58-141e-400d-ba4b-5fd94b060c2a"; ring_num = 1 } # Agent 2
  members { user_id = "c471d185-f4bf-4c16-a848-c470a039f624"; ring_num = 1 } # Agent 3
  members { user_id = "11f1ca67-69e6-447c-8d87-b82aab833f86"; ring_num = 1 } # Agent 4
  members { user_id = "2a18e8d6-df0d-44b4-af7c-7631c875ffb5"; ring_num = 1 } # Agent 5
}

# ---- QUEUE 3 ----
resource "genesyscloud_routing_queue" "queue_3" {
  name        = "Retention Queue v1" # Change to your preferred Queue 3 Name
  description = "Managed via Terraform CI/CD"

  media_settings_call {
    alerting_timeout_sec      = 20
    service_level_percentage  = 0.80   
    service_level_duration_ms = 20000  
  }

  
 members { user_id = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"; ring_num = 1 } # Agent 1
  members { user_id = "1678db58-141e-400d-ba4b-5fd94b060c2a"; ring_num = 1 } # Agent 2
  members { user_id = "c471d185-f4bf-4c16-a848-c470a039f624"; ring_num = 1 } # Agent 3
  members { user_id = "11f1ca67-69e6-447c-8d87-b82aab833f86"; ring_num = 1 } # Agent 4
  members { user_id = "2a18e8d6-df0d-44b4-af7c-7631c875ffb5"; ring_num = 1 } # Agent 5
}