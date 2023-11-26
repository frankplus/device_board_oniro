#!/bin/bash
# Copyright (c) 2022 Diemit <598757652@qq.com>
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

PROJECT_ROOT=$1
KERNEL_VERSION=$2
OUT_DIR=${PROJECT_ROOT}/out
KERNEL_SRC_PATH=${PROJECT_ROOT}/kernel/linux/${KERNEL_VERSION}
KERNEL_SRC_TMP_PATH=${OUT_DIR}/kernel/src_tmp/${KERNEL_VERSION}
PATCHES_PATH=${PROJECT_ROOT}/device/board/iscas/rpi4/patches
HDF_PATCH_FILE=${PATCHES_PATH}/hdf.patch
KERNEL_PATCH=${PATCHES_PATH}/0001-rpi4.patch

if [ ! -d "${KERNEL_SRC_TMP_PATH}" ];then
    mkdir -p ${KERNEL_SRC_TMP_PATH}
    cp -arfL ${KERNEL_SRC_PATH}/* ${KERNEL_SRC_TMP_PATH}/

    cd ${KERNEL_SRC_TMP_PATH}

    #hdf patch 打入HDF补丁
    bash ${PATCHES_PATH}/hdf_patch.sh ${PROJECT_ROOT} ${KERNEL_SRC_TMP_PATH} ${HDF_PATCH_FILE}

    #kernel patch
    patch -p1 < ${KERNEL_PATCH}
fi

if [ -d "${KERNEL_SRC_TMP_PATH}" ];then
    echo "kernel tmp src is ready"
else
    echo "kernel tmp src not ready!!!"
    exit 1
fi
