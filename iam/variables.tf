# Create a variable to store the list of policy arn
variable "policy_arns" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    "arn:aws:iam::211125338837:policy/IAMGetUserOnly"
  ]
}