import { AbstractControl, ValidationErrors, ValidatorFn } from "@angular/forms";

/** A name can't match the given regular expression */
// Gets custom object on error(s) and null on success.
// You don't need to include it in a module because it's
// just a function call.
export function forbiddenNameValidator(nameRe: RegExp): ValidatorFn {
  return (control: AbstractControl): ValidationErrors | null => {
    const forbidden = nameRe.test(control.value);
    return forbidden ? {forbiddenName: {value: control.value}} : null;
  };
}
