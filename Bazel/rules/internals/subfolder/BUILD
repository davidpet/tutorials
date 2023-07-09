load("//defs:rules.bzl", "path_handling")

# See comments in the rule itself for a description of what happens.
path_handling(
    name = "using_path_handling",
    srcs = ["file1.txt", "file2.txt"],
    deps = ["//:using_touch"],
    outs = ["path_handling_out.txt"],
)
