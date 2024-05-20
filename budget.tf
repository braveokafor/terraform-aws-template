resource "aws_budgets_budget" "monthly" {
  name         = "${local.name}-monthly-budget"
  budget_type  = "COST"
  limit_amount = var.monthly_budget
  limit_unit   = var.budget_currency
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = var.budget_alert_thresholds
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = var.budget_alert_emails
    }
  }

  tags = local.tags
}