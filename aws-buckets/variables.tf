variable "buckets_workspace" {
    type = map(string)
    default = {
      "dev" = "dev"
      "preprod" = "preprod"
      "prod" = "prod"
    }
  
}