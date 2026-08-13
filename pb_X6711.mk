# Inherit from X6711 device
$(call inherit-product, device/itel/X6711/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Inherit some common TWRP stuff.
$(call inherit-product, vendor/pb/config/common.mk)

PRODUCT_DEVICE := X6711
PRODUCT_NAME := pb_X6711
PRODUCT_BRAND := Infinix
PRODUCT_MODEL := Infinix X6711
PRODUCT_MANUFACTURER := infinix

PRODUCT_GMS_CLIENTID_BASE := android-infinix

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="vnd_x6711u_h333-user 12 SP1A.210812.016 868252 release-keys"

BUILD_FINGERPRINT := Infinix/X6711-GL/Infinix-X6711:12/SP1A.210812.016/240701V764:user/release-keys
