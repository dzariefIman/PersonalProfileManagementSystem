import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.profile.model.ProfileBean;

@WebServlet(urlPatterns = {"/AddProfileServlet"})
public class AddProfileServlet extends HttpServlet {
    
    private static final String DB_URL = "jdbc:derby://localhost:1527/StudentProfilesDB";
    private static final String DB_USER = "APP";
    private static final String DB_PASSWORD = "APP";
    private static final String DB_DRIVER = "org.apache.derby.jdbc.ClientDriver";

  
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DB_DRIVER);
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    private boolean insertProfile(ProfileBean profile) {
        String sql = "INSERT INTO PROFILE (STUDENTID, NAME, PROGRAMME, EMAIL, HOBBIES, INTRODUCTION) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        
        System.out.println("\n=== INSERT PROFILE DEBUG ===");
        System.out.println("SQL: " + sql);
        System.out.println("Student ID: " + profile.getStudentID());
        System.out.println("Name: " + profile.getName());
        System.out.println("Programme: " + profile.getProgramme());
        System.out.println("Email: " + profile.getEmail());
        System.out.println("Hobbies: " + profile.getHobbies());
        System.out.println("Introduction: " + profile.getIntroduction());
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getStudentID());
            pstmt.setString(2, profile.getName());
            pstmt.setString(3, profile.getProgramme());
            pstmt.setString(4, profile.getEmail());
            pstmt.setString(5, profile.getHobbies());
            pstmt.setString(6, profile.getIntroduction());
            
            System.out.println("About to execute update...");
            int rowsInserted = pstmt.executeUpdate();
            System.out.println("SUCCESS! Rows inserted: " + rowsInserted);
            System.out.println("============================\n");
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("SQL ERROR: " + e.getMessage());
            System.err.println("SQL State: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            e.printStackTrace();
            System.out.println("============================\n");
            return false;
        } catch (ClassNotFoundException e) {
            System.err.println("DRIVER ERROR: " + e.getMessage());
            e.printStackTrace();
            System.out.println("============================\n");
            return false;
        }
    }

    private List<ProfileBean> getAllProfiles() {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM PROFILE";
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setStudentID(rs.getString("STUDENTID"));
                profile.setName(rs.getString("NAME"));
                profile.setProgramme(rs.getString("PROGRAMME"));
                profile.setEmail(rs.getString("EMAIL"));
                profile.setHobbies(rs.getString("HOBBIES"));
                profile.setIntroduction(rs.getString("INTRODUCTION"));
                profiles.add(profile);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return profiles;
    }

    private boolean updateProfile(ProfileBean profile) {
        String sql = "UPDATE PROFILE SET NAME = ?, PROGRAMME = ?, EMAIL = ?, "
                   + "HOBBIES = ?, INTRODUCTION = ? WHERE STUDENTID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getProgramme());
            pstmt.setString(3, profile.getEmail());
            pstmt.setString(4, profile.getHobbies());
            pstmt.setString(5, profile.getIntroduction());
            pstmt.setString(6, profile.getStudentID());
            
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }


    private boolean deleteProfile(String studentID) {
        String sql = "DELETE FROM PROFILE WHERE STUDENTID = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, studentID);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    private List<ProfileBean> searchProfiles(String searchTerm) {
        List<ProfileBean> profiles = new ArrayList<>();
        String sql = "SELECT * FROM PROFILE WHERE STUDENTID LIKE ? OR NAME LIKE ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + searchTerm + "%");
            pstmt.setString(2, "%" + searchTerm + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                ProfileBean profile = new ProfileBean();
                profile.setStudentID(rs.getString("STUDENTID"));
                profile.setName(rs.getString("NAME"));
                profile.setProgramme(rs.getString("PROGRAMME"));
                profile.setEmail(rs.getString("EMAIL"));
                profile.setHobbies(rs.getString("HOBBIES"));
                profile.setIntroduction(rs.getString("INTRODUCTION"));
                profiles.add(profile);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return profiles;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String studentID = request.getParameter("studentID");
            String programme = request.getParameter("programme");
            String email = request.getParameter("email");
            String hobbies = request.getParameter("hobbies");
            String introduction = request.getParameter("introduction");

            ProfileBean profile = new ProfileBean(studentID, name, programme, email, hobbies, introduction);
            
            boolean success = insertProfile(profile);
            
            if (success) {
                request.setAttribute("profile", profile);
                request.setAttribute("message", "Profile submitted successfully!");
            } else {
                request.setAttribute("message", "Error adding profile!");
            }
            
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        } else if ("viewAll".equals(action)) {
            List<ProfileBean> profiles = getAllProfiles();
            request.setAttribute("profiles", profiles);
            request.getRequestDispatcher("/viewProfiles.jsp").forward(request, response);
            return;
        } else if ("search".equals(action)) {
            String searchTerm = request.getParameter("searchTerm");
            
            List<ProfileBean> profiles = searchProfiles(searchTerm);
            
            if (profiles != null && !profiles.isEmpty()) {
                request.setAttribute("message", profiles.size() + " profile(s) found!");
            } else {
                request.setAttribute("message", "No profiles found matching \"" + searchTerm + "\"");
            }
            
            request.setAttribute("profiles", profiles);
            request.getRequestDispatcher("/viewProfiles.jsp").forward(request, response);
            return;
        } else if ("updateProfile".equals(action)) {
            String studentID = request.getParameter("studentID");
            String name = request.getParameter("name");
            String programme = request.getParameter("programme");
            String email = request.getParameter("email");
            String hobbies = request.getParameter("hobbies");
            String introduction = request.getParameter("introduction");
            
            ProfileBean profile = new ProfileBean(studentID, name, programme, email, hobbies, introduction);
            boolean success = updateProfile(profile);
            
            List<ProfileBean> profiles = getAllProfiles();
            request.setAttribute("profiles", profiles);
            
            if (success) {
                request.setAttribute("message", "Profile updated successfully!");
            } else {
                request.setAttribute("message", "Error updating profile!");
            }
            
            request.getRequestDispatcher("/viewProfiles.jsp").forward(request, response);
            return;
        } else if ("delete".equals(action)) {
            String studentID = request.getParameter("studentID");
            boolean success = deleteProfile(studentID);
            
            List<ProfileBean> profiles = getAllProfiles();
            request.setAttribute("profiles", profiles);
            
            if (success) {
                request.setAttribute("message", "Profile deleted successfully!");
            } else {
                request.setAttribute("message", "Profile not found or error during deletion!");
            }
            
            request.getRequestDispatcher("/viewProfiles.jsp").forward(request, response);
            return;
        }
        
        response.sendRedirect("add_profile.html");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
