package com.example;

// This is available because of the BUILD dep we set up.
// It is part of GUAVA.
import com.google.common.collect.ImmutableList;

public class Greeting {
    public static void sayHi() {
        ImmutableList<String> list = ImmutableList.<String>builder()
            .add("Hello")
            .add("World")
            .build();

        System.out.println(list);
    }
}
