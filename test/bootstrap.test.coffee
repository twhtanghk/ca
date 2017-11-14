Promise = require 'bluebird'
Sails = Promise.promisifyAll require 'sails'
fs = require 'fs'
config = JSON.parse fs.readFileSync './.sailsrc'

before ->
  Sails
    .liftAsync config
    .catch console.error

after ->
  Sails
    .lowerAsync()
    .catch console.error
