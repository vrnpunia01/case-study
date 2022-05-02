# case-study Security Group of VPC
resource "aws_security_group" "case-study" {
  name        = "${var.environment}-case-study-sg"
  description = "case-study SG to alllow traffic from the VPC"
  vpc_id      = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]

    ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Environment = var.environment
    Name: "${var.environment}-sg"
  }
}
