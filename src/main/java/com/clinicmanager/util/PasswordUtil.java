package com.clinicmanager.util;

import org.mindrot.jbcrypt.BCrypt;

import java.util.Optional;

public class PasswordUtil {

    // method to hash the password
    public static String hashPassword(Optional<String> passwordText) {

        if (passwordText.isEmpty() || passwordText.get().isBlank()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }

        return BCrypt.hashpw(passwordText.get(), BCrypt.gensalt(12));
    }




    //method ot verfiy the password wi the hash one
    public static boolean verifyPassword(
            Optional<String> passwordText,
            String hashedPassword
    ) {

        if (passwordText.isEmpty() || passwordText.get().isBlank()) {
            return false;
        }

        if (hashedPassword == null || hashedPassword.isBlank()) {
            return false;
        }

        return BCrypt.checkpw(passwordText.get(), hashedPassword);
    }
}