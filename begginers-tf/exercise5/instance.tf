resource "aws_key_pair" "dove-key" {
  key_name   = "ahmed-dovekey"
  public_key = file(var.pub_key)
}

resource "aws_instance" "dove-web" {
  ami                    = var.amis[var.region]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dove-pub-1.id
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = [aws_security_group.dove_stack_sg.id]
  tags = {
    Name = "my-dove"
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
    private_key = file(var.priv_key)
    host        = self.public_ip
  }

}

resource "aws_ebs_volume" "vol_4_dove" {
  availability_zone = var.zone1
  size              = 3
  tags = {
    Name = "extr-vol-4-dove"
  }
}

resource "aws_volume_attachment" "atch_vol_dove" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_4_dove.id
  instance_id = aws_instance.dove-web.id
}


output "PublicIP" {
  value = aws_instance.dove-web.public_ip
}
