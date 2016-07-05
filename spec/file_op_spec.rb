require "openssl"
require 'spec_helper'

describe OsslRsa::FileOp do

  let(:dir_path) { 'C:\GitHub' }

  it 'write file pem test' do
    rsa = OsslRsa::Rsa.new({size: 2048})
    key_pair = rsa.key_pair(OsslRsa::PEM)
    file_path_pair = OsslRsa::FileOp.save(dir_path, key_pair, OsslRsa::PEM)
    expect(File.exist?(file_path_pair[:private])).to be_truthy
    expect(File.exist?(file_path_pair[:public])).to be_truthy

    private_contesnts = File.read(file_path_pair[:private])
    expect(private_contesnts).to eq key_pair[:private]
    public_contesnts = File.read(file_path_pair[:public])
    expect(public_contesnts).to eq key_pair[:public]

    File.delete(file_path_pair[:private])
    File.delete(file_path_pair[:public])
  end

  it 'write file der test' do
    rsa = OsslRsa::Rsa.new({size: 2048})
    key_pair = rsa.key_pair(OsslRsa::DER)
    file_path_pair = OsslRsa::FileOp.save(dir_path, key_pair, OsslRsa::DER)
    expect(File.exist?(file_path_pair[:private])).to be_truthy
    expect(File.exist?(file_path_pair[:public])).to be_truthy

    private_file = File.open(file_path_pair[:private], "rb")
    expect(private_file.read).to eq key_pair[:private]
    private_file.close
    public_file = File.open(file_path_pair[:public], "rb")
    expect(public_file.read).to eq key_pair[:public]
    public_file.close

    File.delete(file_path_pair[:private])
    File.delete(file_path_pair[:public])
  end

  it 'create file path non date pem test' do
    file_path_pair = OsslRsa::FileOp.create_file_path(dir_path, OsslRsa::PEM)
    # p file_path_pair
    expect(file_path_pair[:private]).to eq File.join(dir_path, "private.pem")
    expect(file_path_pair[:public]).to eq File.join(dir_path, "public.pem")
  end

  it 'create file path non date der test' do
    file_path_pair = OsslRsa::FileOp.create_file_path(dir_path, OsslRsa::DER)
    # p file_path_pair
    expect(file_path_pair[:private]).to eq File.join(dir_path, "private.der")
    expect(file_path_pair[:public]).to eq File.join(dir_path, "public.der")
  end

  it 'create file path add date pem test' do
    file_path_pair = OsslRsa::FileOp.create_file_path(dir_path, OsslRsa::PEM, true)
    # p file_path_pair
    expect(file_path_pair[:private]).not_to eq File.join(dir_path, "private.pem")
    expect(file_path_pair[:public]).not_to eq File.join(dir_path, "public.pem")
  end

  it 'create file name non date test' do
    file_name = OsslRsa::FileOp.create_file_name("test")
    expect(file_name).to eq "test"
  end

  it 'create file name add date test' do
    file_name = OsslRsa::FileOp.create_file_name("test", true)
    # puts file_name
    expect(file_name).not_to eq "test"
  end
end