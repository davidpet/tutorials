# The presence of an empty BUILD makes this folder a package already.

# Use bazel clean to clear the bazel-* directories and start over.
# Do bazel clean --expunge to make extra sure (as sometimes clean doesn't clear it).

# bazel-bin and all those folders are actually symbolic links

# Specific folders (workspace-level) created by Bazel:
# 1. bazel-[workspaceName]
#    This is basically a copy of your workspace (or subtrees of it when packages are built).
#    It is refreshed (maybe rebuilt?) each time you start a build.
#    I presume the reason for this is to protect it from asynchronous changes that might happen
#    on the filesystem of the original.
#    Targets are built out of this instead of the originals (transparently to the user).
# 2. bazel-bin
#    This is where outputs of build targets go, and where 'bazel run' type commands execute from.
#    It is the overall output and execution environment built-up incrementally during the build
#    process.
#    As a target is built, its outputs go into here, and other targets depending on those outputs
#    will copy them into their sandbox during their build.
#    The structure of this folder matches the structure of the workspace in terms of folders.
# 3. bazel-out
#    This can be thought of as a private scratch folder used by Bazel.
#    Occasionally you'll see it (or copies of it) appearing in paths given to you by bazel functions,
#    but you don't necessarily need to know about it - just use those paths as a black box.
# 4. bazel-testlogs
#    You can look for logs from your 'bazel test' runs here.
# 5. sandbox (temporary)
#    As a target is being built, the dependencies are copied from bazel-[workspaceName] and bazel-bin
#    (and possibly bazel-out but we don't need to worry about that) into a temporary sandbox folder.
#    This folder only exists for the purpose of building that target, and then the output is sent
#    to bazel-bin to be run or used in another build's sandbox.
#    The structure mostly mirrors the workspace, but sometimes there are exceptions.
#    The $(location) function helps abstract that away.
