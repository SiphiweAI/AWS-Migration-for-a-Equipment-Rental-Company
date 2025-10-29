resource "aws_sqs_queue" "bookings" {
  name = "${var.project_name}-bookings"
}
