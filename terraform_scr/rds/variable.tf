variable "identifier" {
  description = "Name of the DB"
  default     = "amogus"
}

variable "instance_class" {
  description = "DB instance type"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "DB size"
  default     = 20
}

variable "engine" {
  description = "Type of DB engine"
  default     = "postgres"
}

variable "engine_version" {
  default = "16.1"
}

variable "username" {
  description = "Name of the DB user"
  default     = "amogus"
}

variable "password" {
  description = "RDS password"
  type        = string
}
