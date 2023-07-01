# Import bzl file relative to workspace and then pick function names from that file.
load("//defs:macros.bzl", "probe_sandbox", "probe_sandbox_for_file", "probe_sandbox_with_hardcoded")

# call the macro like any other BUILD rule (actually a Starlark function).
# Since this is a genrule underneath, it must be run with 'bazel build //:my_probe'.
# It will output to bazel-bin/my_probe_out.txt.
probe_sandbox(
    name = "my_probe",
    srcs = ["file.txt"],
)

probe_sandbox_for_file(
    name = "my_file_probe",
    srcs = ["file.txt"],
)

probe_sandbox_with_hardcoded(
    name = "my_probe_hardcoded",
)

# This will fail (by our explicit fail message).
probe_sandbox_for_file(
    name = "my_file_probe_fail",
)
