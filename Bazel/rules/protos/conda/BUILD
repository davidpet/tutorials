# This is a dependency of the system (a conda environment with this name with grpcio-tools from conda).
PROTOC_ENV = "bazel-protoc"

# This rule just shows the default state you are in with respect to conda.
# No environment is activated because conda doesn't see itself as initialized.
genrule(
    name = "default_conda_environment",
    srcs = [],
    outs = ["default_conda_environment_out.txt"],
    cmd = "conda env list >$@",
)

# This rule shows what you need to do to get a conda environment activated in the sandbox.
# NOTE: this won't affect the shell that ran bazel because it's in a subprocess with its own env.
# First, because the sandbox shell env has no home directory, we make one - just set it to the
# output directory so that anything that gets written goes there.  Since it's not a declared out,
# it won't get copied into bazel-bin.  We don't need it.
# Second, we 'conda init' which will write some code into ~/.bash_profile to make conda work
# in the sandbox.  You might have to check for ~/.bashrc instead and decide which one to source.
# Third, we source the bash_profile or bashrc to simulate reloading the terminal as conda
# wants us to.  Resourcing seems to be good enough for our purposes.
# Fourth, we activate the conda environment.
# Lastly, we just output from conda to demonstrate that the environment has been activated.
genrule(
    name = "protoc_conda_environment",
    srcs = [],
    outs = ["protoc_conda_environment_out.txt"],
    cmd = "export HOME=$(GENDIR) && conda init bash && source $(GENDIR)/.bash_profile && conda activate %s && conda env list >$@ % PROTOC_ENV,
)

filegroup(
    name = "proto_files",
    srcs = glob(["**/*.proto"]),
)

# This rule is the fruit of our labor above, applied to Python protobuf+gRPC.
# Using the same activation technique (which you could abstract out using a macro or similar),
# we first get the sandbox activated in a conda environment - a hardcode one we declare
# as a dependency in documentation.
# We then run protoc using the sandbox as the input directory and the output folder as the
# output directory, passing all the src protos as the protos.
# As in the Docker case, we have to manually call out all the output files here.
# As in the Docker case, you could ommit from :proto_files any ones you don't need and build
# up your bazel-bin incrementally (see the Docker equiv. comments for more detail).
# Overall Result Compared to Docker:
# 1. Eliminate Docker dependency
# 2. Faster build due to not building/running container
# 3. New dependency on specific conda environment existing with grpcio-tools

genrule(
    name = "protoc_build",
    srcs = [":proto_files"],
    outs = ["city_pb2.py", "subfolder/bridge_pb2.py", "subfolder/building_pb2.py", "city_pb2_grpc.py", "subfolder/bridge_pb2_grpc.py", "subfolder/building_pb2_grpc.py"],
    cmd = """
        export HOME=$(GENDIR) && conda init bash && source $(GENDIR)/.bash_profile && conda activate bazel-protoc

        export PROTOS="$(locations :proto_files)"
        export CLEANED_PROTOS=$$(echo "$$PROTOS" | sed "s/\\.\\///g")

        python3 -m grpc_tools.protoc --proto_path="$$(pwd)" --python_out="$(GENDIR)" --grpc_python_out="$(GENDIR)" $$CLEANED_PROTOS
    """
)

# Need to wrap the outputs in a py_library so py_binary will accept it.
py_library(
    name = "try_imports_lib",
    srcs = [":protoc_build"],
)

# Now we can import (and without all the extra path components of the bazl version).
py_binary(
    name = "try_imports",
    srcs = ["try_imports.py", ":try_imports_lib"],
)
