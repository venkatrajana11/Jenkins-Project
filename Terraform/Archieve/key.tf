resource "aws_key_pair" "terraform-keypair" {
  key_name   = "terraform-keypair"
  public_key = file("/home/ubuntu/.ssh/mykey.pub")
}