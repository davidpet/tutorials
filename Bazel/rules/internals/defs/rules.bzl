# Rules are lower-level than macros, which just instantiate rules.

# A custom rule is created by:
# 1. creating a variable with the name of the new rule and setting it to a call to the rule() function.
# 2. passing an implementation function and attributes to the rule() call.
# 3. handling the context (ctx) and creating actions in the implementation function

# For simple cases, macros are fine, but if the macro starts to get too complex, you may need a rule.
# New languages are usually added via rules instead of macros.

# https://bazel.build/extending/rules
# https://bazel.build/extending/concepts - more topics like depsets, aspects, toolchains, configuration, etc.
# https://bazel.build/rules/lib/builtins/ctx
# https://bazel.build/rules/lib/toplevel/attr
# https://bazel.build/extending/depsets
# https://bazel.build/rules/lib/builtins/actions
# https://chat.openai.com/share/a9a30d13-5e99-4c90-a369-7d0e0a3a1dab
# https://github.com/bazelbuild/examples/tree/main/rules


load("@bazel_skylib//lib:paths.bzl", "paths")

# This particular rule does nothing and is just to demonstrate some basic structure.
# ctx = the context parameter passed to all rule implementations
def _foo_empty_impl(ctx):
    pass

# foo_binary becomes importable as a rule because we set it to the result of calling rule().
# NOTE: even without specifying any attributes here, the rule automatically has a
#       'name' attribute because bazel needs that to function.
#       There are other things that will already work by it being a rule as well.
#       For instance, 'tags' and 'visibility'.
foo_empty = rule(
    # we use a private function from within this file as the implementation of the rule.
    implementation = _foo_empty_impl,
)

# Another empty rule, but it prints to demonstrate evaluation order of bazel rules.
def _foo_print_impl(ctx):
    # ctx.label is the label of the target that is using the rule from a BUILD
    print("analyzing", ctx.label)

foo_print = rule(
    implementation = _foo_print_impl,
)

# This will print a DEBUG line when the file is imported, before any rule code is run.
# If imported by more than one BUILD file, the result will be cached instead of rerunning.
print("bzl file evaluation")

# A rule to create a file with the same name as the target using the rule, with some
# text content.
def _foo_createfile_impl(ctx):
    # This tells bazel to expect the rule to create a file with the same name as the target.
    # This is for modification tracking purposes and such.  It also gives you an object
    # that can be used for other calls below.
    out = ctx.actions.declare_file(ctx.label.name)

    # Creates an action (at analysis time) to write to the file (at execution time).
    # By calling methods from ctx.actions in a sequence, you queue up execution actions
    # to do stuff in a given order.
    # In this case, the action just writes a file with the given content.
    ctx.actions.write(
        output = out,
        content = "Hello!\n",
    )

    # You need to return an 'info object' (also called 'provider) to the rule to actually
    # do anything.  It won't even run actions without it.  But the build will "succeed".
    # NOTE: if the rule succeeds when it should fail or doesn't create a file when it should,
    #       see if you left this part out.
    # In this case, we return a DefaultInfo (the provider returned by all rules always 
    # even if not specified) specifying that the rule passes the output file to downstream
    # rules.
    return [DefaultInfo(files = depset([out]))]

foo_createfile = rule(
    implementation = _foo_createfile_impl,
)

# This rule is just like foo_createfile except:
# 1. It takes an attribute called 'username'
# 2. It includes that value in the content of the created file.
def _foo_attribute_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    ctx.actions.write(
        output = out,
        # ctx.attr contains our custom attributes.
        content = "Hello, {}!\n".format(ctx.attr.username),
    )

    return [DefaultInfo(files = depset([out]))]

foo_attribute = rule(
    implementation = _foo_attribute_impl,
    # attrs dictionary is where you specify what attributes the target using
    # this rule can pass in.
    attrs = {
        # We take a 'username' attribute of type string.
        # The constructor for attr.string() here can take arguments such as
        # the 'mandatory' boolean to force the user to provide the value,
        # the 'default' string to give a default value other than empty,
        # the 'values' list to provide a list of allowed values,
        # and 'doc' to provide documentation of the attribute.
        "username": attr.string(),
    },
)

