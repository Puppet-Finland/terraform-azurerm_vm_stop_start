resource "azurerm_role_definition" "stop_start_vm" {
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

resource "azurerm_role_assignment" "automation" {
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.stop_start_vm.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.automation.principal_id
}
