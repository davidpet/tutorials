# all paths in this BUILD without // are relative to this folder
# // makes it relative to the workspace instead

# Any build of any target copies the WHOLE PACKAGE into bazel-basic
# (named after the workspace). This includes BUILD files, subfolders, files not
# listed in targets, etc. So bazel runs against that copy instead of this
# actual folder (which works because copies maintain modified timestampes).
# Only the folder of this BUILD file is copied, but the parent hierarchy
# of the resulting folder mirrors the hiearchy in the workspace 
# (bazel-basic/subfolder/subpackage/**).

# bazel-bin will contain outputs, mirroring the package structure (BUILD files).


# bazel build //subfolder/subpackage:text_files_specific
#
# bazel reports up-to-date no matter what, and triggers whole package copy
# (not just these files).
#
# On its own, this doesn't do anything, but when used by other targets as
# a dependency, it tells bazel which files to WATCH FOR CHANGES.
filegroup(
    name = "text_files_specific",
    srcs = [
        "text_files/file1.txt",
        "text_files/file2.txt",
        # Left out file3.txt on purpose
    ],
)

# bazel build //subfolder/subpackage:text_files_all
filegroup(
    name = "text_files_all",
    srcs = glob([
        "text_files/**",
    ]),
)

# You can create aliases for targets with their own visibility and such.
alias(
    name = "text_files",
    actual = ":text_files_all",
)

# bazel build //subfolder/subpackage:list_files
#
# Lists workspace-relative (not package relative) paths to all the src files (3 total) into
# bazel-bin/subfolder/subpackage/list_files_out.txt
# Note that it's not literally listing what you gave it (which is package relative) but
# does a transformation to make it relative to bazel-basic and/or bazel-bin.
#
# Always reports up-to-date and nothing to do, but actually
# regenerates the output file if any of the 3 files are
# modified since last time it built.
# Does not regenerate if the unspecified file is changed.
# (that is the benefit of using a filegroup instead of a folder)
# It will also rebuild/regenerate if the $PATH variable changes
# (because that might change which tools are used to create output).
#
# You cannot 'bazel run' this target. That is because this is for things like compilers and code generators,
# not for execution of the actual binary.
genrule(
    name = "list_files",
    # 3 source files total
    srcs = [":text_files_specific", "somefile.txt"],
    # This is required - you can't just print to the console.
    outs = ["list_files_out.txt"],
    # The $@ is special notation that is replaced by the path to the outfile you listed.
    # The $(SRCS) is bazel (not bash) function call to get all src files (specific) relative to workspace.
    cmd = "echo $(SRCS) > $@",
)

# The resulting file shows that the working directory looks like:
# /private/var/tmp/_bazel_davidpetrofsky/9de0c386ea982fd87a5646df6fa23c38/sandbox/darwin-sandbox/2/execroot/__main__
# By the time building completes, that doesn't exist anymore.  It is a sandbox created by bazel
# for the purpose of building.  When a target is used by another build or a run, only the output is used, so the
# sandbox doesn't (or should be assumed not to) exist anymore.
# Instead, the dependencies from bazel-bin will get copied into the next sandbox or runfiles as needed.
# Also note that the working directory looks like the workspace, not the package.
genrule(
    name = "working_directory",
    outs = ["working_directory_out.txt"],
    cmd = "pwd > $@",
)

# The sandbox contains a lot of stuff bazel puts there for its own purposes, but
# in this case does not contain any of our files since we didn't specify any.
# It is NOT A COPY OF THE PACKAGE or WORKSPACE.
genrule(
    name = "list_sandbox",
    outs = ["list_sandbox_out.txt"],
    cmd = "ls -R -1 > $@",
)

# Now because we have srcs listed, the sandbox contains the same stuff as before but
# also contains subfolder/subpackage/text_files with 2 text files (only the ones listed).
# Thus, the filegroup rule controls what files are actually visible to the genrule.
# Also, the relative path within the sandbox (which is cwd) looks like workspace path.
genrule(
    name = "list_sandbox_with_srcs",
    srcs = [":text_files_specific"],
    outs = ["list_sandbox_with_srcs.txt"],
    cmd = "ls -R -1 > $@",
)

# Building this rule will print 'hi' only the first time (or if srcs, when changes).
# It will output bye to the output file.
genrule(
    name = "console_output",
    outs = ["console_output_out.txt"],
    cmd = "echo 'hi' && echo 'bye' > $@",
)

