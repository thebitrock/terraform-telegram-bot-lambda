# Terraform AWS Lambda Telegram Bot (Telegraf)
## How to use
```tf
provider "null" {}

locals {
  bot_token = "5232542702:AAEdliWuw_6WeDW-qCrfhsyEC49YgABd3E8"
}

module "telegram_bot" {
  source = "git::ssh://git@github.com/thebitrock/tf-serverless-telegram-bot.git"

  identifier = "bot29385"
  source_dir = "./codebase"
  bot_token  = local.bot_token
}

resource "null_resource" "set_webhook" {
  provisioner "local-exec" {
    command     = "curl -Ls -X GET https://api.telegram.org/bot${local.bot_token}/setWebHook?url=${module.human_loc_sltb.webhook_url}"
    interpreter = ["/bin/sh", "-c"]
  }

  depends_on = [
    module.human_loc_sltb
  ]

  triggers = {
    webhook_endpoint = module.human_loc_sltb.webhook_url
  }
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| identifier | Bot identifier | `string` | n/a | yes |
| source\_dir | Path to folder with js code | `string` | n/a | yes |
| bot\_token | Bot token from @BotFather | `string` | n/a | yes |
| hook\_path | Hook path to endpoint | `string` | `bot` | no |

## Outputs

| Name | Description |
|------|-------------|
| webhook\_url | Created API Gateway endpoint url |