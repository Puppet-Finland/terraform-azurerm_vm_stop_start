output "runbook_name" {
  value = azurerm_automation_runbook.simple_azure_vm_start_stop.name
}

output "start_schedule_name" {
  value = azurerm_automation_schedule.vm_start.name
}

output "stop_schedule_name" {
  value = azurerm_automation_schedule.vm_stop.name
}

output "user_assigned_identity_client_id" {
  value = azurerm_user_assigned_identity.automation.client_id
}
