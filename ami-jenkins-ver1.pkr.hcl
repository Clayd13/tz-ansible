source "amazon-ebs" "amiforjenkins" {
  ami_name       = "packer-ami-jenkins-tz {{timestamp}}"
  instance_type  = "t2.small"
  region         = "eu-central-1"
  source_ami     = "ami-0db9040eb3ab74509"
  ssh_username   = "ec2-user"
  vpc_id         = "vpc-xxx"
  subnet_id      = "subnet-xxx"
  }

build {
  sources = ["source.amazon-ebs.amiforjenkins"]

provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo yum -y update",
	  "sleep 30",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sleep 30",
	  "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum install git jenkins -y",
      "sleep 30",
      "sudo systemctl start jenkins",
      "sudo systemctl enable jenkins",
    ]
  }
}