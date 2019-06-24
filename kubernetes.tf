locals = {
  cluster_name                 = "k8s.dev.rishabhlabs.in"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-ap-south-1a-masters-k8s-dev-rishabhlabs-in.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"]
  masters_role_arn             = "${aws_iam_role.masters-k8s-dev-rishabhlabs-in.arn}"
  masters_role_name            = "${aws_iam_role.masters-k8s-dev-rishabhlabs-in.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-k8s-dev-rishabhlabs-in.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"]
  node_subnet_ids              = ["${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}", "${aws_subnet.ap-south-1b-k8s-dev-rishabhlabs-in.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-k8s-dev-rishabhlabs-in.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-k8s-dev-rishabhlabs-in.name}"
  region                       = "ap-south-1"
  route_table_public_id        = "${aws_route_table.k8s-dev-rishabhlabs-in.id}"
  subnet_ap-south-1a_id        = "${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}"
  subnet_ap-south-1b_id        = "${aws_subnet.ap-south-1b-k8s-dev-rishabhlabs-in.id}"
  vpc_cidr_block               = "${aws_vpc.k8s-dev-rishabhlabs-in.cidr_block}"
  vpc_id                       = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
}

output "cluster_name" {
  value = "k8s.dev.rishabhlabs.in"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-ap-south-1a-masters-k8s-dev-rishabhlabs-in.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-k8s-dev-rishabhlabs-in.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-k8s-dev-rishabhlabs-in.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-k8s-dev-rishabhlabs-in.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}", "${aws_subnet.ap-south-1b-k8s-dev-rishabhlabs-in.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-k8s-dev-rishabhlabs-in.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-k8s-dev-rishabhlabs-in.name}"
}

output "region" {
  value = "ap-south-1"
}

output "route_table_public_id" {
  value = "${aws_route_table.k8s-dev-rishabhlabs-in.id}"
}

output "subnet_ap-south-1a_id" {
  value = "${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}"
}

output "subnet_ap-south-1b_id" {
  value = "${aws_subnet.ap-south-1b-k8s-dev-rishabhlabs-in.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.k8s-dev-rishabhlabs-in.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
}

provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "kops"

}

resource "aws_autoscaling_group" "master-ap-south-1a-masters-k8s-dev-rishabhlabs-in" {
  name                 = "master-ap-south-1a.masters.k8s.dev.rishabhlabs.in"
  launch_configuration = "${aws_launch_configuration.master-ap-south-1a-masters-k8s-dev-rishabhlabs-in.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.dev.rishabhlabs.in"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-ap-south-1a.masters.k8s.dev.rishabhlabs.in"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-ap-south-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-k8s-dev-rishabhlabs-in" {
  name                 = "nodes.k8s.dev.rishabhlabs.in"
  launch_configuration = "${aws_launch_configuration.nodes-k8s-dev-rishabhlabs-in.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}", "${aws_subnet.ap-south-1b-k8s-dev-rishabhlabs-in.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "k8s.dev.rishabhlabs.in"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.k8s.dev.rishabhlabs.in"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-k8s-dev-rishabhlabs-in" {
  availability_zone = "ap-south-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "a.etcd-events.k8s.dev.rishabhlabs.in"
    "k8s.io/etcd/events"                           = "a/a"
    "k8s.io/role/master"                           = "1"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-k8s-dev-rishabhlabs-in" {
  availability_zone = "ap-south-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "a.etcd-main.k8s.dev.rishabhlabs.in"
    "k8s.io/etcd/main"                             = "a/a"
    "k8s.io/role/master"                           = "1"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-k8s-dev-rishabhlabs-in" {
  name = "masters.k8s.dev.rishabhlabs.in"
  role = "${aws_iam_role.masters-k8s-dev-rishabhlabs-in.name}"
}

resource "aws_iam_instance_profile" "nodes-k8s-dev-rishabhlabs-in" {
  name = "nodes.k8s.dev.rishabhlabs.in"
  role = "${aws_iam_role.nodes-k8s-dev-rishabhlabs-in.name}"
}

resource "aws_iam_role" "masters-k8s-dev-rishabhlabs-in" {
  name               = "masters.k8s.dev.rishabhlabs.in"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.k8s.dev.rishabhlabs.in_policy")}"
}

resource "aws_iam_role" "nodes-k8s-dev-rishabhlabs-in" {
  name               = "nodes.k8s.dev.rishabhlabs.in"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.k8s.dev.rishabhlabs.in_policy")}"
}

resource "aws_iam_role_policy" "masters-k8s-dev-rishabhlabs-in" {
  name   = "masters.k8s.dev.rishabhlabs.in"
  role   = "${aws_iam_role.masters-k8s-dev-rishabhlabs-in.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.k8s.dev.rishabhlabs.in_policy")}"
}

