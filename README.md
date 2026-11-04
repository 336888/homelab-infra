# homelab-infra

> 自建服务器与家庭实验室基础设施配置 · Self-hosted infrastructure & homelab configs

## 结构 / Layout

```
compose/     Docker Compose 服务编排 / service stacks
nginx/       反向代理与 TLS 配置 / reverse proxy & TLS
scripts/     部署与备份脚本 / deploy & backup scripts
docs/        架构说明与踩坑记录 / architecture notes
```

## 原则 / Principles

- 一份配置同时适用于开发和家用环境 / one config for dev and home
- 所有服务可一键起停 / one-command up & down
- 备份优先，任何有状态服务都必须可恢复 / backup first

## 技术栈 / Stack

Docker · Nginx · Linux · Prometheus · Grafana

## 许可 / License

MIT
