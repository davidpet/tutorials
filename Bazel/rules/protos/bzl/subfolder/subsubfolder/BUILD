# Hide the built-in rule by using this version.
load("@rules_proto//proto:defs.bzl", "proto_library")

# Compiles proto into .proto.bin file in bazel-bin when you run
# 'bazel build' on the target.
# Unlike filegroup(), compiles and catche errors, instead of just aggregating.
# As usual, the output is in the proper place in directory hierarchy.
# NOTE: the name of the proto.bin file contains the .proto name but also has
#       a lot more stuff in it.
# Since protoc takes .proto files instead of proto.bin files, these outputs
# are not meant to be used by downstream proto rules.
# Instead, the actual protos will be copied into the sandbox for the purpose of
# building the next rule.
proto_library(
    name = "building_proto",
    srcs = ["building.proto"],
    visibility = ["//visibility:public"],
)

proto_library(
    name = "bridge_proto",
    srcs = ["bridge.proto"],
    visibility = ["//visibility:public"],
)
