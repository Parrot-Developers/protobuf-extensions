LOCAL_PATH := $(call my-dir)

proto_path := protobuf
proto_files := \
	$(call all-files-under,protobuf,.proto)

include $(CLEAR_VARS)

LOCAL_MODULE := parrot-protobuf-extensions-cpp
LOCAL_DESCRIPTION := Parrot SDKs common protobuf extensions generated C++ code
LOCAL_CATEGORY_PATH := libs/protobuf
LOCAL_LIBRARIES := protobuf
LOCAL_CXXFLAGS := -std=c++11
LOCAL_EXPORT_C_INCLUDES := $(call local-get-build-dir)/gen

$(foreach __f,$(proto_files), \
	$(eval LOCAL_CUSTOM_MACROS += $(subst $(space),,protoc-macro:cpp,gen, \
		$(LOCAL_PATH)/$(__f), \
		$(LOCAL_PATH)/$(proto_path))) \
)
include $(BUILD_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := parrot-protobuf-extensions-c
LOCAL_DESCRIPTION := Parrot SDKs common protobuf extensions generated C code
LOCAL_CATEGORY_PATH := libs/protobuf
LOCAL_LIBRARIES := protobuf-c libprotobuf-c-base
LOCAL_EXPORT_C_INCLUDES := $(call local-get-build-dir)/gen

$(foreach __f,$(proto_files), \
	$(eval LOCAL_CUSTOM_MACROS += $(subst $(space),,protoc-c-macro:c,gen, \
		$(LOCAL_PATH)/$(__f), \
		$(LOCAL_PATH)/$(proto_path))) \
)
include $(BUILD_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := parrot-protobuf-extensions-py
LOCAL_DESCRIPTION := Parrot SDKs common protobuf extensions generated Python code
LOCAL_CATEGORY_PATH := libs/protobuf
LOCAL_LIBRARIES := \
	protobuf-python \
	python

$(foreach __f,$(proto_files), \
	$(eval LOCAL_CUSTOM_MACROS += $(subst $(space),,protoc-macro:python, \
		$(TARGET_OUT_STAGING)/usr/lib/python/site-packages, \
		$(LOCAL_PATH)/$(__f), \
		$(LOCAL_PATH)/$(proto_path))) \
)

include $(BUILD_CUSTOM)

include $(CLEAR_VARS)

LOCAL_MODULE := parrot-protobuf-extensions-proto
LOCAL_DESCRIPTION := Parrot SDKs common protobuf extensions protobuf files
LOCAL_CATEGORY_PATH := libs/protobuf

# Install proto files
LOCAL_COPY_FILES := \
	$(foreach __f,$(proto_files), \
		$(__f):$(TARGET_OUT_STAGING)/usr/share/$(__f) \
	)

include $(BUILD_CUSTOM)
