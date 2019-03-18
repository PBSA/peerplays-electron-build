var fs = require('fs');
var rootPackageJSON = './package.json';
var subModulePackageJSON = require('./contents/package.json');
var file = require(rootPackageJSON);

file.version = subModulePackageJSON.version;
file.name = subModulePackageJSON.name;

fs.writeFile(rootPackageJSON, JSON.stringify(file, null, 2), function (err) {
  if (err) return console.log(err);
});