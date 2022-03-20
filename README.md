# Terraform AWS ECS cron module
## How to use
```tf
module "telegram_bot" {
  source = "git::ssh://git@github.com/thebitrock/tf-serverless-telegram-bot.git"

  identifier = "bot29385"
  source_dir = "./codebase"
  bot_token  = local.bot_token
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
| source\_dir | Dir with js code | `string` | n/a | yes |
| bot\_token | Bot token from @BotFather | `string` | n/a | yes |
| hook\_path | Hook path to endpoint | `string` | `bot` | no |

## Outputs

| Name | Description |
|------|-------------|
| webhook\_url | Created API Gateway endpoint url |