<<<<<<< HEAD
# ror_exp
=======
# README

This README would normally document whatever steps are necessary to get the
application up and running.

**Clone the repository**
  https://github.com/Rutvi-Joshi/ror_exp.git

* Ruby version
3.2.2

* System dependencies
gem install bundler


* Configuration

* Database creation
psql (PostgreSQL) 14.13

* Database initialization
rails db:create


### API Documentation

#### Authentication Endpoints

- **POST /signup** -- http://localhost:3000/users
  - Registers a new user.
  - **Request Body:** `{
  "user": {
    "email": "kmac@example.com",
    "password": "password@123",
    "password_confirmation": "password@123"  }
}`
  - **Response:** {
    "message": "Signed up successfully.",
    "user": {
        "id": 17,
        "email": "kia@example.com",
        "created_at": "2024-11-10T09:00:40.935Z",
        "updated_at": "2024-11-10T09:00:40.935Z"
    }
}

- **POST /login** --http://localhost:3000/users/sign_in
  - Logs in a user and returns a JWT.
  - **Request Body:** `{
  "user": {
    "email": "kmac@example.com",
    "password": "password@123"
  }
}`
  - **Response:** `{
    "status": 200,
    "success": true,
    "message": "SignIn successfully.",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ0aW1lc3RhbXAiOiIyMDI0LTExLTEwIDE0OjMxOjEyICswNTMwIiwiZW1haWwiOiJrbWFjQGV4YW1wbGUuY29tIn0.uMsyuGp1xcmEoC2xqUbLFgwGeg96mgYA0OgkMkH_H2g"
}`

#### Team Endpoints

- **POST /teams** --http://localhost:3000/teams
  - Creates a new team (authenticated users only).
  - **Request Headers:** `Authorization: Bearer <JWT token>`
  - **Request Body:** `{ "name": "Team Name", description: "Team description" }`
  - **Response:** `{
    "status": 201,
    "success": true,
    "message": "Team created successfully",
    "data": {
        "id": 4,
        "name": "Mac Team",
        "description": "NEW DESC",
        "owner_id": 17,
        "created_at": "2024-11-10T09:02:03.606Z",
        "updated_at": "2024-11-10T09:02:03.606Z"
    }
}`

- **POST /teams/:id/members**  -- http://localhost:3000/teams/4/memberships
  - Adds a user to a team.
  - **Request Body:** `{ "user_id": 16 }`
  - **Response:** `{
    "status": 201,
    "success": true,
    "message": "Team member added",
    "data": [
        {
            "id": 16,
            "email": "opll@example.com",
            "created_at": "2024-11-10T08:59:52.713Z",
            "updated_at": "2024-11-10T08:59:52.713Z"
        },
        {
            "id": 15,
            "email": "uj@example.com",
            "created_at": "2024-11-10T08:52:57.538Z",
            "updated_at": "2024-11-10T08:52:57.538Z"
        }
    ]
}`


### Database Schema

- **users**
  - `id`: integer, primary key
  - `email`: string, unique, required
  - `encrypted_password`: string, required
  - `created_at`, `updated_at`: timestamps

- **teams**
  - `id`: integer, primary key
  - `name`: string, required
  - `created_at`, `updated_at`: timestamps

- **team_memberships**
  - `id`: integer, primary key
  - `user_id`: integer, foreign key
  - `team_id`: integer, foreign key
  - `created_at`, `updated_at`: timestamps