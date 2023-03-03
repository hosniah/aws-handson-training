resource "aws_key_pair" "ahmed-key" {
  key_name   = "ahmed-keypair"
  public_key = file("dovekey.pub")
}

resource "aws_instance" "dove-inst" {
  ami                    = var.amis[var.region]
  instance_type          = "t2.micro"
  availability_zone      = var.zone1
  key_name               = aws_key_pair.ahmed-key.key_name
  vpc_security_group_ids = ["sg-06565554bc987fe80"]
  tags = {
    Name    = "AWS-Instance"
    Project = "AWSTraining"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = var.user
    private_key = file("dovekey")
    host        = self.public_ip
  }
}