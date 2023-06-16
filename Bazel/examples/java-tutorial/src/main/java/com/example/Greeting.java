package com.example;

// This is available because of the BUILD dep we set up.
// It is part of GUAVA.
import com.google.common.collect.ImmutableList;

public class Greeting {
    public static void sayHi() {
        // This line won't compile in Java 8 but will compile in Java 11.
        var x = 5;

        ImmutableList<String> list = ImmutableList.<String>builder()
            .add("Hello")
            .add("World")
            .build();

        System.out.println(list);
        System.out.println(x);
    }
}