# Even though this would normally be an error at the terminal, bazel creates the apporpriate
# folder structure based on the 'outs' attribute for you so that it works.
# WARNING: documentation recommands avoiding creation of directoreis or symlinks, but it's
# unclear if that only applies to making ones via commands as opposed to via outs paths.
genrule(
    name = "make_folders",
    outs = ["fakefolder/make_folders_out.txt"],
    cmd = "echo hi > $@",
)

# bazel detects the error and reports a build failure and the stderr output
# the file still gets created (empty) just as it would if you ran that
# command at the terminal.
genrule(
    name = "error",
    outs = ["error_out.txt"],
    cmd = "lsblawhat > $@",
)

# This doesn't echo fail at the end because the middle command fails.
# It does echo hi to the output file.
# It also reports a build failure at the terminal.
genrule(
    name = "errors",
    outs = ["errors_out.txt"],
    cmd = "echo hi > $@ && lsblawhat && echo fail"
)

# There are several things to note here about interaction with the shell environment.
# 1. You have to escape $ that is meant for the shell with a second $.
#   That is so that bazel can have its own $ syntax for $@ and $() stuff.
# 2. A variable that exists in the invoking shell (eg. PYTHONPATH) doesn't exist
#   in the environment of this command (causing an error in this case).
#   So whatever PYTHONPATH or whatever else you set up for development will not
#   affect bazel because it isolates it from that.
# 3. The exception to this is PATH which does exist and does contain the actual
#    path from the user, which will bring in conda stuff and whatever.
#    Thus, if you really need to break the hermeticity (eg. for pip installed commands to work),
#    this is a way.
# 4. Since there is an implicit dependency on $PATH, any genrule (even one that doesn't directly
#    reference $PATH) will rebuild if $PATH is changed.
genrule(
    name = "environment_variables",
    outs = ["environment_variables_out.txt"],
    cmd = "echo pythonpath: $$PYTHONPATH > $@ & echo path: $$PATH >> $@",
)

# The srcs attribute shows how you can reference individual files as targets even if not declared that way.
# This doesn't seem to work well for files that are in other package's folders from the BUILD the target you're writing is in.
# Note the use of subfolders in the 2nd src here.
genrule(
    name = "file_as_target",
    outs = ["file_as_target_out.txt"],
    srcs = [":somefile.txt", "//subfolder/subpackage:text_files/file2.txt",],
    cmd = "echo $(SRCS) > $@",
)

# The $(location) function works on targets or files that are included in the sandbox.
# It gives you the workspace-relative (working directory relative) path of the file/target.
# In a way, it is conversion from package-relative to workspace-relative.
genrule(
    name = "location",
    outs = ["location_out.txt"],
    srcs = ["somefile.txt"],
    cmd = "echo $(location somefile.txt) $(location :somefile.txt) > $@"
)

# The $(locations) function takes a target that has multiple files.
# In this case, it's the same as echoing $(SRCS), but you could do
# other things.
genrule(
    name = "locations",
    outs = ["locations_out.txt"],
    srcs = [":text_files_specific"],
    cmd = "echo $(locations :text_files_specific) > $@",
)

# Multiple lines/commands with triple quote.
# If any line fails, it will stop and fail the whole thing.
genrule(
    name = "multicommand",
    outs = ["multicommand_out.txt"],
    cmd = """
        export x=5  # safe because of hermetic shell execution of genrule
        echo $$x > $@
        echo Done now!
    """,
)

# A tool is basically like a src (you can have both), but bazel handles it a little
# differently internally because it knows you will execute it.
# You still need to mark it as executable yourself in the original file permissions.
# Also note that you can't just execute the file directly - you need to get its
# workspace-relative path as shown.
# If you're just executing one script, you should use sh_binary or similar instead.
genrule(
    name = "tools",
    outs = ["tools_out.txt"],
    tools = ["tool.sh"],
    cmd = "$(location tool.sh) > $@",
)

# This rule will serve as a dependency of another genrule below.
# It will copy tool.sh and somefile.txt into its sandbox,
# then run the command, then copy its output to bazel-bin, and
# destroy the sandbox.
genrule(
    name = "base",
    outs = ["base_out.txt"],
    tools = ["tool.sh"],
    srcs = ["somefile.txt"],
    cmd = "$(location tool.sh) > $@",
)

