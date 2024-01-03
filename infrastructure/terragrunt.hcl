remote_state {
    backend = "s3"
    generate = {
        path = "state.tf"
        tf_exists = "overwrite_terragrunt"
    }

    config = {
       profile = ""
       role_arn = "arn:aws:iam::985504043303:role/infra-svc-poc-role" 
       bucket = ""

    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamo_table = "terraform-lock-dynamo_table
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"

    contents = <<EOF
        provider "aws" {
        region = "us-east-1"
        profile = ""

        assume_role {
            session_name = ""
            role_arn = ""
        }
    }
    EOF
}

