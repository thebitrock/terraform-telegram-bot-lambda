# Terraform AWS Lambda Telegram Bot (Telegraf)
## How to use

#### Create folder `codebase` and file `index.js` inside them. Path to file: `codebase/index.js`
```js
const { Telegraf } = require('telegraf')
// @ts-expect-error not a dependency of Telegraf
const makeHandler = require('lambda-request-handler')

const token = process.env.BOT_TOKEN
if (token === undefined) {
  throw new Error('BOT_TOKEN must be provided!')
}
const bot = new Telegraf(token, {
  telegram: { webhookReply: true },
})

bot.start((ctx) => ctx.reply('Hello!'))

module.exports.handler = makeHandler(
  bot.webhookCallback(process.env.BOT_HOOK_PATH ?? '/'),
)
```
#### Go to folder `codebase` and run `npm install --save telegraf lambda-request-handler`
#### In root path create terraform file like `serverlessbot.tf` and describe module use for example:
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

# After init bot module need set webhook for bot, this resource set webhook automatically after bot was created
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
#### Create bot and get your `bot_token` 
BotFather is the one bot to rule them all. 
Use it to create new bot accounts and manage your existing bots. 
[https://t.me/BotFather](https://t.me/BotFather)


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
