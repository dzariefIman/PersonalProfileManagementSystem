<%@ page import="com.profile.model.ProfileBean" %>
<%
    ProfileBean profile = (ProfileBean) request.getAttribute("profile");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Submitted</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <aside class="sidebar">
        <div class="sidebar-header">
            <h1><i class="fas fa-user-circle"></i> Profile Manager</h1>
        </div>
        <nav class="sidebar-nav">
            <a href="add_profile.html" class="sidebar-link">
                <i class="fas fa-plus"></i> Add Profile
            </a>
            <a href="AddProfileServlet?action=viewAll" class="sidebar-link">
                <i class="fas fa-list"></i> View Profiles
            </a>
        </nav>
    </aside>

    <main class="main-content">
        <div class="page-header">
            <h1><i class="fas fa-check-circle"></i> Profile Submission</h1>
        </div>

        <% if (message != null) { %>
            <div class="message <%= message.contains("Error") ? "error" : "success" %>">
                <i class="fas <%= message.contains("Error") ? "fa-exclamation-circle" : "fa-check-circle" %>"></i>
                <%= message %>
            </div>
        <% } %>

        <% if (profile != null) { %>
            <div class="profiles-table">
                <table>
                    <thead>
                        <tr>
                            <th>Field</th>
                            <th>Value</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Student ID</strong></td>
                            <td><%= profile.getStudentID() %></td>
                        </tr>
                        <tr>
                            <td><strong>Name</strong></td>
                            <td><%= profile.getName() %></td>
                        </tr>
                        <tr>
                            <td><strong>Programme</strong></td>
                            <td><%= profile.getProgramme() %></td>
                        </tr>
                        <tr>
                            <td><strong>Email</strong></td>
                            <td><a href="mailto:<%= profile.getEmail() %>"><%= profile.getEmail() %></a></td>
                        </tr>
                        <tr>
                            <td><strong>Hobbies</strong></td>
                            <td><%= profile.getHobbies() %></td>
                        </tr>
                        <tr>
                            <td><strong>Introduction</strong></td>
                            <td><%= profile.getIntroduction() %></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div style="margin-top: 2rem; display: flex; gap: 1rem;">
                <a href="add_profile.html" class="btn btn-primary">
                    <i class="fas fa-plus-circle"></i> Add Another Profile
                </a>
                <a href="AddProfileServlet?action=viewAll" class="btn btn-secondary">
                    <i class="fas fa-list"></i> View All Profiles
                </a>
            </div>
        <% } else { %>
            <div class="no-profiles">
                <i class="fas fa-inbox"></i>
                <h2>No Profile</h2>
                <p>No profile information is available.</p>
                <a href="add_profile.html" class="btn btn-primary">
                    <i class="fas fa-user-plus"></i> Create New Profile
                </a>
            </div>
        <% } %>
    </main>
</body>
</html>