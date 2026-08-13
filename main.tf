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
# SECTION 1: ROUTING SKILLS DEFINITIONS (3 Skills)
# =========================================================================

resource "genesyscloud_routing_skill" "skill_1" {
  name = "Sales Skill vv2"
}

resource "genesyscloud_routing_skill" "skill_2" {
  name = "Billing Skill vv2"
}

resource "genesyscloud_routing_skill" "skill_3" {
  name = "Retention Skill vv2"
}

# =========================================================================
# SECTION 2: FULLY-CONFIGURED MULTI-MEDIA ROUTING QUEUES (3 Queues)
# =========================================================================

# ---- QUEUE 1: Sales ----
resource "genesyscloud_routing_queue" "queue_1" {
  name                          = "Sales Queue vv2"
  description                   = "Managed via Terraform CI/CD"
  division_id                   = "ac2ef38b-9aab-40e9-ba47-10e121cd1d81" # Home Division
  
  # Core Operational Flags
  auto_answer_only              = true
  enable_transcription          = true
  enable_audio_monitoring       = true
  suppress_in_queue_call_recording = false
  
  # Routing & Logic Choices
  scoring_method                = "TimestampAndPriority"
  skill_evaluation_method        = "ALL"
  
  # After Call Work (3000ms = 3 seconds)
  acw_wrapup_prompt             = "MANDATORY_TIMEOUT"
  acw_timeout_ms                = 3000

  # Architect Flow & Prompt System Mappings
  queue_flow_id                 = "37c8d13f-a6d3-4e8b-b43d-c5bf9e0c795e"
  on_hold_prompt_id             = "7046e8b6-6404-437e-b62c-2ca86f2345ac"
  whisper_prompt_id             = "f3e65012-b70c-4bb8-857d-92d72263270c"

  # Outbound CID Profiles
  calling_party_name            = "Test1"
  calling_party_number          = "+1234567"

  # ---- Voice Configuration ----
  media_settings_call {
    enable_auto_answer        = true
    alerting_timeout_sec      = 8
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }

  # ---- Callback Configuration ----
  media_settings_callback {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }

  # ---- Chat Configuration ----
  media_settings_chat {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }

  # ---- Email Configuration ----
  media_settings_email {
    alerting_timeout_sec      = 300
    service_level_percentage  = 0.80
    service_level_duration_ms = 86400000 # 24 hours
  }

  # ---- Messaging Configuration ----
  media_settings_message {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }

  # FIXED: Expanded blocks cleanly onto separate lines with no semicolons
  members {
    user_id  = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"
    ring_num = 1
  }
  members {
    user_id  = "c471d185-f4bf-4c16-a848-c470a039f624"
    ring_num = 1
  }
}

# ---- QUEUE 2: Billing ----
resource "genesyscloud_routing_queue" "queue_2" {
  name                          = "Billing Queue vv2"
  description                   = "Managed via Terraform CI/CD"
  division_id                   = "ac2ef38b-9aab-40e9-ba47-10e121cd1d81"
  
  auto_answer_only              = true
  enable_transcription          = true
  enable_audio_monitoring       = true
  suppress_in_queue_call_recording = false
  scoring_method                = "TimestampAndPriority"
  skill_evaluation_method        = "ALL"
  acw_wrapup_prompt             = "MANDATORY_TIMEOUT"
  acw_timeout_ms                = 3000
  
  queue_flow_id                 = "37c8d13f-a6d3-4e8b-b43d-c5bf9e0c795e"
  on_hold_prompt_id             = "7046e8b6-6404-437e-b62c-2ca86f2345ac"
  whisper_prompt_id             = "f3e65012-b70c-4bb8-857d-92d72263270c"
  
  calling_party_name            = "Test1"
  calling_party_number          = "+1234567"

  media_settings_call {
    enable_auto_answer        = true
    alerting_timeout_sec      = 8
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }
  media_settings_callback {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }
  media_settings_chat {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }
  media_settings_email {
    alerting_timeout_sec      = 300
    service_level_percentage  = 0.80
    service_level_duration_ms = 86400000
  }
  media_settings_message {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }

  # FIXED: Expanded blocks cleanly onto separate lines with no semicolons
  members {
    user_id  = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"
    ring_num = 1
  }
  members {
    user_id  = "c471d185-f4bf-4c16-a848-c470a039f624"
    ring_num = 1
  }
}

# ---- QUEUE 3: Retention ----
resource "genesyscloud_routing_queue" "queue_3" {
  name                          = "Retention Queue vv2"
  description                   = "Managed via Terraform CI/CD"
  division_id                   = "ac2ef38b-9aab-40e9-ba47-10e121cd1d81"
  
  auto_answer_only              = true
  enable_transcription          = true
  enable_audio_monitoring       = true
  suppress_in_queue_call_recording = false
  scoring_method                = "TimestampAndPriority"
  skill_evaluation_method        = "ALL"
  acw_wrapup_prompt             = "MANDATORY_TIMEOUT"
  acw_timeout_ms                = 3000
  
  queue_flow_id                 = "37c8d13f-a6d3-4e8b-b43d-c5bf9e0c795e"
  on_hold_prompt_id             = "7046e8b6-6404-437e-b62c-2ca86f2345ac"
  whisper_prompt_id             = "f3e65012-b70c-4bb8-857d-92d72263270c"
  
  calling_party_name            = "Test1"
  calling_party_number          = "+1234567"

  media_settings_call {
    enable_auto_answer        = true
    alerting_timeout_sec      = 8
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }
  media_settings_callback {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }
  media_settings_chat {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }
  media_settings_email {
    alerting_timeout_sec      = 300
    service_level_percentage  = 0.80
    service_level_duration_ms = 86400000
  }
  media_settings_message {
    alerting_timeout_sec      = 30
    service_level_percentage  = 0.80
    service_level_duration_ms = 20000
  }

  # FIXED: Expanded blocks cleanly onto separate lines with no semicolons
  members {
    user_id  = "06856e49-d2b7-44db-8bf9-e7cd5d5bf255"
    ring_num = 1
  }
  members {
    user_id  = "c471d185-f4bf-4c16-a848-c470a039f624"
    ring_num = 1
  }
}