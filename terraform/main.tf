module "sandbox" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "<ACCOUNT EMAIL>"
    AccountName               = "sandbox-aft"
    ManagedOrganizationalUnit = "Learn AFT"
    SSOUserEmail              = "<SSO EMAIL>"
    SSOUserFirstName          = "Sandbox"
    SSOUserLastName           = "AFT"
  }

  account_tags = {
    "Learn Tutorial" = "AFT"
  }

  change_management_parameters = {
    change_requested_by = "HashiCorp Learn"
    change_reason       = "Learn AWS Control Tower Account Factory for Terraform"
  }

  custom_fields = {
    group = "non-prod"
  }

  account_customizations_name = "sandbox"
}

/*
  When merging to main, CodePipeline will call CodeBuild which will run terraform apply
  This will create a record in the DynamoDB table called aft-request
  The table will send a message via Dynamo Streams to a Lambda function called aft-account-request-action-trigger
  The function will format the record as an SQS message that will to the aft-account-request.fifo queue
*/
module "chatbot" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "default_aws_coe.encora+chatbot_003@yahoo.com"
    AccountName               = "Chatbot"
    ManagedOrganizationalUnit = "Sandbox"
    SSOUserEmail              = "default_aws_coe.encora+chatbot_dev_003@yahoo.com"
    SSOUserFirstName          = "Chatbot"
    SSOUserLastName           = "Developer"
  }

  account_tags = {
    "Origin" = "AFT"
  }

  change_management_parameters = {
    change_requested_by = "Encora Inc."
    change_reason       = "AWS CoE - PoC"
  }

  custom_fields = {
    group = "non-prod"
  }

  account_customizations_name = "sandbox"
}