assert = require('assert')
fs = require('fs')

quicklook = require('../src/quicklook')

describe 'quicklook', ->
  describe 'previewFile', ->
    it 'generates preview of a file', (done) ->
      quicklook.previewFile 'README.md', (err, file) ->
        assert.ok !err

        fs.exists file, (exists) ->
          assert.ok exists
          fs.unlink file, done


    it 'returns an error if file not found', (done) ->
      quicklook.previewFile 'not-existing', (err, file) ->
        assert err
        done()


  describe 'preview', ->
    it 'generates preview of a buffer', (done) ->
      fs.readFile 'README.md', (err, file) ->
        quicklook.preview file, '.md', (err, file) ->
          assert.ok !err
          assert.ok file
          done()
