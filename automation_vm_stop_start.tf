resource "azurerm_automation_schedule" "vm_start" {
  name                    = var.automation_schedule_vm_start_name
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.main.name
  frequency               = var.start_job_frequency
  interval                = var.start_job_interval
  timezone                = "Etc/UTC"
  start_time              = var.start_job_start_time
  description             = var.automation_schedule_vm_start_description
}

resource "azurerm_automation_schedule" "vm_stop" {
  name                    = var.automation_schedule_vm_stop_name
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.main.name
  frequency               = var.stop_job_frequency
  interval                = var.stop_job_interval
  timezone                = "Etc/UTC"
  start_time              = var.stop_job_start_time
  description             = var.automation_schedule_vm_stop_description
}

data "local_file" "simple_azure_vm_start_stop" {
  filename = "${path.module}/scripts/SimpleAzureVMStartStop.ps1"
}

resource "azurerm_automation_runbook" "simple_azure_vm_start_stop" {
  name                    = "Simple-Azure-VM-Start-Stop"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.main.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "Start or stop virtual machines"
  runbook_type            = "PowerShell"
  content                 = data.local_file.simple_azure_vm_start_stop.content
}

resource "azurerm_automation_job_schedule" "vm_start" {
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.main.name
  schedule_name           = azurerm_automation_schedule.vm_start.name
  runbook_name            = azurerm_automation_runbook.simple_azure_vm_start_stop.name

  parameters = {
    resourcegroupname = var.target_resource_group_name
    accountid         = azurerm_user_assigned_identity.automation.client_id
    vmname            = var.vmname
    action            = "start"
  }
}

resource "azurerm_automation_job_schedule" "vm_stop" {
  resource_group_name     = var.resource_group_name
  automation_account_name = azurerm_automation_account.main.name
  schedule_name           = azurerm_automation_schedule.vm_stop.name
  runbook_name            = azurerm_automation_runbook.simple_azure_vm_start_stop.name

  parameters = {
    resourcegroupname = var.target_resource_group_name
    accountid         = azurerm_user_assigned_identity.automation.client_id
    vmname            = var.vmname
    action            = "stop"
  }
}
