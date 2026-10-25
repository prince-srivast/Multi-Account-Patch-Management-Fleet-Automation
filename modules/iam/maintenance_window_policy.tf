resource "aws_iam_role_policy_attachment" "maintenance_window" {
  role       = aws_iam_role.maintenance_window.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonSSMMaintenanceWindowRole"
}
