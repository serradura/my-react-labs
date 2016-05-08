# Based on https://github.com/reactjs/react-tutorial/blob/master/server.rb.

require 'webrick'
require 'json'

# default port to 3000 or overwrite with PORT variable by running
# $ PORT=3001 ruby server.rb
port = ENV['PORT'] ? ENV['PORT'].to_i : 3000

puts "Server started: http://localhost:#{port}/"

encoding = 'UTF-8'
filename = './tmp/comments.json'

# Create the json "database" if it doesn't exists.
unless File.exists? filename
  File.open(filename, 'w') { |f| f.puts('[]') }
end

root = File.expand_path './public'
server = WEBrick::HTTPServer.new Port: port, DocumentRoot: root

server.mount_proc '/api/comments' do |req, res|
  comments = JSON.parse(File.read(filename, encoding: encoding))

  if req.request_method == 'POST'
    # Assume it's well formed
    comment = { id: (Time.now.to_f * 1000).to_i }

    if req.query.empty? && !req.body.empty?
      comment = comment.merge(JSON.parse(req.body))
    else
      req.query.each do |key, value|
        comment[key] = value.force_encoding(encoding) unless key == 'id'
      end
    end

    comments << comment

    File.write(
      filename,
      JSON.pretty_generate(comments, indent: '    '),
      encoding: encoding
    )
  end

  # always return json
  res['Content-Type'] = 'application/json'
  res['Cache-Control'] = 'no-cache'
  res['Access-Control-Allow-Origin'] = '*'
  res.body = JSON.generate(comments)
end

trap('INT') { server.shutdown }

server.start
