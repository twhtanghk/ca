{load} = require 'activerecord-model'
_ = require 'lodash'
path = require 'path'
glob = require 'glob'

babelLoader =
  loader: 'babel-loader'
  query:
    plugins: [ 
      [
        'transform-runtime'
        {
          helpers: false
          polyfill: true
          regenerator: true
          moduleName: 'babel-runtime'
        }
      ]
    ]
    presets: [
      'es2015'
      'stage-2'
    ]

module.exports =
  node:
    module: 'empty'
    net: 'empty'
    fs: 'empty'
    'child_process': 'empty'
  externals:
    xml2js: 'xml2js'
  entry:
    index: [
      'whatwg-fetch'
      'babel-polyfill'
      './www/js/index.coffee'
      './www/js/config.coffee'
    ]
    callback: './www/js/callback.coffee'
  output:
    path: path.join __dirname, 'www/js'
    filename: "[name].js"
  module:
    loaders: [
      { 
        test: /\.scss$/
        use: [
          'style-loader'
          'css-loader'
          'sass-loader'
        ] 
      }
      { 
        test: /\.css$/
        use: [
          'style-loader'
          'css-loader'
        ] 
      }
      { 
        test: /\.litcoffee$/
        use: [
          {
            loader: 'coffee-loader'
            options:
              sourceMap: true
              literate: true
          }
        ]
      }
      { 
        test: /\.coffee$/
        use: [
          {
            loader: 'coffee-loader'
            options:
              sourceMap: true
          }
        ]
      }
    ]
#  devtool: "#source-map"
