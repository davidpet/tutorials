load("@bazel_skylib//rules:run_binary.bzl", "run_binary")

# This won't actually work because I didn't put an executable there.
# But you can specify args, environment variables, etc.
# You use 'bazel build' (not run).
# args and env can see outputs and tool via $(location).
# Overall, it is like a more specific genrule where you just run
# one program (that you provide).
# WARNING: Don't forget to make your sh scripts executable!
run_binary(
    name = "mybinary",
    tool = "mylocalexecutable",
    outs = ["mybinary_out.txt"],
    args = [],
    env = {},
    srcs = [],
)

# This works basically exactly like py_binary but for shell scripts.
# All the usual options (eg. data) are there, and lots of others.
# It outputs to console because it is meant to be run, not generate files.
# Working directory is in a sandboxed workspace-like location like
# with py_binary.
sh_binary(
    name = "myscript",
    srcs = ["myscript.sh"],
)

# Library dependency for another sh_binary.
# Works just like python (.sh file(s) copied into runfiles).
sh_library(
    name = "mylib_lib",
    srcs = ["mylib.sh"],
)

# Uses library dependency.
sh_binary(
    name = "myscript2",
    srcs = ["myscript2.sh"],
    deps = [":mylib_lib"],
)

# There is also a sh_test rule if you want to do testing in Bash.
