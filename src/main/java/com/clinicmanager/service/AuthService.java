package com.clinicmanager.service;

import com.clinicmanager.dto.LoginRequestDTO;
import com.clinicmanager.dto.UserSessionDTO;
import com.clinicmanager.exception.AccountInactiveException;
import com.clinicmanager.exception.InvalidCredentialsException;
import com.clinicmanager.model.User;
import com.clinicmanager.repository.UserRepository;
import com.clinicmanager.repository.ImplRepository.ImplUserRepository;
import com.clinicmanager.util.PasswordUtil;

import java.util.Optional;

public class AuthService {

    private final UserRepository userRepository;

    public AuthService() {
        this.userRepository = new ImplUserRepository();
    }

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserSessionDTO login(LoginRequestDTO dto) {
        if (dto == null || dto.getEmail() == null || dto.getPassword() == null
                || dto.getEmail().isBlank() || dto.getPassword().isBlank()) {
            throw new InvalidCredentialsException("Email and password are required.");
        }

        User user = userRepository.findByEmail(dto.getEmail().trim().toLowerCase())
                .orElseThrow(() -> new InvalidCredentialsException("Invalid credentials."));

        if (!user.isActive()) {
            throw new AccountInactiveException("Account is disabled. Please contact the administrator.");
        }
        Optional<String> password = dto.getPassword().describeConstable();

        if (!PasswordUtil.verifyPassword(password, user.getPassword())) {
            throw new InvalidCredentialsException("Invalid credentials.");
        }

        String fullName = user.getFirst_name() + " " + user.getLast_name();

        return new UserSessionDTO(
                user.getId(),
                user.getEmail(),
                fullName,
                user.getRole()
        );
    }
}