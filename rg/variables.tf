#---------Resource-group variables-----
variable "resource_group_name" {
    description = "Resource group name"
    type = string
    default = "jenkins-pipers"
}

variable "resource_group_location" {
    description = "Rs location"
    type = string
    default = "eastus2"
