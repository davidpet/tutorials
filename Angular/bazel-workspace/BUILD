load("@npm//:defs.bzl", "npm_link_all_packages")

load(":defs.bzl", "ng_config")

package(default_visibility = ["//visibility:public"])

# Link npm packages as //:node_modules.
npm_link_all_packages(name = "node_modules")

ng_config(
    name = "ng-config",
)
