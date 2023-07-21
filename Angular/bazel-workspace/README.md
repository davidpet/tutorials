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

The example from Aspect Build uses pnpm as the package manager instead of npm, but since npm is the default for the Node ecosystem, I prefer not to have to change which package manager I use for individual projects, so having to run the pnpm import command is an OK compromise for now. A possible way to enforce this is to have a precommit hook that runs `pnpm import` and fails if pnpm-lock.yaml changes.

## Summary of pnpm vs. npm

In order to use pnpm instead of npm, you have to:

1. Set cli.packageManager to pnpm in angular.json
1. Delete package-lock.json and use pnpm-lock.yaml instead.
1. Install packages using pnpm instead of npm.

pnpm will use node_modules just like npm will, but it will use its own format. It is not recommended to mix the two in the same project.

If you do the above steps and accidentally npm instead of pnpm install, package-lock.json will come back.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

Run `bazel test //...` to execute the unit tests using bazel.

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Automatic Refresh on Code Changes

When you run with `ng serve`, changes to the app itself, but not libraries it uses, will be picked up and cause the page to refresh fairly quickly.

When you run with `bazel run`, no changes will be automatically picked up - you'd have to kill the process and start it again.

You can install `ibazel` via npm globally and then `ibazel run` instead of bazel run. This will cause a reload if either the libraries or the app changes, so it's actually better than what you get with the Angular CLI. It seems to pick it up kind of slowly (5-10 seconds), but maybe the poll duration is configurable.

## Summary of Possible Precommit Hooks to Add

1. Formatting - buildifier, prettier, etc.
1. Linting - buildifier, eslint, etc.
1. `pnpm import` - make sure pnpm-lock.yaml doesn't change
1. Testing - affected tests (then run all tests in CI)

# NOTE

Executing tests with `bazel test //...` currently fails on MacOS due to sandboxing issues. To debug tests run `bazel run //path/to:test`.

# NOTE

See commits in the `Angular` example for how to add precommit hooks later when needed. I didn't mess with that here.

# ToDo

- tests
- snippets pointing to commits in this tutorial (and breaking down angular.json and bazel concepts)
