# Learn Migrate Terraform Provider

## Getting Started

Login to Azure.

```bash
az login
```

Initialize the Terraform configuration.

```bash
terraform init
```

## Development

Create a plan.

```bash
terraform plan -no-color -out tfplan > tfplan.txt
```

Apply the plan.

```bash
terraform apply "tfplan"
```

## Migrate AzureRM Terraform Provider v3 to v4

> Learn more about the [AzureRM Provider v4 Upgrade Guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/4.0-upgrade-guide).

Step 1: Update the Provider Version

```diff
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
-     version = "~> 3.112.0"
+     version = "~> 4.16.0"
    }
  }
}
```

Step 2: Update the Provider Configuration

```bash
terraform init -upgrade
```

Step 3: Add `subscription_id` to the Provider Configuration

> In version 4.0 of the Azure Provider, it's now required to specify the Azure Subscription ID when configuring a provider instance in your configuration.

```diff
provider "azurerm" {
+ subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}
```

### [Optional] If you need to migrate deprecated resources type to new resources types

Step 4: Change deprecated resources types to new resources types in Terraform code

```diff
- resource "azurerm_app_service_plan" "example" {
+ resource "azurerm_service_plan" "example" {
    name                = "asp-example"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    ...
  }
```

Step 5: Change resources type in Terraform state

```bash
terraform state rm azurerm_app_service_plan.example
terraform state import azurerm_service_plan.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-example/providers/Microsoft.Web/serverFarms/asp-example
```

Step 6: Run `terraform plan` with expected no changes if possible and no deprecated warnings

```bash
terraform plan
```
