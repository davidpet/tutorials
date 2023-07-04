# Build a miniforge3 image with grpcio-tools installed.
genrule(
    name = "build_docker_image",
    outs = ["docker_image.tar"],
    cmd = """
        export HOME=$$(pwd)
        docker build -t davidpet_protoc - < $(location Dockerfile)
        docker save davidpet_protoc > $@
    """,
    srcs = ["Dockerfile"],
)

filegroup(
    name = "proto_files",
    srcs = glob(["**/*.proto"]),
)

# Run protoc in the docker image.
genrule(
    name = "run_docker_container",
    srcs = [":build_docker_image", ":proto_files"],
    # We have to hardcode these for now - I need to work on figuring out what to do about that.
    # In deeper hiearchies this will be super annoying, and break the separation between dependent targets.
    outs = ["city_pb2.py", "subfolder/bridge_pb2.py", "subfolder/building_pb2.py", "city_pb2_grpc.py", "subfolder/bridge_pb2_grpc.py", "subfolder/building_pb2_grpc.py"],
    # Most of this is copied over from //docker in this tutorial.
    # Basically we just send all the proto files to protoc and tell it to generate _pb.py and _py_grpc.py files.
    # Unlike the bzl way, this way results in imports in the right place (no duplicated package path), and dependencies work!
    cmd = """
        export TMPDIR=$$(mktemp -d)
        export TARFILE=$$TMPDIR/docker_rollup.tar
        export TARFOLDER=$(GENDIR)/docker_rollup
        cleanup() {
            rm -rf "$$TMPDIR"
        }
        trap cleanup EXIT

        tar -cvhf "$$TARFILE" .
        mkdir "$$TARFOLDER"
        tar -xf "$$TARFILE" -C "$$TARFOLDER"

        export PROTOS="$(locations :proto_files)"
        export CLEANED_PROTOS=$$(echo "$$PROTOS" | sed "s/\\.\\///g")

        docker load < $(location :build_docker_image)
        docker run --rm -v $$(realpath "$$TARFOLDER"):/sandbox_src -v $$(realpath $(GENDIR)):/sandbox_out -w /sandbox_src davidpet_protoc bash -c \
            "python3 -m grpc_tools.protoc --proto_path=/sandbox_src --python_out=/sandbox_out --grpc_python_out=/sandbox_out $$CLEANED_PROTOS"
    """,
)

# Need to wrap the outputs in a py_library so py_binary will accept it.
py_library(
    name = "try_imports_lib",
    srcs = [":run_docker_container"],
)

# Now we can import (and without all the extra path components of the bazl version).
py_binary(
    name = "try_imports",
    srcs = ["try_imports.py", ":try_imports_lib"],
)
