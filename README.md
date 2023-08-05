
# Wordpress on ECS

Practical example on how to get a Wordpress running under an Amazon ECS Cluster using different technologies.

## Technologies

* [Wordpress](https://wordpress.org/)
* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io/)
* [Amazon ECS](https://aws.amazon.com/ecs/)
* [Amazon RDS](https://aws.amazon.com/es/rds/)

## Requirements

To use this example you will need an [AWS](https://aws.amazon.com/es/) account and:

* [Terraform](https://www.terraform.io/downloads.html)
* [Docker](https://docs.docker.com/engine/installation/)

## Usage

1. Deploy all the infrastructure needed on AWS using Terraform.

```
# terraform apply
```

Once deployed, Terraform will display the ECS Container Instances public IPs and the [ELB](https://aws.amazon.com/es/elasticloadbalancing/) URL that will distribute the traffic across the different Wordpress container instances.

The RDS connection parameters will be passed on runtime to the Wordpress containers via environment variables.

4. Once not needed, we can remove all the AWS infrastructure:


```
# terraform destroy
```

## Considerations

This example uses a basic and simple approach to get a ready to use Wordpress using different technology. Further modifications will be done to get a fully automated, scalable and high available Wordpress.
