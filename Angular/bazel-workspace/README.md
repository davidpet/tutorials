# BazelWorkspace

This project was generated with [Angular CLI](https://github.com/angular/angular-cli) version 16.0.2.

## Inspiration

The concepts being explored here (via commit history) are inspired by these examples:

[Aspect Build Angular Example](https://github.com/aspect-build/bazel-examples/tree/main/angular) - basic Angular/Bazel functionality via hybrid approach (the bulk of the exploration here)

[Aspect Build Angular Ngc Example](https://github.com/aspect-build/bazel-examples/tree/main/angular-ngc) - more low-level (and granular) Angular/Bazel Functionality (with sacrifice of schematics and other support from Angular team)

[Aspect Build Bazel Rules](https://github.com/aspect-build/rules_js) - rules used by the above examples that you can also use

[Angular DevKit Architect Docs](https://www.npmjs.com/package/@angular-devkit/architect-cli) - just a reference to help understand the rules

## Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The application will automatically reload if you change any of the source files.

## Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

## Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

Run `ng build my-app -c production` to build a production/minified build - but you must have built the libraries first (my-lib and common-lib) with `ng build my-lib` and `ng build common-lib`.

## Node Dependencies

Notice that the node dependencies are at the angular workspace level, not at the individual app/lib level. So you would npm install to the workspace, and those would become your common dependencies for everything. One would presume/hope unnecessary dependencies won't make it into minified production builds of individual apps.

## Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

## Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Further help

To get more help on the Angular CLI use `ng help` or go check out the [Angular CLI Overview and Command Reference](https://angular.io/cli) page.
