swagger: "2.0"
info:
  title: "My API"
  description: "API documentation"
  version: "1.0.0"
host: "localhost:3000"
basePath: "/"
schemes:
  - "http"
paths:
  /api/teams:
    get:
      summary: "Returns all teams"
      responses:
        200:
          description: "A list of teams"
