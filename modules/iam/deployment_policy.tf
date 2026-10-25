resource "aws_iam_role_policy" "deployment" {
  name = "${var.name_prefix}-deployment"
  role = aws_iam_role.deployment.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "ManagePatchBaselinesAndMaintenanceWindows"
        Effect = "Allow"
        Action = [
          "ssm:CreatePatchBaseline",
          "ssm:UpdatePatchBaseline",
          "ssm:DeletePatchBaseline",
          "ssm:RegisterPatchBaselineForPatchGroup",
          "ssm:DeregisterPatchBaselineForPatchGroup",
          "ssm:DescribePatchBaselines",
          "ssm:GetPatchBaseline",
          "ssm:DescribePatchGroups",
          "ssm:GetPatchBaselineForPatchGroup",
          "ssm:ListTagsForResource",
          "ssm:AddTagsToResource",
          "ssm:RemoveTagsFromResource",
          "ssm:CreateMaintenanceWindow",
          "ssm:UpdateMaintenanceWindow",
          "ssm:DeleteMaintenanceWindow",
          "ssm:DescribeMaintenanceWindows",
          "ssm:GetMaintenanceWindow",
          "ssm:RegisterTargetWithMaintenanceWindow",
          "ssm:DeregisterTargetFromMaintenanceWindow",
          "ssm:DescribeMaintenanceWindowTargets",
          "ssm:GetMaintenanceWindowTarget",
          "ssm:RegisterTaskWithMaintenanceWindow",
          "ssm:DeregisterTaskFromMaintenanceWindow",
          "ssm:DescribeMaintenanceWindowTasks",
          "ssm:GetMaintenanceWindowTask",
          "ssm:DescribeMaintenanceWindowExecutions",
          "ssm:DescribeMaintenanceWindowExecutionTasks"
        ]
        Resource = "*"
      },
      {
        Sid    = "ManageMaintenanceEventNotifications"
        Effect = "Allow"
        Action = [
          "events:PutRule",
          "events:DeleteRule",
          "events:DescribeRule",
          "events:PutTargets",
          "events:RemoveTargets",
          "events:ListTargetsByRule",
          "events:ListTagsForResource",
          "events:TagResource",
          "events:UntagResource",
          "sns:CreateTopic",
          "sns:DeleteTopic",
          "sns:GetTopicAttributes",
          "sns:SetTopicAttributes",
          "sns:ListTopics",
          "sns:ListSubscriptionsByTopic",
          "sns:Subscribe",
          "sns:Unsubscribe",
          "sns:Publish",
          "sns:TagResource",
          "sns:UntagResource"
        ]
        Resource = "*"
      },
      {
        Sid      = "PassMaintenanceWindowServiceRole"
        Effect   = "Allow"
        Action   = ["iam:PassRole"]
        Resource = "arn:${split(":", aws_iam_role.deployment.arn)[1]}:iam::${split(":", aws_iam_role.deployment.arn)[4]}:role/${var.name_prefix}-maintenance-window"
      }
    ]
  })
}
