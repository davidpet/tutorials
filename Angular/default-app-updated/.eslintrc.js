const path = require('path');

module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended'],
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
    project: getTsConfigPath(),
  },
  rules: {},
  ignorePatterns: ["**/.eslintrc.js"],
};

function getTsConfigPath() {
  const eslintConfigPath = __filename;
  const eslintConfigDir = path.dirname(eslintConfigPath);
  return path.join(eslintConfigDir, 'tsconfig.json');
}
