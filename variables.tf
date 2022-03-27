variable "identifier" {
  type        = string
  description = "Telegram Bot unique name"
}

variable "bot_token" {
  type        = string
  description = "Telegram Bot token"
}

variable "source_dir" {
  type        = string
  description = "Path to js source code"
}

variable "hook_path" {
  type    = string
  default = "bot"
}

variable "environment_variables" {
  type    = map(any)
  default = {}
}
