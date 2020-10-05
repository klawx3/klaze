package org.klawx3.klaze.db.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "user",uniqueConstraints = @UniqueConstraint(columnNames = "nickname"))
public class User implements Serializable {

    @Id
    @Column(name="id")
    @GeneratedValue
    private long id;

    @Column(name="nickname")
    private String nickname;

    @Column(name="fullname")
    private String fullname;

    @Column(name="email")
    private String email;

    @Column(name="passwd")
    private String passwd;

    @ManyToOne(targetEntity = UserType.class)
    @JoinColumn(name="user_type_id_fk")
    private UserType userType;

    public User(long id, String nickname, String fullname, String email, String passwd, UserType userType) {
        this.id = id;
        this.nickname = nickname;
        this.fullname = fullname;
        this.email = email;
        this.passwd = passwd;
        this.userType = userType;
    }

    public User() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", nickname='" + nickname + '\'' +
                ", fullname='" + fullname + '\'' +
                ", email='" + email + '\'' +
                ", passwd='" + passwd + '\'' +
                ", userType=" + userType +
                '}';
    }
}
