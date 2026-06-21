<%@ page import="com.profile.model.ProfileBean" %>
<%@ page import="java.util.List" %>
<%
    List<ProfileBean> profiles = (List<ProfileBean>) request.getAttribute("profiles");
    String message = (String) request.getAttribute("message");
    if (profiles == null) {
        response.sendRedirect("AddProfileServlet?action=viewAll");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Profiles</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h1><i class="fas fa-user-circle"></i> Profile Manager</h1>
        </div>
        <nav class="sidebar-nav">
            <a href="add_profile.html" class="sidebar-link">
                <i class="fas fa-plus"></i> Add Profile
            </a>
            <a href="AddProfileServlet?action=viewAll" class="sidebar-link active">
                <i class="fas fa-list"></i> View Profiles
            </a>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <div class="page-header">
            <h1><i class="fas fa-list-ul"></i> All Profiles</h1>
        </div>

        <% if (message != null) { %>
            <div class="message <%= message.contains("Error") ? "error" : "success" %>">
                <%= message %>
            </div>
        <% } %>

        <!-- Search Section -->
        <div class="search-section">
            <form action="AddProfileServlet" method="POST" class="search-box">
                <input type="hidden" name="action" value="search">
                <input type="text" name="searchTerm" placeholder="Search by Student ID or Name...">
                <button type="submit"><i class="fas fa-search"></i> Search</button>
            </form>
        </div>

        <!-- Profiles Table -->
        <% if (profiles != null && profiles.size() > 0) { %>
            <div class="profiles-table">
                <table>
                    <thead>
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Programme</th>
                            <th>Email</th>
                            <th>Hobbies</th>
                            <th>Introduction</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ProfileBean profile : profiles) { %>
                            <tr>
                                <td><strong><%= profile.getStudentID() %></strong></td>
                                <td><%= profile.getName() %></td>
                                <td><%= profile.getProgramme() %></td>
                                <td><a href="mailto:<%= profile.getEmail() %>"><%= profile.getEmail() %></a></td>
                                <td><%= profile.getHobbies() %></td>
                                <td><%= profile.getIntroduction() %></td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn edit-btn"
                                            data-studentid="<%= profile.getStudentID().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            data-name="<%= profile.getName().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            data-programme="<%= profile.getProgramme().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            data-email="<%= profile.getEmail().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            data-hobbies="<%= profile.getHobbies().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            data-introduction="<%= profile.getIntroduction().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            onclick="openEditModal(this)">
                                            <i class="fas fa-edit"></i> Edit
                                        </button>
                                        <button class="action-btn delete-btn"
                                            data-studentid="<%= profile.getStudentID().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            data-name="<%= profile.getName().replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;").replace("\n", " ") %>"
                                            onclick="openDeleteModal(this)">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="no-profiles">
                <i class="fas fa-inbox"></i>
                <h2>No Profiles Found</h2>
                <p>There are no student profiles in the database yet.</p>
                <a href="add_profile.html" class="btn btn-primary">Add First Profile</a>
            </div>
        <% } %>
    </main>

    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Profile</h2>
                <button class="close-btn" onclick="closeEditModal()">&times;</button>
            </div>
            <form action="AddProfileServlet" method="POST">
                <input type="hidden" name="action" value="updateProfile">
                <input type="hidden" id="editStudentID" name="studentID">

                <div class="form-group">
                    <label><i class="fas fa-id-card"></i> Student ID</label>
                    <input type="text" id="editStudentIDDisplay" disabled>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-user"></i> Name</label>
                    <input type="text" id="editName" name="name" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-book"></i> Programme</label>
                    <input type="text" id="editProgramme" name="programme" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email</label>
                    <input type="email" id="editEmail" name="email" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-heart"></i> Hobbies</label>
                    <input type="text" id="editHobbies" name="hobbies" required>
                </div>

                <div class="form-group">
                    <label><i class="fas fa-comment"></i> Introduction</label>
                    <textarea id="editIntroduction" name="introduction" rows="4" required></textarea>
                </div>

                <div class="modal-actions">
                    <button type="button" class="cancel-btn" onclick="closeEditModal()">Cancel</button>
                    <button type="submit" class="save-btn">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Delete Profile</h2>
                <button class="close-btn" onclick="closeDeleteModal()">&times;</button>
            </div>
            <div class="delete-confirm">
                <p><i class="fas fa-exclamation-triangle warning-icon"></i></p>
                <p>Are you sure you want to delete the profile for:</p>
                <p><strong id="deleteProfileName"></strong></p>
                <p class="hint">This action cannot be undone.</p>
            </div>
            <div class="modal-actions">
                <button class="cancel-btn" onclick="closeDeleteModal()">Cancel</button>
                <form action="AddProfileServlet" method="POST" class="form-inline">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" id="deleteStudentID" name="studentID">
                    <button type="submit" class="action-btn delete-btn">Delete Profile</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openEditModal(btn) {
            document.getElementById('editStudentID').value = btn.dataset.studentid;
            document.getElementById('editStudentIDDisplay').value = btn.dataset.studentid;
            document.getElementById('editName').value = btn.dataset.name;
            document.getElementById('editProgramme').value = btn.dataset.programme;
            document.getElementById('editEmail').value = btn.dataset.email;
            document.getElementById('editHobbies').value = btn.dataset.hobbies;
            document.getElementById('editIntroduction').value = btn.dataset.introduction;
            document.getElementById('editModal').classList.add('show');
        }

        function closeEditModal() {
            document.getElementById('editModal').classList.remove('show');
        }

        function openDeleteModal(btn) {
            document.getElementById('deleteStudentID').value = btn.dataset.studentid;
            document.getElementById('deleteProfileName').textContent = btn.dataset.name;
            document.getElementById('deleteModal').classList.add('show');
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.remove('show');
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            var editModal = document.getElementById('editModal');
            var deleteModal = document.getElementById('deleteModal');
            if (event.target == editModal) {
                closeEditModal();
            }
            if (event.target == deleteModal) {
                closeDeleteModal();
            }
        }
    </script>
</body>
</html>
