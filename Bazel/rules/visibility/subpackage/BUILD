# Can see group1 because public.
# Because no default here, this target
# is private.
filegroup(
    name = "group1plus4",
    srcs = ["//:group1", "file4.txt"],
)

# FAILS because privategroup1 is private.
# even though this is a subpackage of that very package.
filegroup(
    name = "privategroup1plus4",
    srcs = ["//:privategroup1", "file4.txt"],
)

# Explicitly granting access to a specific package.
# Note that if you use __subpackages__ instead, it will
# also grant to subpackages recursively.
filegroup(
    name = "granted4",
    srcs = ["file4.txt"],
    visibility = ["//:__pkg__"],
)

# This rule is mainly just for visibility rules to use.
package_group(
    name = "subpackagegroup",
    packages = [
        # The ... makes it transitive/recursive.
        "//subpackage/...",
    ],
)

# Since we are in the subpackagegroup and that was
# granted access in //:packagegroup1, we can use
# that target.
filegroup(
    name = "packagegroup1plus4",
    srcs = ["//:packagegroup1", "file4.txt"],
)

# Because files in a package use the same defualt visibility as targets,
# and this one defaults to private, if you want any outside packages to
# be able to refer to the file, you need to use this function.
exports_files(["file4.txt"])