resource "aws_iam_role_policy" "nodes-k8s-dev-rishabhlabs-in" {
  name   = "nodes.k8s.dev.rishabhlabs.in"
  role   = "${aws_iam_role.nodes-k8s-dev-rishabhlabs-in.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.k8s.dev.rishabhlabs.in_policy")}"
}

resource "aws_internet_gateway" "k8s-dev-rishabhlabs-in" {
  vpc_id = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "k8s.dev.rishabhlabs.in"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-k8s-dev-rishabhlabs-in-ba3c9b5b3fedde61474b47226a172827" {
  key_name   = "kubernetes.k8s.dev.rishabhlabs.in-ba:3c:9b:5b:3f:ed:de:61:47:4b:47:22:6a:17:28:27"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.k8s.dev.rishabhlabs.in-ba3c9b5b3fedde61474b47226a172827_public_key")}"
}

resource "aws_launch_configuration" "master-ap-south-1a-masters-k8s-dev-rishabhlabs-in" {
  name_prefix                 = "master-ap-south-1a.masters.k8s.dev.rishabhlabs.in-"
  image_id                    = "ami-090143e982ce54077"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-k8s-dev-rishabhlabs-in-ba3c9b5b3fedde61474b47226a172827.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-k8s-dev-rishabhlabs-in.id}"
  security_groups             = ["${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-ap-south-1a.masters.k8s.dev.rishabhlabs.in_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-k8s-dev-rishabhlabs-in" {
  name_prefix                 = "nodes.k8s.dev.rishabhlabs.in-"
  image_id                    = "ami-090143e982ce54077"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-k8s-dev-rishabhlabs-in-ba3c9b5b3fedde61474b47226a172827.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-k8s-dev-rishabhlabs-in.id}"
  security_groups             = ["${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.k8s.dev.rishabhlabs.in_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.k8s-dev-rishabhlabs-in.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.k8s-dev-rishabhlabs-in.id}"
}

resource "aws_route_table" "k8s-dev-rishabhlabs-in" {
  vpc_id = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "k8s.dev.rishabhlabs.in"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
    "kubernetes.io/kops/role"                      = "public"
  }
}

resource "aws_route_table_association" "ap-south-1a-k8s-dev-rishabhlabs-in" {
  subnet_id      = "${aws_subnet.ap-south-1a-k8s-dev-rishabhlabs-in.id}"
  route_table_id = "${aws_route_table.k8s-dev-rishabhlabs-in.id}"
}

resource "aws_route_table_association" "ap-south-1b-k8s-dev-rishabhlabs-in" {
  subnet_id      = "${aws_subnet.ap-south-1b-k8s-dev-rishabhlabs-in.id}"
  route_table_id = "${aws_route_table.k8s-dev-rishabhlabs-in.id}"
}

resource "aws_security_group" "masters-k8s-dev-rishabhlabs-in" {
  name        = "masters.k8s.dev.rishabhlabs.in"
  vpc_id      = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "masters.k8s.dev.rishabhlabs.in"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_security_group" "nodes-k8s-dev-rishabhlabs-in" {
  name        = "nodes.k8s.dev.rishabhlabs.in"
  vpc_id      = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "nodes.k8s.dev.rishabhlabs.in"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  source_security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-k8s-dev-rishabhlabs-in.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-k8s-dev-rishabhlabs-in.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "ap-south-1a-k8s-dev-rishabhlabs-in" {
  vpc_id            = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
  cidr_block        = "10.2.101.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "ap-south-1a.k8s.dev.rishabhlabs.in"
    SubnetType                                     = "Public"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
    "kubernetes.io/role/elb"                       = "1"
  }
}

resource "aws_subnet" "ap-south-1b-k8s-dev-rishabhlabs-in" {
  vpc_id            = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
  cidr_block        = "10.2.102.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "ap-south-1b.k8s.dev.rishabhlabs.in"
    SubnetType                                     = "Public"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
    "kubernetes.io/role/elb"                       = "1"
  }
}

resource "aws_vpc" "k8s-dev-rishabhlabs-in" {
  cidr_block           = "10.0.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "k8s.dev.rishabhlabs.in"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "k8s-dev-rishabhlabs-in" {
  domain_name         = "ap-south-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                              = "k8s.dev.rishabhlabs.in"
    Name                                           = "k8s.dev.rishabhlabs.in"
    "kubernetes.io/cluster/k8s.dev.rishabhlabs.in" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "k8s-dev-rishabhlabs-in" {
  vpc_id          = "${aws_vpc.k8s-dev-rishabhlabs-in.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.k8s-dev-rishabhlabs-in.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
