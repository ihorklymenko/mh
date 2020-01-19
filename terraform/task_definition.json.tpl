[
  {
    "name": "${APPLICATION}",
    "image": "httpd:2.4",
    "networkMode": "awsvpc",
    "essential": true,
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${LOGS_GROUP}",
          "awslogs-region": "${AWS_REGION}",
          "awslogs-stream-prefix": "ecs"
        }
    },
    "command": [
        "/bin/sh -c \"echo '<html> <head> <title>Sample Application for MH Test</title> <style>body {margin-top: 40px; background-color: #333;} </style> </head><body> <div style=color:white;text-align:center> <h1>Sample Application for MH Test</h1> <h2>Hello World!</h2> <p>Application is nicefully hosted on a container in Amazon ECS.</p> </div></body></html>' >  /usr/local/apache2/htdocs/index.html && httpd-foreground\""
    ],
    "entryPoint": [
        "sh",
        "-c"
    ],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
