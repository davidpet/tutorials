# Parts of this Tutorial

- [basic](basic) - basics of (mostly) built-in rules and dependency management
  - [WORKSPACE](basic/WORKSPACE) - just there to make this folder into a bazel workspace.
  - [BUILD](basic/BUILD) - comments describe some high-level concepts like `bazel clean` and `bazel-bin`, etc.
  - [subpackage](basic/subfolder/subpackage) - basics of filegroup and genrule targets, and globbing
  - [pypackage](basic/subfolder/pypackage) - basics of libraries, binaries, srcs, data, deps, and runfiles. Python is used as the example, but the concepts are widely applicable.
  - [shell](basic/subfolder/shell) - run_binary, sh_binary, sh_library, sh_test
- [docker](docker) - basics of building and running docker images (without external imports)
- [internals](internals) - .bzl files, macros, rules, variables
  - this is an ongoing area of exploration and there are many links to continue in the rules.bzl file
- [repositories](repositories) - repos and external dependencies
- protobuf
  - [protos/bzl](protos/bzl) - protobuf stuff you can do based on rules you can declare in WORKSPACE
  - [protos/docker](protos/docker) - protobuf stuff using docker to get around conda dependency issues on Mac
  - [protos/conda](protos/conda) - protobuf stuff using a separate conda environment to get around the Mac dependency issue
- [visibility](visibility) - visibility of targets and files between packages, subpackages, package groups, etc.

# bazel-bin

I purposely left bazel-bin in git (in the 'basic' workspace) because the structure demonstrates the concepts in the comments of the targets.
However, at the time I didn't realize it was a symbolic link and thus doesn't show anything useful.

# protobuf/grpc Explorations and Decisions

In my testing, I found out the following things about proto and grpc in Python that are not documented:

1. The bzl import for proto_python_library repeats the whole package path a second time in the directory tree of geneated \*\_pb2 files.

   - This is at least what I found on my Mac M1 environment.

1. The bzl import for proto_python_library makes broken \*\_pb2 files if they depend on each other (eg. protos import other protos).

   - This is at least what I found on my Mac M1 environment.

1. I could not get gRPC to work at all via bzl because of some dependency hell.

   - eg. conflicts with buildifier dependencies (go toolchain version)
   - eg. undocumented dependency on absl which I couldn't find an example of importing

1. Upon deciding that it's infeasible to use the bzl rules for protos and grpc, I then explored using protoc directly. It is feasible, but I ran into the following issues along the way:
1. Since I'm following a monorepo style for this 'projects' repo, I have a single conda environment that I want to be able to run all my bazel tests in. However, there is a seemingly unresolvable dependency conflict that prevents me from having TensorFlow (running on GPU on M1) and grpcio (and grpcio-tools) at the same time in 1 conda environment.

   - This problem probably doesn't exist on my desktop with Linux because, but my M1 laptop is an important development machine for me, so I need my solution to work there regardless.
   - Summary of issues with M1:
     - Following the official Apple steps, tensorflow-deps installs old versions of grpcio and protobuf from conda-forge (built for M1), but then tensorflow-macos overwrites those with newer versions that are not built for M1 (from PyPi). At that point, grpcio is broken (cannot even import it). You can `pip uninstall` grpcio and protobuf and then `conda install` them back again to get them working again. However, if you try to do any version greater than the one that tensorflow-deps originally installed, you get an error due to some transient dependencies (libzl or something like that). Thus, you have to install the old version. However, then when you attempt to `conda install` grpcio-tools so that you can get the `protoc` compiler, you find that there are no conda-forge wheels older than 1.54, which requires grpcio 1.54 (way newer than the one tensorflow-deps forces you to use). This is the part where I finally concluded there is no way to do TensorFlow and Python gRPC in the same conda environment (on M1).

1. I then went on a brief tangent to research using Apache Thrift instead. It looks promising, but when it turned out you have to build from source and set up a lot of per-language dependencies, I started thinking about how I need to use Docker images to make it feasible. I then realized that I can use Docker images to make grpcio-tools feasible as well.
1. Although Thrift looks great, I prefer to stick with gRPC and Protobuf because I just spent 5 years using them when I worked at Google and I want to use that knowledge in projects before I forget it, kind of a way to freeze/consolidate knowledge before learning new things. I also want to get to the meat of the projects and not go on a big tangent to learn to build and configure Thrift right now. I'm not ruling it out for the future though.
1. Upon deciding that using grpcio-tools in a Docker image is the new way I wanted to go:
1. I made a new conda environment for test purposes which had only 1 installation command: `conda install grpcio-tools`.

   - This brings down the latest grpcio, protobuf, and grpcio-tools, all using M1 wheels on my Mac, working correctly with no conflicts.
   - Because I didn't need to be compatible with tensorflow-deps, I could use Python 3.11 instead of 3.10 on my Mac as well!

1. I tested this command to see if the whole approach is even worth exploring:

   ```bash
   python3 -m grpc_tools.protoc --proto_path=/Users/davidpetrofsky/repos/tutorials/Bazel/rules/protos/bzl --python_out=/Users/davidpetrofsky/python_out subfolder/city.proto subfolder/subsubfolder/bridge.proto subfolder/subsubfolder/building.proto --grpc_python_out=/Users/davidpetrofsky/python_out
   ```

