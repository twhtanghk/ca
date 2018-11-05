Promise = require 'bluebird'
Sails = Promise.promisifyAll require 'sails'
fs = require 'fs'
config = JSON.parse fs.readFileSync './.sailsrc'
path = require 'path'
{load} = require 'activerecord-model'

before ->
  Sails
    .liftAsync config
    .catch console.error

after ->
  Sails
    .lowerAsync()
    .catch console.error
