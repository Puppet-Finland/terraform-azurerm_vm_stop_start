# Mandatory parameters
variable "automation_account_name" {
  type    = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "target_resource_group_name" {
  type = string
}

variable "vmname" {
  type    = string
}

# Optional parameters
variable "automation_schedule_vm_start_description" {
  type    = string
  default = "Start virtual machines"
}

variable "automation_schedule_vm_start_name" {
  type    = string
  default = "vm-start"
}

variable "automation_schedule_vm_stop_description" {
  type    = string
  default = "Stop virtual machines"
}

variable "automation_schedule_vm_stop_name" {
  type    = string
  default = "vm-stop"
}

variable "manage_role_assignment" {
  type        = bool
  description = "Whether to manage the role assignment"
  default     = true
}

variable "manage_role_definition" {
  type        = bool
  description = "Whether to create and use a restricted role defition for VM start/stop jobs"
  default     = true
}

variable "start" {
  type    = bool
  default = true
}

variable "stop" {
  type    = bool
  default = true
}

variable "start_job_frequency" {
  type    = string
  default = "Day"
}

variable "start_job_interval" {
  type    = number
  default = 1
}

variable "start_job_start_time" {
  type    = string
  default = "2022-08-12T01:50:00+00:00"
}

variable "stop_job_frequency" {
  type    = string
  default = "Day"
}

variable "stop_job_interval" {
  type    = number
  default = 1
}

variable "stop_job_start_time" {
  type    = string
  default = "2022-08-12T04:30:00+00:00"
}

variable "user_assigned_identity_name" {
  type    = string
  default = "automation"
}


