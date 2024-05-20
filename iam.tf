#------------------------------------------------------------------------------
# Admins
#------------------------------------------------------------------------------
resource "aws_iam_group" "admin_users" {
  name = "${local.name_pascal_case}Admins"
}

data "aws_iam_policy" "admin_policies" {
  for_each = toset(var.admin_user_iam_policies)
  arn      = each.value
}

resource "aws_iam_group_policy_attachment" "admins_policy_attachments" {
  for_each   = data.aws_iam_policy.admin_policies
  group      = aws_iam_group.admin_users.name
  policy_arn = each.value.arn
}

resource "aws_iam_group_membership" "admin_group_membership" {
  name  = "${local.name}-admin-group-membership"
  group = aws_iam_group.admin_users.name
  users = var.admin_users
}

#------------------------------------------------------------------------------
# Developers
#------------------------------------------------------------------------------
resource "aws_iam_group" "dev_users" {
  name = "${local.name_pascal_case}Developers"
}

data "aws_iam_policy" "dev_policies" {
  for_each = toset(var.dev_user_iam_policies)
  arn      = each.value
}

resource "aws_iam_group_policy_attachment" "devs_policy_attachments" {
  for_each   = data.aws_iam_policy.dev_policies
  group      = aws_iam_group.dev_users.name
  policy_arn = each.value.arn
}

resource "aws_iam_group_membership" "dev_group_membership" {
  name  = "${local.name}-dev-group-membership"
  group = aws_iam_group.dev_users.name
  users = var.dev_users
}

#------------------------------------------------------------------------------
# Viewers
#------------------------------------------------------------------------------
resource "aws_iam_group" "basic_users" {
  name = "${local.name_pascal_case}Viewers"
}

data "aws_iam_policy" "viewers_policies" {
  for_each = toset(var.basic_user_iam_policies)
  arn      = each.value
}

resource "aws_iam_group_policy_attachment" "viewers_policy_attachments" {
  for_each   = data.aws_iam_policy.viewers_policies
  group      = aws_iam_group.basic_users.name
  policy_arn = each.value.arn
}

resource "aws_iam_group_membership" "viewers_group_membership" {
  name  = "${local.name}-viewers-group-membership"
  group = aws_iam_group.basic_users.name
  users = var.basic_users
}
