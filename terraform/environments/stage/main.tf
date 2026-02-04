terraform {
  backend "s3" {
    bucket         = "gitops-devops-portfolio-tfstate"
    key            = "envs/stage/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "gitops-devops-portfolio-locks"
    encrypt        = true
  }
}

// Placeholder for stage environment configuration.
// Copy patterns from dev once networking and cluster modules are parameterized.
