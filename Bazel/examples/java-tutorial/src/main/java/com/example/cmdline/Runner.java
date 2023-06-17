package com.example.cmdline;

import com.example.Greeting;

import java.util.Optional;

public class Runner {
    public static void main(String args[]) {
        Greeting.sayHi(Optional.empty());
    }
}
