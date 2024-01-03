remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    role_arn = "arn:aws:iam::985504043303:role/infra-svc-poc-role" 
    bucket = "infraservice-skyu-poc"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamo_table = "terraform-lock-dynamo_table"
    }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
    provider "aws" {
        region = "us-east-1"
    }
    EOF
}
