# BazelWorkspace

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 16.0.2.

## Inspiration

The concepts being explored here (via commit history) are inspired by these examples:

[Aspect Build Angular Example](https://github.com/aspect-build/bazel-examples/tree/main/angular) - basic Angular/Bazel functionality via hybrid approach (the bulk of the exploration here)

[Aspect Build Angular Ngc Example](https://github.com/aspect-build/bazel-examples/tree/main/angular-ngc) - more low-level (and granular) Angular/Bazel Functionality (with sacrifice of schematics and other support from Angular team)

[Aspect Build Bazel Rules](https://github.com/aspect-build/rules_js) - rules used by the above examples that you can also use

[Angular DevKit Architect Docs](https://www.npmjs.com/package/@angular-devkit/architect-cli) - just a reference to help understand the rules

## Development server

Run `ng serve` for a dev server using the Angular CLI. To more specifically run for a given app, use `ng serve my-app`.

Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

Run `bazel run //apps/my-app:serve` for a dev server using bazel.

In either case, there are no build artifacts because Angular builds a development build in-memory when you use `serve`.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

You can place the new component into a specific project like this `ng generate component component-name --project my-lib`.

## Build

Run `ng build` to build the project using the Angular CLI. The build artifacts will be stored in the `dist/` directory.

To build a specific portion, use `ng build my-app` for instance.

Run `ng build my-app -c production` to build a production/minified build - but you must have built the libraries first (my-lib and common-lib) with `ng build my-lib` and `ng build common-lib`.

NOTE: currently `production` is the default in angular.json (you can change it to `development` if needed).

Run `bazel build //...` to build the project using bazel. The build artifacts will be stored in the `bazel-bin/` directory. It will use the configuration that's specified as the default in `angular.json` (currently production). To be able to build dev or prod without changing the default, you probably have to use jq to modify the field in angular.json. I tried adding args in the architect_cli target and it didn't work.

## Node Dependencies

Notice that the node dependencies are at the angular workspace level, not at the individual app/lib level. So you would npm install to the workspace, and those would become your common dependencies for everything. One would presume/hope unnecessary dependencies won't make it into minified production builds of individual apps.

Also remember to `npm install` after syncing to bring down the npm packages for angular CLI to use.

In addition, in this workspace, after npm installing, you must run `pnpm import` to generate the pnpm lock file from the npm lock file. You need to have `pnpm` installed globally via npm to be able to do this.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

Run `bazel test //...` to execute the unit tests using bazel.

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

# NOTE

Executing tests with `bazel test //...` currently fails on MacOS due to sandboxing issues. To debug tests run `bazel run //path/to:test`.

# NOTE

See commits in the `Angular` example for how to add precommit hooks later when needed. I didn't mess with that here.

# ToDo

- adding npm package used by my-app example (like the dragula one)
- automatic execution of `pnpm import` in case of changing json package lock.
- tests
- snippets pointing to commits in this tutorial (and breaking down angular.json and bazel concepts)
