# Create the news developer user
resource "aws_iam_user" "dev1" {
  name = "dev1"
}

resource "aws_iam_user" "dev2" {
  name = "dev2"
}