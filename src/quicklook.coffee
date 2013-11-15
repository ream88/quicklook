exec = require('child_process').exec
fs = require('fs')

module.exports = (path, callback) ->
  args = "-t -s 1024 -o . #{path}"

  exec "qlmanage #{args}", (err, stdout) ->
    preview = "#{path}.png"

    fs.exists preview, (exists) ->
      callback(preview if exists)


