assert = require('assert')
fs = require('fs')

quicklook = require('../src/quicklook')

describe 'quicklook', ->
  it 'generates a .png file', (done) ->
    quicklook 'README.md', (preview) ->
      fs.unlink 'README.md.png', done if preview


  it 'returns a error, if file not found', (done) ->
    quicklook 'not-existing', (preview) ->
      assert.equal undefined, preview
      done()
