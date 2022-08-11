resource "azurerm_automation_account" "main" {
  name                = var.automation_account_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.automation.id]
  }
}

