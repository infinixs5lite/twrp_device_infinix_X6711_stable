#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

#Inherit emulated_storage properties
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit userspace reboot properties
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

# Inherit some common PBRP stuff.
$(call inherit-product, vendor/pb/config/common.mk)

# Inherit from X6711 device
$(call inherit-product, device/infinix/X6711/device.mk)

PRODUCT_DEVICE := X6711
PRODUCT_NAME := pb_X6711
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X6711
PRODUCT_MANUFACTURER := infinix

PRODUCT_GMS_CLIENTID_BASE := android-infinix
