require "ossl_rsa/version"
require "ossl_rsa/rsa"
require "ossl_rsa/file_op"
require "ossl_rsa/generator"

# openssl rsa module.
module OsslRsa

  # pem mode.
  PEM = 0
  # der mode.
  DER = 1

  # RFC2045
  RFC2045 = 0
  # RFC4648
  RFC4648 = 1
end