# This rule demonstrates various ways to pass in dependencies.
# NOTE: I used short_path here to make them paths workspace-relative,
#       but that's probably not necessary (or desirable) as a general rule.
#       At the time I did that, I forgot that when rules are chained,
#       the files don't go back to workspace root but stay in bazel-out
#       until the very end.
def _foo_deps_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name)

    # Getting information about a single target label that cannot be a file.
    dep_target = ctx.attr.dep
    dep_label_name = dep_target.label.name
    # Note that unlike in a macro, you can see the resolved list of files here!
    dep_file_workspace_paths = [dep.short_path for dep in dep_target.files.to_list()]
    # Another way to get at the list of files (more idiomatic).
    dep_files = ctx.files.dep
    # Similar to the other version above but you didn't have to convert files to a list.
    dep_file_workspace_paths2 = [dep.short_path for dep in dep_files]

    # When files are allowed, it works the same as if they were targets because
    # targets are resolved to files anyway.
    filedep_file_paths = [dep.short_path for dep in ctx.files.filedep]

    # Because we declared it as only allowing a single file, we can use this
    # form to be slightly more concise.
    singledep_path = ctx.file.singledep.short_path

    # label lists look exactly like labels that can take multiple files internally.
    srcs_paths = [dep.short_path for dep in ctx.files.srcs]

    ctx.actions.write(
        output = out,
        content = "{}\n\n{}\n\n{}\n\n{}\n\n{}\n\n{}".format(
            dep_label_name,
            dep_file_workspace_paths,
            dep_file_workspace_paths2,
            filedep_file_paths,
            singledep_path,
            srcs_paths),
    )

    return [DefaultInfo(files = depset([out]))]

foo_deps = rule(
    implementation = _foo_deps_impl,
    attrs = {
        # A single target label only.
        # A filename (even with : in front) cannot be passed in.
        # Note that the target passed in could have multiple files.
        'dep': attr.label(),

        # A label that could be a target or a file.
        # You could pass in an [] of allowed file extensions to restrict
        # the types of files.
        'filedep': attr.label(allow_files = True),

        # A label that could be a target or a file,
        # but if a target, can only have a single file.
        # The build will fail if the target has multiple files.
        # Like allow_files, you could pass in an [] instead to restrict
        # the file types.
        'singledep': attr.label(allow_single_file = True),

        # A list of labels and/or files (since we allow files).
        # The overall result will be access the same way as 'dep'
        # above because that was already a list of files internally
        # after resolution.
        # NOTE: srcs, deps, etc. aren't built-in attributes for custom
        #       rules - you implement those yourself like this.
        'srcs': attr.label_list(allow_files = True),
    }
)

# This rule demonstrates using templates to generate files.
# This is recommended over using string concatenation because
# it's easier on memory and more efficient.
def _foo_template_impl(ctx):
    out = ctx.actions.declare_file(ctx.label.name + "_generated.txt")

    # A special action type is provided for this purpose.
    # It will create the output file based on the template
    # and perform the given string substititions.
    ctx.actions.expand_template(
        output = out,
        template = ctx.file.template,
        substitutions = {"{NAME}": ctx.attr.username},
    )
    return [DefaultInfo(files = depset([out]))]

foo_template = rule(
    implementation = _foo_template_impl,
    attrs = {
        "username": attr.string(default = "unknown person"),
        # You could make this _template instead to make it PRIVATE.
        # Then the BUILD file can't set it, but it's still implicitly
        # passing it.  Make sure to export_files() on the template file
        # from its BUILD or other BUILDs can't see it.
        "template": attr.label(
            allow_single_file = [".txt.tpl"],
            mandatory = True,
        ),
    },
)

# This rule demonstrates running two actions with an intermediate file,
# and also how to run shell commands like genrule does (roughly).
# If you wanted to do your own genrule, you'd need logic to parse all
# the special special symbols, escape the $, and stuff.
def _foo_sandbox_impl(ctx):
    # This is going to be an intermediate file used by the 2nd action.
    # But it is also going to end up in bazel-bin at the end.
    # It won't, however, be part of the set of files sent to
    # downstream targets.
    output_file1 = ctx.actions.declare_file(ctx.attr.name + "1.txt")
    # This will be the true output of this rule.
    # It will go to bazel-bin, and be in the sandbox of the next
    # downstream target.
    output_file2 = ctx.actions.declare_file(ctx.attr.name + "2.txt")

    # Command we will run.
    # Note that it is just a regular shell command.
    # There is no $(location) or $@ or needing $$ because that
    # stuff is all defined by genrule itself.
    command = "(echo '-----' && echo $PATH && pwd && ls -R -1 && echo '------') > " + output_file1.path

    # List the $PATH variable, cwd, and recursive contents into [name]1.txt.
    # Overall, run_shell is like a more customizable genrule, without the special symbols.
    # It has more things like environment variable setup, etc. that you can do.
    ctx.actions.run_shell(
        inputs=ctx.files.srcs,
        outputs=[output_file1],
        command=command,
    )
    # Second action copies in output from previous action and then does a cat and recursive list.
    # Output is [name]2.txt.
    # An important thing to know is that each action is SANDBOXED SEPARATELY, similarly to having
    # multiple genrules in a macro.  Also, the outputs of all the actions go into bazel-bin at the
    # end, not just the final output of the rule.
    ctx.actions.run_shell(
        inputs=[output_file1],
        outputs=[output_file2],
        command='(ls -R -1 && cat ' + output_file1.path + ') > ' + output_file2.path,
    )

    # Return the second output file as a DefaultInfo provider
    return [DefaultInfo(files=depset([output_file2]))]