# This rule depends on the one above.
# Only the output file from above (not the srcs or tools) is used.
# But this is an interesting case because the src file is not
# directly in the sandbox under the workspace-like path like usual.
# It is in a bazel-out subpath of the sandbox, with $(SRCS) giving
# the right relative path (which looks different than usual).
# If the output of the "base" rule depended on its tool or srcs at
# runtime (eg. if it was a generated script), that wouldn't work
# here without defining those dependencies in the derived rule.
genrule(
    name = "derived",
    outs = ["derived_out.txt"],
    srcs = [":base"],
    cmd = "echo $(SRCS) > $@ && cat $(SRCS) >> $@ && ls -R -1 >> $@"
)

# This is how you handle multiple outputs.
# You are not allowed to use the variable $@ when there is more than 1 output.
# $(OUTS) is a list of all the output files, so if you had a script that takes
# multiple paths, you could pass that there.
# The $(location) function can automatically figure out you want outputs by
# name of file as shown here, and that can be used to send different output to
# different files.
# Bazel doesn't care how the files are made - just that they exist after building.
# In this example, we had to hardcode by name - that is unfortunately always
# true, but you can write a macro to hide that for a specific pattern (eg. 
# if you need to call a command with specific args that are output paths).
genrule(
    name = "multiple_outputs",
    outs = ["multiple_outputs_1.txt", "multiple_outputs_2.txt",],
    cmd = "echo $(OUTS) >$(location multiple_outputs_1.txt) && echo done >$(location multiple_outputs_2.txt)"
)

# $(OUTS) is a string, so to index it in Bash, you need to make it an array with ().
# Then you can use the bash ${array[i]} syntax (with $$ to escape).
genrule(
    name = "multiple_outputs_indexed",
    outs = ["multiple_outputs_indexed_1.txt", "multiple_outputs_indexed_2.txt",],
    cmd = """
        export outsval=($(OUTS))
        echo $${outsval[0]} >$(location multiple_outputs_indexed_1.txt)
        echo $${outsval[1]} >$(location multiple_outputs_indexed_2.txt)
        echo 
    """
)

# This shows the basic mechanics of globbing.
# Import points to note:
# - globbing returns a list
# - you can only glob srcs and data (exist prior to build)
# - globbing retains the folder structure
genrule(
    name = "globbing",
    # ** is 0 or more folders (recursive) relative to package
    # you can have multiple ** at any level in glob path
    srcs = glob(["**/*.txt"], exclude=["somefile.txt"]) + 
    # the result of globbing is an array, so if you want
    # non-glob stuff too, you have to append like this
           ["somefile.txt"],
    outs = ["globbing_out.txt"],
    cmd = "ls -R -1 ./subfolder/subpackage > $@",
)

# Summary of special symbols within genrule.
genrule(
    name = "special_symbols_summary",
    srcs = ["somefile.txt", "tool.sh", ":globbing", ":multiple_outputs"],
    outs = ["special_symbols_summary_out.txt"],
    # Note the following:
    # 1. genrule special symbols are CASE SENSITIVE
    #    eg. you cannot use $(srcs) or $(LOCATION) because those are wrong case
    # 2. $(location) on multiple targets fails - use $(locations) instead
    #    but $(locations) on single target works because it's just multiple with 1
    # 3. ChatGPT keeps using $(GENFILES) in its examples - that does not appear to be real
    # 4. realpath is a shell command that is very helpful for getting absolute paths
    #    just make sure to use $$ instead of $ when calling it
    cmd = """
        export x=10

        echo location on target with single output: $(location :globbing) >$@
        echo locations on target with single output: $(locations :globbing) >>$@
        echo locations on target with multiple outputs: $(locations :multiple_outputs) >>$@
        echo SRCS: $(SRCS) >>$@
        echo OUTS: $(OUTS) >>$@
        echo GENDIR: $(GENDIR) >>$@
        echo ESCAPING: $$x $$(pwd) >>$@
        echo REALPATH: $$(realpath .) >>$@
        echo REALPATH on targets: $$(realpath $(locations :multiple_outputs)) >>$@
        echo REALPATH on gendir: $$(realpath $(GENDIR)) >>$@
    """
)

# Other genrule options you can use:
# executable = to make the output executable (eg. script generation) [boolean]
# local = to run locally instead of in sandbox [boolean]
