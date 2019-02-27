## Overview
The following project is a boilerplate for compiling an electron application. Using git submodules we can 
link to another web project that builds its output to a build folder. The build process will copy the build
folder over and inject it as the contents for the electron app.

### Setup
> Double check the versions [package.json] within your submodule (contents directory) and the root. The compiled application will take the version number from the root package.json for the compiled application filename. Manually edit and update the root `package.json` version field to match that of `contents/package.json`.
```javascript
// Install the dependencies
npm install

// If compiling for linux the gettext package is required.
brew install gettext

// To Update the submodule with the latest code in develop.
npm run update-submodules

// Install the node packages for the repository that is now inside the contents directory.
cd contents/
npm install

// Ensure you have an environment configuration setup within config.js inside the newly populated contents directory before continuing.
// Set the environment name with one of the configured environments within config.js. beatrice is an example
TARGET=beatrice npm run build

// Move up a directory to the root of the boilerplate repo.
cd ../

// Compile the electron app.
npm run dist

// or
// Launch electron pointing at the development server.
npm run live
```
