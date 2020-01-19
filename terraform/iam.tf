data "aws_iam_policy_document" "ecs_task_assume" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "ecs_task" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.project}-${var.environment}-${var.application}-iam-policy"
  policy = data.aws_iam_policy_document.ecs_task.json
}

resource "aws_iam_role" "this" {
  name               = "${var.project}-${var.environment}-${var.application}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