foo_sandbox = rule(
    implementation = _foo_sandbox_impl,
    attrs = {
        'srcs': attr.label_list(allow_files = True),
    }
)

# This rule demonstrates how you can mimick genrule using a custom rule.
# It doesn't do nearly all that genrule does but just shows the basic stuff.
def _my_genrule_impl(ctx):
    cmd = ctx.attr.cmd
    srcs = ctx.files.srcs
    # These are already "declared" as output files because of the attribte type.
    outputs = ctx.outputs.outs

    # Notice that run_shell already looks a lot like genrule.
    ctx.actions.run_shell(
        inputs=srcs,
        outputs=outputs,
        command=cmd,
        # This is a hack I did as a POC for accessing srcs and outputs in the command.
        # I just passed them all in as args so you can use $1, $2, etc.
        arguments = [src.path for src in srcs] + [output.path for output in outputs],
        # Without this, you don't have your PATH, and you can't access anything you
        # rely on in the system.  This is the "correct hermetic" way, but it mismatches
        # what genrule does, and in many cases is too restrictive.
        # Setting this to true mimicks the genrule behavior in that regard.
        use_default_shell_env = True,
    )

    return [DefaultInfo(files=depset(outputs))]

my_genrule = rule(
    implementation = _my_genrule_impl,
    attrs = {
        'cmd': attr.string(mandatory = True),
        'srcs': attr.label_list(allow_files = True),

        # Attribute type for a list of output files.
        'outs': attr.output_list(mandatory = True),
    },
)

# This rule demonstrates running a single executable, as
# would often be the case in compiler rules.
def _touch_impl(ctx):
    output = ctx.actions.declare_file(ctx.attr.name + "_out.txt")

    # Similar to shell_run, but you run a specific excutable and pass args.
    # You cannot redirect stdout, so this will only work for commands that
    # create files a different way (as compilers do).
    # I tried passing > and a file as args and it doesn't work.
    ctx.actions.run(
        outputs = [output],
        executable = "touch",
        use_default_shell_env = True,
        arguments = [output.path],
    )

    return [DefaultInfo(files=depset([output]))]

touch = rule(
    implementation = _touch_impl,
)

# This rule demonstrates a few things:
# 1. using skylib paths module to do path transformations
# 2. dybamically specifying outputs based on transformed inputs
# 3. ctx.actions.args for wrapping adding of args to command
# NOTE: this rule won't work because it depends on having //tools:protoc defined.
#       It's just here for demonstration purposes.
def _protoc_py_impl(ctx):
    """Implementation of the protoc_py rule."""
    srcs = ctx.files.srcs
    # Calculate output directory based on bin dir and package path.
    output_dir = paths.join(ctx.bin_dir.path, ctx.label.package)
    print("output_dir: {}".format(output_dir)

    # Get the protoc executable from the system
    protoc = ctx.executable._protoc

    # Create the list of arguments for protoc.
    # Output to the bin directory, package subdirectory.
    # The proto_path part may not be right - just for demonstration purposes.
    # The last part shows adding positional args.
    args = ctx.actions.args()
    args.add_all(["--python_out", output_dir])
    args.add_all(["--proto_path", paths.dirname(src.path) for src in srcs])
    args.add_all([src.path for src in srcs])

    # Define the output files
    outs = [ctx.actions.declare_file(paths.join(output_dir, paths.relativize(src.path, paths.dirname(src.path)) + ".pb2.py") for src in srcs)]

    # Create the action that runs protoc
    ctx.actions.run(
        inputs = srcs,
        outputs = outs,
        executable = protoc,
        arguments = [args],
        # mnemonics are for logging and debug purposes
        mnemonic = "ProtocPy",
        use_default_shell_env = True,
        progress_message = "Generating Python code from %d .proto files" % len(srcs)
    )

    # Return a struct that represents the output of the rule
    return [DefaultInfo(files = depset(outs))]

protoc_py = rule(
    implementation = _protoc_py_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".proto"]),
        # Specifying the target tool to use, and that it's an executable target and runs in host config.
        "_protoc": attr.label(default = Label("//tools:protoc"), executable = True, cfg = "host"),
    },
    doc = "Generates Python code from .proto files using protoc."
)
