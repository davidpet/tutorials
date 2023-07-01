# Rules are lower-level than macros, which just instantiate rules.

# A custom rule is created by:
# 1. creating a variable with the name of the new rule and setting it to a call to the rule() function.
# 2. passing an implementation function and attributes to the rule() call.
# 3. handling the context (ctx) and creating actions in the implementation function

# For simple cases, macros are fine, but if the macro starts to get too complex, you may need a rule.
# New languages are usually added via rules instead of macros.

# https://bazel.build/extending/rules
# https://bazel.build/rules/rules-tutorial
# https://bazel.build/extending/concepts - more topics like depsets, aspects, etc.

# TODO: add examples here if ever need to make custom rules (most people won't need to)
