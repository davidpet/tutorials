# Import bzl file relative to workspace and then pick function names from that file.
load("//defs:macros.bzl", "probe_sandbox", "probe_sandbox_for_file", "probe_sandbox_with_hardcoded")
load("//defs:variables.bzl", "MY_SRCES")  # You can import variables too.
load("//defs:rules.bzl", "foo_empty", "foo_print", "foo_createfile", "foo_attribute", "foo_deps", "foo_template")

##### MACROS ##########
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
# Since it's a macro instead of rule, it will
# fail even if you don't build this target.
#probe_sandbox_for_file(
    #name = "my_file_probe_fail",
#)

# This is how you can share variables between BUILD files.
probe_sandbox(
    name = "using_variable",
    srcs = MY_SRCES,
)

###### VARIABLES #################
# variables allowed in BUILD files too
X = 5

###### CUSTOM RULES ###############
# Simplest possible rule instantiation.
# Just give the target a name.
foo_empty(
    name = "using_foo_empty",
)

# This will print a DEBUG line after the one from the bzl file (due to order).
print("BUILD file")
# These will print the target name when they are built (but not queried) after the other prints.
# The print happens during analysis of the rule (a phase before executing the rule code).
foo_print(name = "print1")
foo_print(name = "print2")

# This will create a file called using_createfile with text inside (when built).
foo_createfile(name = "using_createfile")

# This will depend on (and rebuild if necessary) the above custom rule.
# The output file of that rule will become an input file to this rule, thanks
# to the DefaultInfo provider!
genrule(
    name = "using_createfile_downstream",
    srcs = [":using_createfile"],
    outs = ["using_createfile_downstream.txt"],
    cmd = "cat $(location :using_createfile) > $@",
)

# Using rule with custom attribute 'username' of type string.
# The string will go into the generated file in this case.
foo_attribute(
    name = "using_foo_attribute",
    # Because we didn't declare it mandatory or give a default,
    # it will be empty string if we don't set it here.
    # It will not be 'None' because bazel knows it's supposed
    # to be a string (this is not a python param).
    username = "davidpet",
)

# Demonstrating various ways to pass in dependencies.
foo_deps(
    name = "using_foo_deps",
    # Passing attr.label() attribute (single value).
    # Notice that in the output, it is the filename, not the target name
    # that you see.
    dep = ":using_foo_attribute",
    # Passing attr.label() attribute that is allowed to be a file.
    filedep = "file.txt",
    # Passing attr.label() attribute that can't take multiple files.
    singledep = "file.txt",
    # Passing attr.label_list() that can take files.
    srcs = ["file.txt", ":using_foo_attribute"],
)

# Demonstrating generation of a file from a template.
foo_template(
    name = "using_template",
    username = "Alice",
    template = "file.txt.tpl",
)
