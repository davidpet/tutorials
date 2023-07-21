load("//:defs.bzl", "ng_app")

package(default_visibility = ["//visibility:public"])

# The Angular application
# (I moved it from the root BUILD due to my project structure)
ng_app(
    name = "my-app",
    #project_name = "my-app",
    # Using just package name because shorthand for package:package
    # Unlike example, I use //libs instead of //projects.
    deps = [
        "//libs/my-lib",
        "//libs/common-lib",
        "//:node_modules/ngx-spinner",
      ],
)
