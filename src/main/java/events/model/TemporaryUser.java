package events.model;

import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

public class TemporaryUser {
    private Integer id;

    @NotNull
    private String name;

    @NotNull
    private String password;

    @NotNull @Email
    private String email;

    private String type;

    private Boolean registered;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Boolean getRegistered() {
        return registered;
    }

    public void setRegistered(Boolean registered) {
        this.registered = registered;
    }

    public User toUser(){
        User user = new User();
        user.setName(name);
        user.setPassword(password);
        user.setType(type);
        user.setEmail(email);
        return user;
    }
}
