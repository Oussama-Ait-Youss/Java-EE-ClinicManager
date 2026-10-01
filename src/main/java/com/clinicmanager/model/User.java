package com.clinicmanager.model;


import com.clinicmanager.model.enums.Gender;
import jakarta.persistence.*;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table (name = "users")
public class User {
    @Id
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long id;

    @Column (name = "first_name", nullable = false, length = 255)
    private String first_name;

    @Column (name = "last_name", nullable = false, length = 255)
    private String last_name;


    @Column (name = "phone", nullable = false, length = 255)
    private String phone;

    @Column (name = "email", unique = true,nullable = false, length = 255)
    private String email;

    @Enumerated (EnumType.STRING)
    @Column (name = "gender")
    private Gender gender;

    @Column (name = "active")
    private boolean active;

    @Column (name = "password")
    private String password;




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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
