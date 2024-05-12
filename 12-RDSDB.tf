module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb"

  engine            = "mysql"
  engine_version    = "5.7.37"  
  instance_class    = "db.m5.large"  
  
  allocated_storage = 20  

  db_name   = "demodb"
  username  = "user"
  password  = "your-password-here"  
  port      = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [aws_security_group.app1-80-sg01-servers.id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "The_Architect_Was_Here"
    Environment = "dev"
  }

  # Ensure these subnet IDs are correct and exist in your AWS account
  create_db_subnet_group = true
  subnet_ids             = ["subnet-0913c084b6a322151", "subnet-05073a73d54746a9e"]

  family = "mysql5.7"

  major_engine_version = "5.7"

  deletion_protection = false #Deletion protection is usu. set to true for security.
                              #However I have disabled it as it makes the tear down process easier

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}
 