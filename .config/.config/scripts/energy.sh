#!/usr/bin/env bash

# Получаем загрузку CPU
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)

# Получаем загрузку GPU (для AMD)
GPU_USAGE=$(cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null || echo "N/A")

# Для NVIDIA (если у тебя NVIDIA)
# GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo "N/A")

# Формируем JSON для Waybar
echo "{\"text\": \"󱑍\", \"tooltip\": \"CPU: ${CPU_USAGE}%\\nGPU: ${GPU_USAGE}%\"}"
