package com.profile.model;

public class ProfileBean {
    
    private String studentID;
    private String name;
    private String programme;
    private String email;
    private String hobbies;
    private String introduction;
    
    public ProfileBean() {
    }
    
    public ProfileBean(String studentID, String name, String programme, 
                       String email, String hobbies, String introduction) {
        this.studentID = studentID;
        this.name = name;
        this.programme = programme;
        this.email = email;
        this.hobbies = hobbies;
        this.introduction = introduction;
    }
        
    public String getStudentID() {
        return studentID;
    }
    
    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getProgramme() {
        return programme;
    }
    
    public void setProgramme(String programme) {
        this.programme = programme;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getHobbies() {
        return hobbies;
    }
    
    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }
    
    public String getIntroduction() {
        return introduction;
    }
    
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
}
