package com.clinicmanager.exception;

public class AccountInactiveException extends RuntimeException{
    public AccountInactiveException(String message){
        super(message);
    }
}
