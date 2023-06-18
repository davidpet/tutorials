package com.example;

// This is available because of the BUILD dep we set up.
// It is part of GUAVA.

import com.google.common.collect.ImmutableList;
import com.google.errorprone.annotations.CompileTimeConstant;
import java.util.Optional;

public class Greeting {
  public static void testMethod(@CompileTimeConstant String s) {
    System.out.println(s);
  }

  public static void sayHi(Optional<Printer> printer) {
    Printer printerInstance = printer.orElse(new Greeting.Printer());

    ImmutableList<String> list = ImmutableList.<String>builder().add("Hello").add("World").build();

    printerInstance.print(list.toString());

    // String runtimeString = "Not a compile time constant";
    testMethod("Compile time constant"); // This line should cause Error Prone to fail
  }

  public static class Printer {
    void print(String message) {
      System.out.println(message);
    }
  }
}
