# Parent Module Variables
# Child module variables should be empty or default to false
variable "instance_override" {
type = bool
default = true
}
variable "instance_type" {
type = string
default = "t3.micro"
}
