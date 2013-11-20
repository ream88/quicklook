temp = require('temp')
path = require('path')
fs = require('fs')
exec = require('child_process').exec


module.exports.previewFile = previewFile = (inputPath, callback) ->
  args = "-t -s 1024 -o #{path.dirname(inputPath)} #{inputPath}"
  command = "qlmanage #{args}"

  exec command, (err, stdout) ->
    return callback(err) if err
    outputPath = "#{inputPath}.png"

    # qlmanage writes errors to stdout :(
    # so we check for lines beginning with [ERROR]
    return callback(new Error(message)) if message = (stdout.match(/^\[ERROR\].*$/m)||[])[0]

    callback err, outputPath


module.exports.preview = (buffer, extname, callback) ->
  # Automatically track and cleanup files at exit
  temp.track()

  temp.mkdir "quicklook", (err, dirPath) ->
    return callback(err) if err
    inputPath = path.join(dirPath, "file#{extname}")

    fs.writeFile inputPath, buffer, (err) ->
      return callback(err) if err

      previewFile inputPath, (err, outputPath) ->
        return callback(err) if err

        fs.readFile outputPath, (err, data) ->
          return callback(err) if err

          callback err, data
