variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "identifiers" {
  description = "List of resource ARNs that this statement applies to."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
