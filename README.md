# CMG Blue/Green Cluster Module

This module provides the capacity to build a full blue/green clustered stack using either Application Load Balancer or Network Load Balancer.

You can use this module to build a comprehensive, autoscaling stack based on any AMI, which can be rolled out using weighted DNS entries.

It will build the following artifacts:

### ALB/NLB

* Blue ALB or NLB
* Green ALB or NLB
* Security groups for Blue ALB
* Security groups for Green ALb
* Route53 DNS entries for Blue ALB/NLB
* Route53 DNS entries for Green ALB/NLB


### Cluster Instances

* Blue ASG
* Green ASG
* Blue Launch Configuration
* Green Launch Configuration
* Blue instances (launched by ASG)
* Green instances (launched by ASG)
* Blue instance security groups
* Green instance security groups
* Basic scaling policies 


### Logging

* S3 bucket for ALB logs
* Cloudwatch Logs Streams for applications

### IAM

* Basic IAM Roles for cluster instances


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| blue\_alb\_http\_tcp\_listeners | The HTTP/TCP listeners to attach to the blue ALB | list | `<list>` | no |
| blue\_alb\_http\_tcp\_listeners\_count | The number of HTTP/TCP listeners to attach the blue ALB | string | `"0"` | no |
| blue\_alb\_https\_listeners | The listeners to attach to the blue ALB | list | `<list>` | no |
| blue\_alb\_https\_listeners\_count | The number of HTTPS listeners to attach the blue ALB | string | `"0"` | no |
| blue\_application\_ports | The ports the ALB should be able to connect to the blue cluster on | list | `<list>` | no |
| blue\_desired\_capacity | The number of instances to put into the blue cluster | string | `"1"` | no |
| blue\_desired\_capacity\_start | How many instances to start when the ASG start hook is triggered | string | n/a | yes |
| blue\_desired\_capacity\_stop | How many instances to stop when the ASG stop hook is triggered | string | n/a | yes |
| blue\_external\_alb\_target\_groups | The target groups to attach to the blue ALB | list | `<list>` | no |
| blue\_external\_alb\_target\_groups\_count | The number of target groups to attach to the blue ALB | string | `"0"` | no |
| blue\_external\_nlb\_target\_groups | The target groups to attach to the blue ALB | list | `<list>` | no |
| blue\_external\_nlb\_target\_groups\_count | The number of target groups to attach to the blue ALB | string | `"0"` | no |
| blue\_image\_id | The AMI ID to use for the blue cluster | string | n/a | yes |
| blue\_instance\_type | The instance type to use for the blue cluster | string | `"t2.small"` | no |
| blue\_internal\_alb\_target\_groups | The target groups to attach to the blue ALB | list | `<list>` | no |
| blue\_internal\_alb\_target\_groups\_count | The number of target groups to attach to the blue ALB | string | `"0"` | no |
| blue\_internal\_nlb\_target\_groups | The target groups to attach to the blue ALB | list | `<list>` | no |
| blue\_internal\_nlb\_target\_groups\_count | The number of target groups to attach to the blue ALB | string | `"0"` | no |
| blue\_max\_size | The number of instances to put into the blue cluster | string | `"1"` | no |
| blue\_max\_size\_start | How many instances to start when the ASG start hook is triggered | string | n/a | yes |
| blue\_max\_size\_stop | How many instances to stop when the ASG stop hook is triggered | string | n/a | yes |
| blue\_min\_size | The number of instances to put into the blue cluster | string | `"1"` | no |
| blue\_min\_size\_start | How many instances to start when the ASG start hook is triggered | string | n/a | yes |
| blue\_min\_size\_stop | How many instances to stop when the ASG stop hook is triggered | string | n/a | yes |
| blue\_nlb\_http\_tcp\_listeners | The HTTP/TCP listeners to attach to the blue NLB | list | `<list>` | no |
| blue\_nlb\_http\_tcp\_listeners\_count | The number of HTTP/TCP listeners to attach the blue NLB | string | `"0"` | no |
| blue\_nlb\_https\_listeners | The listeners to attach to the blue NLB | list | `<list>` | no |
| blue\_nlb\_https\_listeners\_count | The number of HTTPS listeners to attach the blue NLB | string | `"0"` | no |
| blue\_recurrence\_start | When to start the instances | string | `"false"` | no |
| blue\_recurrence\_stop | When to stop the instances | string | `"false"` | no |
| blue\_route53\_aliases\_name | List of ALB Route53 aliases | list | `<list>` | no |
| blue\_version\_tag | The version of the blue product release | string | n/a | yes |
| blue\_wait\_for\_capacity\_timeout | How long to wait before timing out introducing the new green ASG instances | string | `"0"` | no |
| blue\_weight | Weight of the DNS record for the blue cluster | string | n/a | yes |
| cluster\_name | What to name the blue/green cluster and all of its associated resources | string | n/a | yes |
| cost\_code | The code for the CMG costing | string | n/a | yes |
| external\_alb\_computed\_egress\_with\_cidr\_blocks | List of objects describing the egress cidr blocks rules permitted for the cluster albs | list | `<list>` | no |
| external\_alb\_computed\_egress\_with\_source\_security\_group\_id | List of objects describing the inbound security group rules permitted on the albs for the cluster | list | `<list>` | no |
| external\_alb\_computed\_ingress\_with\_cidr\_blocks | List of objects describing the ingress cidr blocks rules permitted for the loadbalancer | list | `<list>` | no |
| external\_alb\_computed\_ingress\_with\_source\_security\_group\_id | List of objects describing the inbound security group rules permitted on the albs for the cluster albs | list | `<list>` | no |
| external\_alb\_enabled | Whether to create an external ALB or not | string | `"true"` | no |
| external\_alb\_number\_of\_computed\_egress\_with\_cidr\_blocks | The count of computed egress cidr blocks for the cluster albs | string | `"0"` | no |
| external\_alb\_number\_of\_computed\_egress\_with\_source\_security\_group\_id | The count of computed egress security groups by ID for the cluster albs | string | `"0"` | no |
| external\_alb\_number\_of\_computed\_ingress\_with\_cidr\_blocks | The count of computed ingress cidr blocks for the cluster albs | string | `"0"` | no |
| external\_alb\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id | The count of computed ingress security groups by ID for the cluster albs | string | `"0"` | no |
| external\_alb\_route53\_zone\_id | The route 53 zone ID to use for the ALB DNS entries | string | `""` | no |
| external\_alb\_security\_groups | Attach security groups directly to the ALB by their ID | list | `<list>` | no |
| external\_alb\_subnet\_ids | An list of subnet ID to attach the ELB to which are within the specified VPC | string | `""` | no |
| external\_nlb\_enabled | Whether to create an NLB or not | string | `"false"` | no |
| external\_nlb\_route53\_zone\_id | The route 53 zone ID to use for the NLB DNS entries | string | `""` | no |
| external\_nlb\_subnet\_ids | An list of subnet ID to attach the ELB to which are within the specified VPC | string | `""` | no |
| green\_alb\_http\_tcp\_listeners | The HTTP/TCP listeners to attach to the green ALB | list | `<list>` | no |
| green\_alb\_http\_tcp\_listeners\_count | The number of HTTP/TCP listeners to attach the green ALB | string | `"0"` | no |
| green\_alb\_https\_listeners | The listeners to attach to the green ALB | list | `<list>` | no |
| green\_alb\_https\_listeners\_count | The number of HTTPS listeners to attach the green ALB | string | `"0"` | no |
| green\_application\_ports | The ports the ALB should be able to connect to the green cluster on | list | `<list>` | no |
| green\_desired\_capacity | The number of instances to put into the green cluster | string | `"1"` | no |
| green\_desired\_capacity\_start | How many instances to start when the ASG start hook is triggered | string | n/a | yes |
| green\_desired\_capacity\_stop | How many instances to stop when the ASG stop hook is triggered | string | n/a | yes |
| green\_external\_alb\_target\_groups | The target groups to attach to the green ALB | list | `<list>` | no |
| green\_external\_alb\_target\_groups\_count | The number of target groups to attach to the green ALB | string | `"0"` | no |
| green\_external\_nlb\_target\_groups | The target groups to attach to the green NLB | list | `<list>` | no |
| green\_external\_nlb\_target\_groups\_count | The number of target groups to attach to the green NLB | string | `"0"` | no |
| green\_image\_id | The AMI ID to use for the green cluster | string | n/a | yes |
| green\_instance\_type | The instance type to use for the green cluster | string | `"t2.small"` | no |
| green\_internal\_alb\_target\_groups | The target groups to attach to the green ALB | list | `<list>` | no |
| green\_internal\_alb\_target\_groups\_count | The number of target groups to attach to the green ALB | string | `"0"` | no |
| green\_internal\_nlb\_target\_groups | The target groups to attach to the green NLB | list | `<list>` | no |
| green\_internal\_nlb\_target\_groups\_count | The number of target groups to attach to the green NLB | string | `"0"` | no |
| green\_max\_size | The number of instances to put into the green cluster | string | `"1"` | no |
| green\_max\_size\_start | How many instances to start when the ASG start hook is triggered | string | n/a | yes |
| green\_max\_size\_stop | How many instances to stop when the ASG stop hook is triggered | string | n/a | yes |
| green\_min\_size | The number of instances to put into the green cluster | string | `"1"` | no |
| green\_min\_size\_start | How many instances to start when the ASG start hook is triggered | string | n/a | yes |
| green\_min\_size\_stop | How many instances to stop when the ASG stop hook is triggered | string | n/a | yes |
| green\_nlb\_http\_tcp\_listeners | The HTTP/TCP listeners to attach to the green NLB | list | `<list>` | no |
| green\_nlb\_http\_tcp\_listeners\_count | The number of HTTP/TCP listeners to attach the green NLB | string | `"0"` | no |
| green\_nlb\_https\_listeners | The listeners to attach to the green NLB | list | `<list>` | no |
| green\_nlb\_https\_listeners\_count | The number of HTTPS listeners to attach the green NLB | string | `"0"` | no |
| green\_recurrence\_start | When to start the green instances | string | `"false"` | no |
| green\_recurrence\_stop | When to stop the green instances | string | `"false"` | no |
| green\_route53\_aliases\_name | List of ALB Route53 aliases | list | `<list>` | no |
| green\_target\_groups | The target groups to attach to the green ALB | list | `<list>` | no |
| green\_target\_groups\_count | The number of target groups to attach to the green ALB | string | `"0"` | no |
| green\_version\_tag | The version of the green product release | string | n/a | yes |
| green\_wait\_for\_capacity\_timeout | How long to wait before timing out introducing the new green ASG instances | string | `"0"` | no |
| green\_weight | Weight of the DNS record for the green cluster | string | n/a | yes |
| iam\_policies | The IAM policies to attach to the IAM role for the cluster instances | list | `<list>` | no |
| instance\_computed\_egress\_with\_cidr\_blocks | List of objects describing the egress cidr blocks rules permitted for the cluster instances | list | `<list>` | no |
| instance\_computed\_egress\_with\_source\_security\_group\_id | List of objects describing the inbound security group rules permitted on the instances for the cluster | list | `<list>` | no |
| instance\_computed\_ingress\_with\_cidr\_blocks | List of objects describing the ingress cidr blocks rules permitted for the loadbalancer | list | `<list>` | no |
| instance\_computed\_ingress\_with\_source\_security\_group\_id | List of objects describing the inbound security group rules permitted on the instances for the cluster instances | list | `<list>` | no |
| instance\_number\_of\_computed\_egress\_with\_cidr\_blocks | The count of computed egress cidr blocks for the cluster instances | string | `"0"` | no |
| instance\_number\_of\_computed\_egress\_with\_source\_security\_group\_id | The count of computed egress security groups by ID for the cluster instances | string | `"0"` | no |
| instance\_number\_of\_computed\_ingress\_with\_cidr\_blocks | The count of computed ingress cidr blocks for the cluster instances | string | `"0"` | no |
| instance\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id | The count of computed ingress security groups by ID for the cluster instances | string | `"0"` | no |
| instance\_route53\_zone\_id | The route 53 zone ID to use for the instance DNS entries | string | n/a | yes |
| instance\_security\_groups | Attach security groups directly to the instances by their ID | list | `<list>` | no |
| instance\_subnet\_ids | An list of subnet IDs which are within the specified VPC | list | `<list>` | no |
| internal\_alb\_computed\_egress\_with\_cidr\_blocks | List of objects describing the egress cidr blocks rules permitted for the cluster albs | list | `<list>` | no |
| internal\_alb\_computed\_egress\_with\_source\_security\_group\_id | List of objects describing the inbound security group rules permitted on the albs for the cluster | list | `<list>` | no |
| internal\_alb\_computed\_ingress\_with\_cidr\_blocks | List of objects describing the ingress cidr blocks rules permitted for the loadbalancer | list | `<list>` | no |
| internal\_alb\_computed\_ingress\_with\_source\_security\_group\_id | List of objects describing the inbound security group rules permitted on the albs for the cluster albs | list | `<list>` | no |
| internal\_alb\_enabled | Whether to create an internal ALB or not | string | `"true"` | no |
| internal\_alb\_number\_of\_computed\_egress\_with\_cidr\_blocks | The count of computed egress cidr blocks for the cluster albs | string | `"0"` | no |
| internal\_alb\_number\_of\_computed\_egress\_with\_source\_security\_group\_id | The count of computed egress security groups by ID for the cluster albs | string | `"0"` | no |
| internal\_alb\_number\_of\_computed\_ingress\_with\_cidr\_blocks | The count of computed ingress cidr blocks for the cluster albs | string | `"0"` | no |
| internal\_alb\_number\_of\_computed\_ingress\_with\_source\_security\_group\_id | The count of computed ingress security groups by ID for the cluster albs | string | `"0"` | no |
| internal\_alb\_route53\_zone\_id | The route 53 zone ID to use for the ALB DNS entries | string | `""` | no |
| internal\_alb\_security\_groups | Attach security groups directly to the ALB by their ID | list | `<list>` | no |
| internal\_alb\_subnet\_ids | An list of subnet ID to attach the ELB to which are within the specified VPC | string | `""` | no |
| internal\_nlb\_enabled | Whether to create an NLB or not | string | `"false"` | no |
| internal\_nlb\_route53\_zone\_id | The route 53 zone ID to use for the NLB DNS entries | string | `""` | no |
| internal\_nlb\_subnet\_ids | An list of subnet ID to attach the ELB to which are within the specified VPC | string | `""` | no |
| owner | Product owner email address | string | n/a | yes |
| product | Product | string | n/a | yes |
| product\_family | The product family of the project, e.g. CMG FA | string | n/a | yes |
| role | Role of the product within the account | string | n/a | yes |
| ssh\_key\_name | The name of an EC2 Key Pair that can be used to SSH to the EC2 Instances in this cluster. Set to an empty string to not associate a Key Pair. | string | `""` | no |
| tags | Additional tags to add to the cluster. | list | `<list>` | no |
| vpc\_id | The ID of the VPC to launch the instances into | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| blue\_external\_alb\_dns\_name |  |
| blue\_external\_alb\_http\_tcp\_listener\_arns |  |
| blue\_external\_alb\_http\_tcp\_listener\_ids |  |
| blue\_external\_alb\_https\_listener\_arns |  |
| blue\_external\_alb\_https\_listener\_ids |  |
| blue\_external\_alb\_load\_balancer\_arn\_suffix |  |
| blue\_external\_alb\_load\_balancer\_id |  |
| blue\_external\_alb\_load\_balancer\_zone\_id |  |
| blue\_external\_alb\_security\_group\_id |  |
| blue\_external\_alb\_target\_group\_arn\_suffixes |  |
| blue\_external\_alb\_target\_group\_arns |  |
| blue\_external\_alb\_target\_group\_names |  |
| blue\_external\_nlb\_dns\_name |  |
| blue\_external\_nlb\_http\_tcp\_listener\_arns |  |
| blue\_external\_nlb\_http\_tcp\_listener\_ids |  |
| blue\_external\_nlb\_https\_listener\_arns |  |
| blue\_external\_nlb\_https\_listener\_ids |  |
| blue\_external\_nlb\_load\_balancer\_arn\_suffix |  |
| blue\_external\_nlb\_load\_balancer\_id |  |
| blue\_external\_nlb\_load\_balancer\_zone\_id |  |
| blue\_external\_nlb\_target\_group\_arn\_suffixes |  |
| blue\_external\_nlb\_target\_group\_arns |  |
| blue\_external\_nlb\_target\_group\_names |  |
| blue\_internal\_alb\_dns\_name |  |
| blue\_internal\_alb\_http\_tcp\_listener\_arns |  |
| blue\_internal\_alb\_http\_tcp\_listener\_ids |  |
| blue\_internal\_alb\_https\_listener\_arns |  |
| blue\_internal\_alb\_https\_listener\_ids |  |
| blue\_internal\_alb\_load\_balancer\_arn\_suffix |  |
| blue\_internal\_alb\_load\_balancer\_id |  |
| blue\_internal\_alb\_load\_balancer\_zone\_id |  |
| blue\_internal\_alb\_security\_group\_id |  |
| blue\_internal\_alb\_target\_group\_arn\_suffixes |  |
| blue\_internal\_alb\_target\_group\_arns |  |
| blue\_internal\_alb\_target\_group\_names |  |
| blue\_internal\_nlb\_dns\_name |  |
| blue\_internal\_nlb\_http\_tcp\_listener\_arns |  |
| blue\_internal\_nlb\_http\_tcp\_listener\_ids |  |
| blue\_internal\_nlb\_https\_listener\_arns |  |
| blue\_internal\_nlb\_https\_listener\_ids |  |
| blue\_internal\_nlb\_load\_balancer\_arn\_suffix |  |
| blue\_internal\_nlb\_load\_balancer\_id |  |
| blue\_internal\_nlb\_load\_balancer\_zone\_id |  |
| blue\_internal\_nlb\_target\_group\_arn\_suffixes |  |
| blue\_internal\_nlb\_target\_group\_arns |  |
| blue\_internal\_nlb\_target\_group\_names |  |
| cluster\_security\_group\_id |  |
| external\_alb\_weighted\_dns\_name |  |
| external\_alb\_weighted\_fqdn |  |
| external\_nlb\_weighted\_dns\_name |  |
| external\_nlb\_weighted\_fqdn |  |
| green\_external\_alb\_dns\_name |  |
| green\_external\_alb\_http\_tcp\_listener\_arns |  |
| green\_external\_alb\_http\_tcp\_listener\_ids |  |
| green\_external\_alb\_https\_listener\_arns |  |
| green\_external\_alb\_https\_listener\_ids |  |
| green\_external\_alb\_load\_balancer\_arn\_suffix |  |
| green\_external\_alb\_load\_balancer\_id |  |
| green\_external\_alb\_load\_balancer\_zone\_id |  |
| green\_external\_alb\_security\_group\_id |  |
| green\_external\_alb\_target\_group\_arn\_suffixes |  |
| green\_external\_alb\_target\_group\_arns |  |
| green\_external\_alb\_target\_group\_names |  |
| green\_external\_nlb\_dns\_name |  |
| green\_external\_nlb\_http\_tcp\_listener\_arns |  |
| green\_external\_nlb\_http\_tcp\_listener\_ids |  |
| green\_external\_nlb\_https\_listener\_arns |  |
| green\_external\_nlb\_https\_listener\_ids |  |
| green\_external\_nlb\_load\_balancer\_arn\_suffix |  |
| green\_external\_nlb\_load\_balancer\_id |  |
| green\_external\_nlb\_load\_balancer\_zone\_id |  |
| green\_external\_nlb\_target\_group\_arn\_suffixes |  |
| green\_external\_nlb\_target\_group\_arns |  |
| green\_external\_nlb\_target\_group\_names |  |
| green\_internal\_alb\_dns\_name |  |
| green\_internal\_alb\_http\_tcp\_listener\_arns |  |
| green\_internal\_alb\_http\_tcp\_listener\_ids |  |
| green\_internal\_alb\_https\_listener\_arns |  |
| green\_internal\_alb\_https\_listener\_ids |  |
| green\_internal\_alb\_load\_balancer\_arn\_suffix |  |
| green\_internal\_alb\_load\_balancer\_id |  |
| green\_internal\_alb\_load\_balancer\_zone\_id |  |
| green\_internal\_alb\_security\_group\_id |  |
| green\_internal\_alb\_target\_group\_arn\_suffixes |  |
| green\_internal\_alb\_target\_group\_arns |  |
| green\_internal\_alb\_target\_group\_names |  |
| green\_internal\_nlb\_dns\_name |  |
| green\_internal\_nlb\_http\_tcp\_listener\_arns |  |
| green\_internal\_nlb\_http\_tcp\_listener\_ids |  |
| green\_internal\_nlb\_https\_listener\_arns |  |
| green\_internal\_nlb\_https\_listener\_ids |  |
| green\_internal\_nlb\_load\_balancer\_arn\_suffix |  |
| green\_internal\_nlb\_load\_balancer\_id |  |
| green\_internal\_nlb\_load\_balancer\_zone\_id |  |
| green\_internal\_nlb\_target\_group\_arn\_suffixes |  |
| green\_internal\_nlb\_target\_group\_arns |  |
| green\_internal\_nlb\_target\_group\_names |  |
| instance\_iam\_role\_arn |  |
| instance\_security\_group\_id |  |
| internal\_alb\_weighted\_dns\_name |  |
| internal\_alb\_weighted\_fqdn |  |
| internal\_nlb\_weighted\_dns\_name |  |
| internal\_nlb\_weighted\_fqdn |  |

