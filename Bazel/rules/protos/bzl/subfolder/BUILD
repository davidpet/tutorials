# Hide the built-in rule by using this version.
load("@rules_proto//proto:defs.bzl", "proto_library")

# Builds a proto.bin file relying on the proto.bin files
# for city.proto and bridge.proto.
# The compiled files reference proto files rather than proto.bin files, interestingly.
proto_library(
    name = "city_proto",
    srcs = ["city.proto"],
    # NOTE: depds can only be proto_library targets, not .proto files!
    #       Somehow proto_library makes imports work using name mangled
    #       proto.bin files.
    deps = ["//subfolder/subsubfolder:building_proto",
            "//subfolder/subsubfolder:bridge_proto",],
)

# By examining the output of this rule, you can see that the sandbox
# contains only the city proto.bin file and no files for building or
# bridge.
# This is counterintuitive given that protoc doesn't take these, and also
# because the dependencies are missing.
# The reason is that proto_library doesn't output the normal way, but
# rather sets some special "provider" stuff that other proto_library
# rules and language-specific proto rules can understand. Even though
# proto_library compiles the protos, the original .proto files are used
# again and again to compile downstream targets.
# Thus, you can't use genrule with proto_library outputs.
# To do your own rule, you have to go fully custom, or don't use proto_library.
# You might have to do something like use filegroup() with glob to get all the
# protos in the right structure if you want to do a genrule macro.
# You could make the filegroups depend on proto_library rules if you want to
# have that compilation safety net of checking for errors as well
# (and then just ignore the .proto.bin files).
# Another idea could be to use filegroup() targets to specify groups of proto
# files and then define proto_library targets with those as inputs.
# Then make the genrule that uses the proto_library also depend on the
# filegroup.  This could probably be wrapped with a macro.
# NOTE: since all it's doing is compiling, and the output is not used,
# you can put multiple protos in the srcs of proto_library and don't need to specify a main one.
genrule(
    name = "probe_sandbox",
    srcs = [":city_proto"],
    outs = ["probe_sandbox_out.txt"],
    cmd = "ls -R -1 > $@",
)

# This is how you create a proto library rule that depends on one of the google built-in symbols.
# You use the @com_google_protobuf repo which you get when proto_library is set up in WORKSPACE.
# Note that those dependencies are proto_library rules as well.
# This presents a problem if you need the filegroup workaround from above.
# https://github.com/protocolbuffers/protobuf/blob/main/src/google/protobuf/BUILD.bazel
# This BUILD file has the empty_proto rule (which is aliased by a root-level rule).
# Note the stripping of src from the prefix, resulting in the google/protobuf directory structure
# in your sandbox (for proto rules only, not genrule).
# NOTE: This also shows that targets in other repos still superimpose their paths in the same
# folder hiearchy, so name conflicts are possible!
proto_library(
    name = "depends_on_google_proto",
    srcs = ["depends_on_google.proto"],
    deps = ["@com_google_protobuf//:empty_proto",
            "@com_google_protobuf//:duration_proto",],
)

# As you can see in this sandbox, you get the proto.bin of the google stuff when you try to
# genrule against those targets, just like with your own protos.
genrule(
    name = "probe_google",
    srcs = ["@com_google_protobuf//:empty_proto"],
    outs = ["probe_google_out.txt"],
    cmd = "ls -R -1 > $@",
)

# It would be great if this worked, but it doesn't.
#genrule(
#    name = "direct_import",
#    srcs = ["@com_google_protobuf//src/google/protobuf:empty_proto"],
#    outs = ["direct_import_out.txt"],
#    cmd = "ls -R -1 > $@",
#)

# Luckily, they've provided a target for getting all the protos themselves as a filegroup!
# See https://github.com/protocolbuffers/protobuf/blob/main/BUILD.bazel for other stuff.
genrule(
    name = "direct_import",
    srcs = ["@com_google_protobuf//:well_known_type_protos"],
    outs = ["direct_import_out.txt"],
    cmd = "ls -R -1 > $@",
)

# Unlike proto_library and py_library, this actually generates the real thing when you build it!
# bazel-bin/subfolder/subfolder/city_pb2.py is created (for some reason the whole path is repeated).
load("@rules_proto_grpc//python:defs.bzl", "python_proto_library")
python_proto_library(
    name = "building_python_proto",
    protos = ["//subfolder/subsubfolder:building_proto"],
    # Importing just always fails no matter what combos I try if I don't set this.
    output_mode = "NO_PREFIX",
)
python_proto_library(
    name = "bridge_python_proto",
    protos = ["//subfolder/subsubfolder:bridge_proto"],
    output_mode = "NO_PREFIX",
)
python_proto_library(
    name = "city_python_proto",
    protos = [":city_proto"],
    output_mode = "NO_PREFIX",
    # You have to create a parallel python_proto_library dependency chain to get this to work.
    # The python files depend on each other as do the protos.  It is not detected as such without
    # your extra work wrapping it like this.
    deps = [
        ":building_python_proto",
        ":bridge_python_proto",
    ],
)

# See further notes inside try_imports.py for the weird results here.
py_binary(
    name = "try_imports",
    srcs = ["try_imports.py"],
    deps = [":city_python_proto", ":building_python_proto", ":bridge_python_proto"],
)

# This is basically the same thing except you can't specify deps (but it still generates a file
# that relies on those deps).
load("@rules_proto_grpc//python:defs.bzl", "python_proto_compile")
python_proto_compile(
    name = "city_python_proto_again",
    protos = [":city_proto"],
    output_mode = "NO_PREFIX",
)

# Summary of Caveats of using these rules:
# 1. proto_library can only feed *_proto type rules and not your own custom genrules
#    (including the google-provided targets)
# 2. python_proto_library repeats the whole package path for some reason, making imports weird
# 3. python_proto_library doesn't properly link dependencies (probably due to #2)
# 4. python_proto_library doesn't work at all if you don't set NO_PREFIX mode
# 5. the 'package' directive doesn't matter to generated code (at least in python).

# Python GRPC
# python_grpc_library required for using server and rpc methods and making a server stub to
# call in Python
# unfortunately, the problems are even worse than the problems I ran into above.
#  1. You have to install @com_github_grpc_grpc
#  2. @com_github_grpc_grpc relies on a specific (old) version of go_toolchains, which conflicts
#     with using buildifier.
#  3. Even if you stop using buildifier in order to fix #2, it relies on something called absl,
#     which I was not able to get to install via WORKSPACE (and no documentation describes doing so).

# Summary of Findings:
# 1. proto_library rules are only worthwile for checking that a proto compiles
#    (to catch mistakes early).
# 2. generating with python_proto_library might be worth it if no dependencies,
#    but may not be worth it at all.
# 3. python grpc via the bzl way just doesn't work
