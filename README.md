# Profile Management System

**Student Name:** MOHAMMED DZARIEF IMAN BIN MOHAMMED DZULHARYDY  
**Student ID:** 2025248228  
**Course:** CSC584  
**Project:** Individual Assignment 2

## Description

A web-based Profile Management System built using Java Servlet, JSP, JavaBean, JDBC, and Apache Derby database. The system allows users to add, view, search, edit, and delete student profiles in a clean and user-friendly interface.

## Features

- **Add Profile** — Submit student profile information through an HTML form
- **View Profiles** — Display all profiles in a neatly formatted table
- **Search Profile** — Search profiles by student ID or name with partial matching
- **Edit Profile** — Update profile information via an inline modal
- **Delete Profile** — Remove profile records with confirmation prompt

## Tech Stack

- **Frontend:** HTML, CSS, JSP
- **Backend:** Java Servlet, JavaBean
- **Database:** Apache Derby (JDBC)
- **Architecture:** MVC (Model-View-Controller)

## Project Structure

```
├── src/java/
│   ├── AddProfileServlet.java      (Controller)
│   └── com/profile/model/
│       └── ProfileBean.java        (Model)
├── web/
│   ├── add_profile.html            (Add Profile form)
│   ├── profile.jsp                 (Post-submit confirmation)
│   ├── viewProfiles.jsp            (View, search, edit, delete)
│   └── styles.css                  (All styling)
├── database.sql                    (Database schema)
└── README.md
```

## How to Run

1. Start Apache Derby server
2. Create the database and table using `database.sql`
3. Deploy the project to GlassFish or any Java EE servlet container
4. Access the application at `http://localhost:8080/Profile_Management_System/`

## Screenshots

*(Add screenshots here)*
