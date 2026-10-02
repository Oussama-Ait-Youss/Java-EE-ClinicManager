package com.clinicmanager.dto;

public class UserSessionDTO {
    private Long id;
    private String first_name;
    private String last_name;
    private String role;









    public UserSessionDTO(Long id,String first_name,String last_name,String role){
        this.id = id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.role = role;
    }



    //getters and setters


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

}
