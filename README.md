# terraform-azurerm_vm_stop_start

Simple Terraform module for setting VM start and stop schedules in Azure using
Azure Automation. An explanation of how this all the pieces fit together is
available in [this blog post](https://www.puppeteers.net/blog/modern-cronjob-part-1-azure-automation-with-terraform/).

# Usage

This script uses
[Simple-Azure-VM-Start-Stop](https://github.com/diecknet/Simple-Azure-VM-Start-Stop)
Powershell script under the hood.

Simple usage:

    module "automation" {
      source                           = "github.com/Puppet-Finland/terraform-azurerm_vm_stop_start"
      automation_account_name          = "development"
      user_assigned_identity_name      = "my-managed-identity"
      resource_group_location          = azurerm_resource_group.main.location
      resource_group_name              = azurerm_resource_group.main.name
      subscription_id                  = data.azurerm_subscription.current.id
      target_resource_group_name       = "development-rg"
      vmname                           = "testvm"
    }

The "vmname" parameter accepts the name of a single VM. If special value \* is provided, then all
VMs in the **target_resource_group** will be affected.

If you want to use a built-in "Virtual Machine Contributor" instead of the more limited, custom role
definition, then set manage_role_definition to false:

    module "automation" {
      --- snip ---
      manage_role_definition = false
      manage_role_assignment = false
      --- snip ---
    }

Check [input.tf](input.tf) to see all the available parameters.
