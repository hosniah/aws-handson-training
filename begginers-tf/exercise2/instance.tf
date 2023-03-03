resource "aws_instance" "dove-inst" {
  ami                    = var.amis[var.region]
  instance_type          = "t2.micro"
  availability_zone       = var.zone1
  key_name               = "ahmed-kp"
  vpc_security_group_ids = ["sg-06565554bc987fe80"]
  tags = {
    Name    = "ahmed-Instance"
    Project = "AWSTraining"
  }
}
