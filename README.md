# homelab-infra

[![lint](https://github.com/336888/homelab-infra/actions/workflows/lint.yml/badge.svg)](https://github.com/336888/homelab-infra/actions/workflows/lint.yml)

> 自建服务器与家庭实验室基础设施配置 · Self-hosted infrastructure & homelab configs

一台机器、四个容器。nginx 对外，app / mysql / redis 只在内网。

## 结构 / Layout

```
compose/     docker compose 编排
nginx/       反向代理与 TLS
scripts/     备份脚本
docs/        架构说明
```

## 用法 / Usage

```bash
cp .env.example .env      # 改掉里面的密码
docker compose -f compose/docker-compose.yml up -d
```

备份由 cron 每天 3 点跑：

```bash
0 3 * * * /opt/homelab/scripts/backup.sh >> /var/log/backup.log 2>&1
```

## 原则 / Principles

- 一份配置同时适用于开发和家用环境 / one config for dev and home
- 所有服务可一键起停 / one-command up & down
- 备份优先，任何有状态服务都必须可恢复 / backup first
- 能不用 k8s 就不用，见 [docs/architecture.md](docs/architecture.md)

## 技术栈 / Stack

Docker · Nginx · Linux · MySQL · Redis

## 已知问题

证书手动续、没做主从、备份没异地，细节写在 [docs/architecture.md](docs/architecture.md)。

## 许可 / License

MIT
