# 'bazel build //subfolder/pypackage:pyfile' will do the following:
#   1. Create a pyfile (with no extension) script (python code) in bazel-bin
#      at subfolder/pypackage.
#   2. Create a folder 'pyfile.runfiles' in that same folder with dependencies.
#      These include the actual pyfile.py script itself that's in srcs for the
#      target, and other things put there by bazel.
#      NOTE: there is another hierarchy that looks like the workspace under
#             pyfile.runfiles/__main__
# 'bazel run //subfolder/pypackage:pyfile' will do the following:
# 1. Build if necessary.
# 2. Run the output executable file with python under the following conditions:
#     A. stdout, etc. still go to the terminal (instead of having to go to file like genrule)
#     B. The working directory is a sandboxed version of the pyfile.runfiles folder
#     C. PYTHONPATH takes from the local system's version, but is also set to a whole
#        bunch of stuff around the working directory and sandbox, including the runfiles folder,
#        the working directory from B, etc. with higher precedence
#     D. the python used to execute is your local python (eg. your conda) (so you must install it)
#     E. pip depdencies come from your python, but pip installations inside bazel (skipped here)
#        are on top of that and hermetic
# 'bazel-bin/subfolder/pypackage/pyfile' will do the following:
# Directly execute the script without rebuilding or sandboxing.
# Thus, the working directory is the current working directory.
# However, PYTHONPATH has the bazel-bin versions of paths instead of sandboxed ones.
# Otherwise, it's just like 'bazel run'.
py_binary(
    name = "pyfile",
    srcs = ["pyfile.py"],

)

# This is similar to filegroup in that it doesn't actually create or move anything when built.
# But it accumulates dependencies as files to watch for changes so that the downstream target
# like py_binary be built and run correctly.
py_library(
    name = "pylib_lib",
    srcs = ["pylib.py"],
)

# This also technically does nothing except aggregate a list of files for the downstream target
# to watch and copy.
py_library(
    name = "pylib2_lib",
    srcs = ["pylib2.py"],
    deps = [":pylib_lib"],
)

# All the transient dependencies (the files from the 2 targets above) now get copied
# to pybin.runfiles/__main__ in the same structure as the workspace.
# It works the same as the py_binary target above, but now when you import by full
# workspace path, it will work due to the PYTHONPATH setup.
# In addition, importing just by name will work because the original directory of the package
# is added to PYTHONPATH, but that won't work if you copy the runfiles folder to another
# machine.  Using fully-qualified workspace paths is the more portable option.
py_binary(
    name = "pybin",
    srcs = ["pybin.py"],
    deps = [":pylib2_lib"],
)

# This library will be used by the binary below.
# More discussion to follow down there.
py_library(
    name = "pylib3_lib",
    srcs = ["pylib3.py"],
    data = ["file1.txt"],
)

# file1.txt and file2.txt will be in the runfiles folder for this python binary.
# They will be right next to the other python files because they will mirror
# their original location.
# Because files are accessed relative to the working directory, you should use
# a workspace-relative path to get at the files.
py_binary(
    name = "catfiles",
    srcs = ["catfiles.py"],
    deps = [":pylib3_lib"],
    data = ["file2.txt"],
)

# Summary of srcs, deps, data, tools:
# srcs = the files that are the subject of the target
#   They are copied into the target's sandbox for the build but not into bazel-bin after.
#   They can be other targets to create a chain that aggregates a bunch of sources.
#   eg. for a library or binary, it's source files
#   eg. for genrule, it could be anything used in the shell script
#   eg. for filegroup, just files
# deps = similar to srcs in terms of copying to bazel-bin and aggregating targets, but
#        the intention (and the usage by some rules) is different in that deps
#        are supposed to be already-built (or wrapped) versions of what used to be
#        srcs.
#   eg. compiled .jar (or maybe .class) file instead of .java source file
#   eg. .obj file for C++ source file
#   NOTE: for python, it's just more dependency resolution that results in aggregated copying.
# data = unlike the other two above, data files are copied to bazel-bin instead of the sandbox.
#   eg. string resources (text file) used by the program at runtime
#   You can chain targets (eg. filegroups) with these as well.
# tools = for genrule, similar to srcs but treated slightly differently internally because
#         bazel knows you intend to execute it in the sandbox.

# For other languages (eg. Java), the overall concepts are the same, but instead of library
# targets doing nothing, they will build .jar files.  The runfiles infrastructuer is still
# used, unless you use the special build rule that builds a self-contained jar file.
# These exact machanics may vary in other languages, but the concept of how the targets
# interact (libraries vs. binaries, working directory, etc.) should be compatible.

# I haven't tried C++ in bazel yet, but according to the docs, runfiles is used if you
# set dynamically linking for library dependencies while it is not used if you do
# static linking.  That's a little different than both Python and Java but still
# compatible with the above ideology.

# Remember that individal language targets also provide their own options to control
# language-specific compiling and linking features.
