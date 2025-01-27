resource "aws_cloudwatch_dashboard" "asg_dashboard" {
  dashboard_name = "${var.environment}-asg-dashboard"
  dashboard_body = <<EOT
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [ "AWS/EC2", "CPUUtilization", "AutoScalingGroupName", "${var.asg_name}" ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "${var.region}",
        "title": "CPU Utilization"
      }
    }
  ]
}
EOT
}
