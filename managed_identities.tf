resource "azurerm_role_definition" "stop_start_vm" {
  count       = var.manage_role_definition ? 1 : 0
  name        = "StopStartVM"
  scope       = data.azurerm_subscription.primary.id
  description = "Allow stopping and starting VMs in the primary subscription"

  permissions {
    actions     = ["Microsoft.Network/*/read",
                   "Microsoft.Compute/*/read",
                   "Microsoft.Compute/virtualMachines/start/action",
                   "Microsoft.Compute/virtualMachines/restart/action",
                   "Microsoft.Compute/virtualMachines/deallocate/action"]
    not_actions = []
  }
}

resource "azurerm_user_assigned_identity" "automation" {
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  name = var.user_assigned_identity_name
}

# The built-in role definition IDs are hardcoded. This data source just makes
# things more readable for humans.
data "azurerm_role_definition" "virtual_machine_contributor" {
  role_definition_id = "9980e02c-c2be-4d73-94e8-173b1dc7cf3c"
}

resource "azurerm_role_assignment" "automation" {
  count              = var.manage_role_assignment ? 1 : 0
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = var.manage_role_definition ? azurerm_role_definition.stop_start_vm[0].role_definition_resource_id : data.azurerm_role_definition.virtual_machine_contributor.role_definition_id
  principal_id       = azurerm_user_assigned_identity.automation.principal_id
}
