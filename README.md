# Multi-Account Patch Management & Fleet Automation

Reusable Terraform modules for AWS Systems Manager patch baselines, scheduled
maintenance windows, and execution notifications.

## Layout

- `modules/patch-baseline`: baseline and patch-group association.
- `modules/maintenance-window`: maintenance schedule, tagged instance target,
  and patch task.
- `modules/notifications`: EventBridge rule and SNS notifications.
- `modules/iam`: Terraform deployment and Systems Manager maintenance-window
  roles, with separate policy files.
- `examples/member-account`: example composition of the reusable modules for
  one account and Region.

Each module contains `main.tf`, `input.tf`, and `output.tf`. Terraform loads
all `.tf` files in the example directory, including `providers.tf`,
`variables.tf`, `outputs.tf`, and `locals.tf`. The patch group is configured in
`patch_group.tf`; the example creates the deployment and maintenance-window
roles using the IAM module.

## Requirements and quick start

- Terraform `>= 1.6.0, < 2.0.0`
- AWS provider `>= 5.0, < 7.0`
- Initial AWS credentials with permission to create the example's resources
  and IAM roles in the target account
- Target instances registered as Systems Manager managed nodes and tagged
  with the configured patch-group key/value

From `examples/member-account`:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
# Set your AWS Region and other desired values.
terraform init
terraform validate
terraform plan
terraform apply
```

Terraform discovers the current caller's account ID and IAM principal during
planning, including the source IAM role when the credentials are an assumed
role. It creates the deployment role trusting that caller, so no deployment
trust ARN or account ID needs to be entered. The initial apply uses your
current AWS credentials, which need permission to create IAM roles and
policies, plus the other resources in the plan. After the apply succeeds, set
`assume_deployment_role = true` in `terraform.tfvars` and run `terraform plan`
and `terraform apply` again.

The deployment role trusts only the IAM principal Terraform discovers from
the bootstrap credentials. When those credentials come from an assumed role,
that source role must also be allowed to call `sts:AssumeRole`. Use an
approved AWS credential chain or CI secret store; never commit credentials
or populated `terraform.tfvars`. An SNS email endpoint must confirm its
subscription.

The patch group defaults to `fleet-patch-test` and can be changed in
`terraform.tfvars`. Tag the test EC2 managed node with the matching value for
the configured patch-group tag key.

The example deploys into one account and Region. For Organizations-scale
rollouts, use an external pipeline or Systems Manager Automation to select
accounts, regions, and staged batches. The modules do not bootstrap
cross-account roles or provide a global pause/rollback controller.

Review patch approval filters, concurrency, error thresholds, reboot policy,
and recovery procedures for your operating environment before production use.

Before `terraform destroy`, set `assume_deployment_role = false` and use
bootstrap credentials authorized to delete the managed resources and IAM
roles. The deployment role intentionally does not grant IAM role deletion.
