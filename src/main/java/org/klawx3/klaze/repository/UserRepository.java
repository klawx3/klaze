package org.klawx3.klaze.repository;


import org.klawx3.klaze.db.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User,Long> {
    Optional<User> findByEmail(String email);
    Optional<User> findByNickname(String nickname);
    /*
    @Query(value = "SELECT COUNT(*) FROM user WHERE nickname = ?1 AND passwd = SHA2(?2,0)",nativeQuery = true)
    long isUserCorrect(String user,String pass);

    */
}
