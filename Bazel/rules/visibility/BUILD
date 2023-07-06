# Targets in this BUILD file with no specified visibility will use this.
# This means anyone can see the target from any BUILD file.
# If it wasn't specified here, the default would become //visibility:private,
# which means only targets in the same BUILD file could see it.
# NOTE visibility is always specified as a list because you can list
# multiple packages that you want to grant access to.
package(default_visibility = ["//visibility:public"])

# No visibility specified - defaults to default_visibility().
# In this case, public.
filegroup(
    name = "group1",
    srcs = ["file1.txt"],
)

#FAILS
filegroup(
    name = "group1plus4plus2",
    # The target from subpackage has private visibility, so we can't see it like this.
    srcs = ["//subpackage:group1plus4", "file2.txt"],
)

# Manually specifying private visibility.
filegroup(
    name = "privategroup1",
    srcs = ["file1.txt"],
    visibility = ["//visibility:private"],
)

# Using a target that explicitly granted our package access.
filegroup(
    name = "granted4plus1",
    srcs = ["//subpackage:granted4", "file1.txt"],
)

# Granting a package group access to this target.
filegroup(
    name = "packagegroup1",
    visibility = ["//subpackage:subpackagegroup"],
    srcs = ["file1.txt"],
)

# Access to file4.txt granted by exports_files function.
# Trying to access by path doesn't work because of the
# BUILD file marking subpackage as a package.sd
filegroup(
    name = "filetarget4",
    srcs = ["//subpackage:file4.txt"],
)
