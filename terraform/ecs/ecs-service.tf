resource "aws_ecs_service" "vod_service" {
  name            = "vod-service"
  cluster         = aws_ecs_cluster.main.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.vod_task.arn
  desired_count   = 2
  network_configuration {
    subnets         = [aws_subnet.public.id]
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.vod_tg.arn
    container_name   = "vod-service"
    container_port   = 80
  }
}