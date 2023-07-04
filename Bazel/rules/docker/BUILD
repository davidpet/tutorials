genrule(
    name = "build_docker_image",
    # This will be the built docker image.
    outs = ["docker_image.tar"],
    # $HOME variable is just required by Docker - it serves no purpose other than to not error out
    # docker build command tags image as 'my_ubuntu_image'
    # - argument tells it to take from stdin
    # if you try to use a file instead, weirdness happens with docker having its own sandbox from
    # this sandbox, and the double sandbox doesn't work.
    # The only thing I could find is that you can try http with -H option, but after setting that
    # up, the same issue happened.
    # The save command saves the built docker image out of Docker and into a tar file.
    # It also hangs around in Docker if you view your images list.
    cmd = """
        export HOME=$$(pwd)
        docker build -t my_ubuntu_image - < $(location Dockerfile)
        docker save my_ubuntu_image > $@
    """,
    # This is the specification for what the image should look like.
    srcs = ["Dockerfile"],
)

genrule(
    name = "run_docker_container",
    # We send in the docker image itself so that it can be loaded from the sandbox.
    # We also send in a text file to show that the docker image is really looking
    # at the mounted filesystem from the sandbox.
    srcs = ["docker_image.tar", "input.txt"],
    outs = ["run_docker_container_output.txt"],
    # Before we do the docker stuff, we've got to do some weird tarring and
    # untarring to get around the fact that Bazel actually makes symlinks instead
    # of copying the files. When you mount the bazel sandbox, the files look
    # like they're there, but when you try to read them, they're not there.
    # So we are tarring with dereferencing and untarring to get a copy of the fold
    # that is not symlinked.
    # Because you can't tar a folder into itself, we have to use tmpdir and clean up
    # after it.

    # Next, load the image from the file (instead of relying on Docker state).
    # Then run it with the following options:
    #   - --rm = remove the container when done executing (don't leave in stopped state)
    #   - -v = mount volumes from the local (sandbox) filesystem into the container
    #           in this case, we need to send the srcs and outputs in via 2 volumes
    #   -w  = specify what the working directory should be when the command executes
    #         here I made it match the sandbox conceptually
    #   my_ubuntu_image = the tag (which we loaded in the previous command)
    #   -c = command to run and then destroy the container
    #       without this, it would run until explicitly stopped (eg. a web server)
    #   the specific command we send is just listing files in the working directory
    # Any errors in the command inside the image will propagate to docker cli outside
    # and cause a build error.
    cmd = """
        export TMPDIR=$$(mktemp -d)
        export TARFILE=$$TMPDIR/docker_rollup.tar
        export TARFOLDER=$(GENDIR)/docker_rollup
        cleanup() {
            rm -rf "$$TMPDIR"
        }
        trap cleanup EXIT

        tar -cvhf "$$TARFILE" .
        mkdir "$$TARFOLDER"
        tar -xf "$$TARFILE" -C "$$TARFOLDER"

        docker load < $(location docker_image.tar)
        docker run --rm -v $$(realpath "$$TARFOLDER"):/sandbox_src -v $$(realpath $(GENDIR)):/sandbox_out -w /sandbox_src my_ubuntu_image bash -c \
            "cat input.txt >/sandbox_out/run_docker_container_output.txt"
    """,
)

# NOTE about dependencies on other Dockerfiles:
# You can make another genrule() that depends on the build_docker_image one above.
# Then, 'docker load' that file before you docker build the next one
# (to make sure you don't depend on the state of Docker on the system).
# Then use the name (in the above example my_ubuntu_image) to refer to it in the
# other Dockerfile.
# There is no concept of relative paths to other Dockerfiles.

# NOTE: above we used my_ubuntu_image which is an image name
#       the full form would be something like my_ubuntu_image:1.0.0 (imagename:tag format)
