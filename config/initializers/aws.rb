Aws::VERSION =  Gem.loaded_specs["aws-sdk"].version

Aws.config.update({
  endpoint:'https://s3.us-east-2.amazonaws.com'
})
