variable "ecs-cluster-name" {
    description = "The name for the cluster."
    default = "wordpress-cluster"
}

variable "wordpress-image" {
    description = "The wordpress image"
    default = "wordpress:latest"
}

variable "database_name" {
  description = "The database name for Production"
}

variable "database_username" {
  description = "The username for the Production database"
}

variable "database_password" {
  description = "The user password for the Production database"
}