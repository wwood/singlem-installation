This repository serves as a fully worked (containerised) example for the installation of the [SingleM software package](https://wwood.github.io/singlem/) on a Linux system.

If you are simply attempting to install SingleM on your own system, you should follow the instructions on the [SingleM website](https://wwood.github.io/singlem/). Instructions there include for installing SingleM via dockerhub, which produces an optimised (and pre-built) image. Use that one if the intention is to use SingleM on your data.

The repository here is simply intended to show installation in a containerised environment free from the SingleM authors' specific computing environment.

To process the example installation, after entering the repository directory, run the following bash script replacing `RELEASE_VERSION` with the version of SingleM you wish to install (e.g. 0.16.0):

This will build/download multiple containers and log the output to `*.build.log` files. The build process will take some time, as it involves downloading and compiling a number of dependencies. A small sequence file through each as well to ensure SingleM not just installs, but also runs.

```bash
bash compile_and_test_install_methods.bash RELEASE_VERSION
```

The `*.build.log` files created using this process is available in this repository.
