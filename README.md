# Multi-Account Patch Management & Fleet Automation

Reusable Terraform modules for AWS Systems Manager patch baselines, scheduled
maintenance windows, and execution notifications.

## Layout

- `modules/patch-baseline`: baseline and patch-group association.
- `modules/maintenance-window`: maintenance schedule, tagged instance target,
  and patch task.
- `modules/notifications`: EventBridge rule and SNS notifications.
- `examples/member-account`: example composition of the reusable modules for
  one account and Region.

Each module contains `main.tf`, `input.tf`, and `output.tf`. Terraform loads
all `.tf` files in the example directory, including `providers.tf`,
`variables.tf`, `outputs.tf`, and `locals.tf`. The example local centralizes
the resource-name prefix shared by the modules.

## Requirements and quick start

- Terraform `>= 1.6.0, < 2.0.0`
- AWS provider `>= 5.0, < 7.0`
- An existing deployment role and Systems Manager maintenance-window service
  role in the target account
- Target instances registered as Systems Manager managed nodes and tagged
  with the configured patch-group key/value

From `examples/member-account`:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
# Update the role ARNs, Region, patch group, and schedule.
terraform init
terraform validate
terraform plan
terraform apply
```

Use an approved AWS credential chain or CI secret store to authorize the
deployment role. Never commit credentials or populated `terraform.tfvars`.
An SNS email endpoint must confirm its subscription.

The example deploys into one account and Region. For Organizations-scale
rollouts, use an external pipeline or Systems Manager Automation to select
accounts, regions, and staged batches. The modules do not bootstrap
cross-account roles or provide a global pause/rollback controller.

Review patch approval filters, concurrency, error thresholds, reboot policy,
and recovery procedures for your operating environment before production use.
