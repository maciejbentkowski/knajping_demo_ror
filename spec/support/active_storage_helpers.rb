module ActiveStorageHelpers
  def create_test_image(content: 'Fake image content', filename: 'test_image.jpg', content_type: 'image/jpeg')
    file = Tempfile.new([ filename, '.jpg' ])
    file.write(content)
    file.rewind

    { io: file, filename: filename, content_type: content_type }
  ensure
    file.close
    file.unlink
  end
end

RSpec.configure do |config|
  config.include ActiveStorageHelpers
end
