package org.klawx3.klaze.service;

import org.klawx3.klaze.db.model.User;
import org.klawx3.klaze.repository.UserRepository;
import org.klawx3.klaze.security.model.SecurityUserDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MyDatabaseUserDetailService implements UserDetailsService {

    @Autowired
    UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String nickname) throws UsernameNotFoundException {
        Optional<User> user = userRepository.findByNickname(nickname);
        user.orElseThrow(() -> new UsernameNotFoundException("Nod found:" + nickname));
        return user.map(SecurityUserDetails::new).get();
    }
}
