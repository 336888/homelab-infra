#!/usr/bin/env bash
# 每天凌晨 3 点 dump 一份 MySQL，保留 7 天
# crontab: 0 3 * * * /opt/homelab/scripts/backup.sh >> /var/log/backup.log 2>&1

set -euo pipefail

cd "$(dirname "$0")/.."

BACKUP_DIR="${BACKUP_DIR:-./backup}"
KEEP_DAYS=7
STAMP=$(date +%F)
OUT="$BACKUP_DIR/app-$STAMP.sql.gz"

mkdir -p "$BACKUP_DIR"

# 用容器里的 mysqldump，宿主机不用装客户端
# --single-transaction 避免锁表，--quick 不把整表读进内存
docker compose exec -T mysql \
  mysqldump -u root -p"${MYSQL_ROOT_PASSWORD:?需要 MYSQL_ROOT_PASSWORD}" \
  --single-transaction --quick --databases app \
  | gzip > "$OUT"

# 空文件说明 dump 挂了，直接报错别让 cron 静默成功
SIZE=$(stat -c%s "$OUT")
if [ "$SIZE" -lt 1024 ]; then
  echo "备份太小（${SIZE} 字节），大概率失败了" >&2
  exit 1
fi

# 清理过期备份
find "$BACKUP_DIR" -name 'app-*.sql.gz' -mtime +$KEEP_DAYS -delete

echo "$(date '+%F %T') 备份完成: $OUT (${SIZE} bytes)"
