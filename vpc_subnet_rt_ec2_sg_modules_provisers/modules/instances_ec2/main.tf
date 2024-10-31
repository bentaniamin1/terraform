
resource "aws_instance" "example" {
  ami           = var.ami_value
  instance_type = lookup(var.instance_type_value, var.value_instance, "t2.micro")
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id_value

  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/web_app/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "cd /home/web_app",
      "sudo python3 app.py &"
     ]
    
  }
}