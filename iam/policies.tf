# Create the new custom policy
resource "aws_iam_policy" "iam_get_users_only_policy" {
  name        = "IAMGetUserOnly"
  path        = "/"
  description = "The customize policy which only get users from IAM service"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "iam:GetUser",
        "Resource" : "*"
      }
    ]
  })
}