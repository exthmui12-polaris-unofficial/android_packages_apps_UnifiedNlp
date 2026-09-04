# Copyright (c) 2013-2015 microG Project
#
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

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
appcompat_dir := ../../../prebuilts/sdk/current/support/v7/appcompat
uitools_dir := ../../../external/MicroGUiTools
res_dir := unifiednlp-app/src/main/res unifiednlp-base/src/main/res $(appcompat_dir)/res $(uitools_dir)/microg-ui-tools/src/main/res

##
# NetworkLocation
# Target using com.google.android.gms as package name

UNIFIEDNLP_BUILDCONFIG_CLASS := unifiednlp-base/src/main/java/org/microg/nlp/BuildConfig.java

LOCAL_MODULE_TAGS := optional

LOCAL_RESOURCE_DIR := $(addprefix $(LOCAL_PATH)/, $(res_dir))
LOCAL_SRC_FILES := $(call all-java-files-under, unifiednlp-app/src/main/java) \
                   $(filter-out %/LocationProviderV1.java %/LocationServiceV1.java, \
                       $(call all-java-files-under, unifiednlp-base/src/main/java))
LOCAL_SRC_FILES += $(UNIFIEDNLP_BUILDCONFIG_CLASS)

LOCAL_MANIFEST_FILE := unifiednlp-app/src/main/AndroidManifest.xml
LOCAL_FULL_LIBS_MANIFEST_FILES := $(LOCAL_PATH)/unifiednlp-base/src/main/AndroidManifest.xml

LOCAL_JAVA_LIBRARIES := framework com.android.location.provider
LOCAL_USES_LIBRARIES := com.android.location.provider

LOCAL_STATIC_JAVA_LIBRARIES := UnifiedNlpApi MicroGUiTools android-support-v4 android-support-v7-appcompat android-support-v7-preference
LOCAL_PACKAGE_NAME := UnifiedNlp
LOCAL_PRIVILEGED_MODULE := true
LOCAL_CERTIFICATE := platform
LOCAL_PRIVATE_PLATFORM_APIS := true

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_AAPT_FLAGS := --auto-add-overlay \
    --extra-packages org.microg.nlp \
    --extra-packages org.microg.tools.ui \
    --extra-packages android.support.v7.appcompat

include $(BUILD_PACKAGE)
