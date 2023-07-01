load("@bazel_skylib//rules:run_binary.bzl", "run_binary")

# This won't actually work because I didn't put an executable there.
# But you can specify args, environment variables, etc.
# You use 'bazel build' (not run).
# args and env can see outputs and tool via $(location).
# Overall, it is like a more specific genrule where you just run
# one program (that you provide).
run_binary(
    name = "mybinary",
    tool = "mylocalexecutable",
    outs = ["mybinary_out.txt"],
    args = [],
    env = {},
    srcs = [],
)
