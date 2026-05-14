package model;

public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private String role;   // ⭐ ADD THIS

    public User() {}

    public User(String name, String email, String password) {
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // ⭐ ROLE (THIS FIXES YOUR ERROR)
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}