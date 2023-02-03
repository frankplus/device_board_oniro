#!/bin/bash
set -e

PROJECT_ROOT=$1
KERNEL_VERSION=$2

if [ ! -d "${PROJECT_ROOT}" ];then
   PROJECT_ROOT=/home/diemit/ohos
   KERNEL_VERSION=linux-5.10
fi

KERNEL_PATCHES_PATH=${PROJECT_ROOT}/kernel/linux/patches/${KERNEL_VERSION}
KERNEL_CONFIGS_PATH=${PROJECT_ROOT}/kernel/linux/config/${KERNEL_VERSION}/arch/arm/configs

cp -arfL rpi4_small_patch ${KERNEL_PATCHES_PATH}/
cp -f configs/rpi4_small_small_defconfig ${KERNEL_CONFIGS_PATH}/rpi4_small_small_defconfig

echo "kernel config and patch is ready"