1. Some notes about that command and the results:

   1. The `proto_path` parameter sets the root folder relative to which the proto paths will be resolved. In the context of a bazel build, it will be the working directory of the sandbox (looks like workspace).
   1. The list of protos are compiled and resolved with respect to each other relative to proto_path even if proto_path is not the current working directory. However, in the context of bzl, the working directory will be proto_path anyway.
   1. Each proto you mention (should be something like $(SRCS) in bazel build) will become 1 output file for each \*\_out param.
   1. `python_out` creates the message types and enums in a \*\_pb2 file.
   1. `grpc_python_out` creates the server stub code in a \*\_pb2_grpc file.
   1. Those files do not have the same problem that the bzl rule for python_proto_library has:
   1. The folder hierarchy correctly matches the input without repeating.
   1. Dependencies are correctly imported with respect to each other.
   1. gRPC works just by adding a parameter to the command.
   1. Regarding using Docker in Bazel, it seems that at the moment rules_docker is soft deprecated while rules_oci is softly recommended as the replacement. It is possible to build and send commands to a docker image within a bazel build. It is also possible to do it by installing Docker and using genrules - so if I run into any limitations with the above rulesets, that is a fallback option.

1. Now that I know it's possible to do the above in a standalone Conda environment, in order to still be compatible with the monorepo style, the next steps are:

   1. Set up the bazel build to build a docker image just for grpcio-tools (and in the future for other things that require their own environment).
   1. The image should be set up inside to look like the grpcio-tools conda environment I created above.
   1. The sandbox directory during a build should be mounted to the docker image so that protoc inside can read protos and write python files.
   1. Assuming genrule as an example, SRCS should be all the proto files (including dependencies) and should be passed as the list of protos. Then all the corresponding _*pb2*_ files should be the OUTS so that they will get copied into bazel-bin (and eventually runfiles).
   1. Figure out how to make this work on both Mac and Linux environments (2 docker images? a multilayer image?)

1. Because I wanted to document the research steps I went through, I am providing updates here in a separate step instead of editing the above points:
   1. oci_image doesn't have a rule for running a docker image and getting results back. You still have to run a 'docker' command. Thus, for my purpose, if I have to install docker as a dependency anyway, why not just 'docker' all the things.
      1. If I was just building a container to deploy into the cloud, oci_image would be a great option though (and I may use it later).
   1. I'm not sure if rules_docker has it or not (I seem to remember seeing one before but I might have been wrong) - however, I'm not a fan of using libraries where the authors basically tell you not to use it because they can't maintain it, so I'm going to try just using genrule and docker directly.
      1. On further research, rules_docker does have it but it doesn't have volume mounting and only allows exporting 1 file, so you'd have to zip and copy around.
   1. I managed to get some genrules using Docker working (see [here](docker)). Some slight tweaks were needed to get it to work from within the sandbox, but it does.
      1. One weird additional complication was that it turns out bazel uses symlinks to speed up copying into the sandbox, so I had to tar and untar to dereference those.
   1. I successfully got my docker-based solution to generat importable protobuf and grpc code for a py_binary target, so mission accomplished!
   1. I'm not sure how to deal with the issue of having to specify the output files manually to the genrule/macro!
      1. Can't use glob() because it's on generated files, and can't expand the srcs in the place I need to.
   1. I realized after I got the docker stuff to work that in this particular case, just using a separate conda environment (which can be called out as a repo dependency) and then activating that in the genrule would replace having to use Docker. This wouldn't work in the general case of dependency hell, such as if apt/homebrew and npm are involved, but in a pure python conda/pip type situation, it works. I stayed away from it at first because it felt like conda activating in a bazel rule broke hermeticity, but I realized later that since it's a subprocess, it doesn't. I had to do some extra work to fake a $HOME directory in the sandbox so that conda would be willing to run.
      1. It's still good I got the docker stuff working because the conda way won't always be good enough, and I learned a LOT about bazel, docker, and protoc that I wouldn't have if I hadn't gone through that.
1. After learning a bit about custom rules, I think a better way to go might be to do custom rules (based on conda instead of docker) that can take both DefaultInfo and ProtoInfo providers. That solves the output hardwiring issue and has the same functionality as a genrule macro but in a different way.

# Formatted Strings in Starlark

- YES: `"hello, {}.  {} to meet you".format('bob', 'nice')`
- YES: `"hello, %s, %s to meet you" % ('bob', 'nice')`
- YES: `"hello, " + "bob" + ...`
- NO: `f"hello, {name}, {feeling} to meet you"`

# Python Standard Library

Not available in Skylark. The closest you get is if you import Skylib for some string, collection, and path stuff. Also, the usual methods of str, list, etc. from Python are available.

# Workspace Lock

All bazel commands lock the whole workspace until they're done. `bazel run` will lock the whole workspace until the binary has exited. Thus, you cannot run two things at a time using bazel (eg. client and server). If you need that use case, you must execute the binaries directly from bazel-bin or using --script_path and running that script.

# Paths in Custom Bazel Rules

- paths passed into a rule via attributes are relative to workspace root
- paths passed into a rule may be directly in the workspace or in the subfolder of it given by ctx.bin_dir.path
  - if they are generated by another rule, they are in the latter
- ctx.actions.declare_file takes package-relative (not workspace-relative) paths
  - you are not allowed to call it on a file outside the package
  - once you get the File object, it is relative to the workspace as usual (and happens to be in ctx.bin_dir.path)
- files declared with declare_file can be passed into providers in the return of the rule
  - that will cause them to get copied from the ctx.bin_dir.path folder into bazel-bin at the end of the build
  - other rules will still see it as being in ctx.bin_dir.path during the build process though
- files created that aren't declared and passed as providers are just transient - they dissappear before anyone else can use them
- including a file in a provider that you didn't actually create or declare does not cause it to copy into bazel-bin
  - but since it's workspace-relative, it will still work if a downstream rule uses that path

# Other Possible Future Topics to Explore

- caching
- query language
- build flags (built-in and custom)
- configuration and select()
