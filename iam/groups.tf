# Create a new developers group
resource "aws_iam_group" "developers" {
  name = "developers-group"
}

# Attach IAMReadOnlyAccess policy to the developers group
resource "aws_iam_group_policy_attachment" "iam_read_only_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

# Add dev1 to the developers group
resource "aws_iam_group_membership" "developers_group_membership" {
  name  = "developers_group_membership"
  group = aws_iam_group.developers.name
  users = [
    aws_iam_user.dev1.name,
    aws_iam_user.dev2.name
  ]
}

# a new testers group
resource "aws_iam_group" "testers" {
  name = "testers-group"
}

# Attach a list policy to the testers group
resource "aws_iam_group_policy_attachment" "multiple_policies_attachment" {
  count      = length(var.policy_arns)
  group      = aws_iam_group.testers.name
  policy_arn = var.policy_arns[count.index]
}
