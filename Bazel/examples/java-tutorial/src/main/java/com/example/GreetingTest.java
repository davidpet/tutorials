package com.example;

// Bazel makes these automatically available without any
// specified dependencies.
import org.junit.Test;
import static org.junit.Assert.*;

// Technically, the idiomatic Java way is to put the tests
// in their own folder with parallel structure, but coming
// from Angular world, I find this way nicer to deal with.

public class GreetingTest {
    @Test
    public void testSomething() {
        Greeting.sayHi();
        
        assertTrue(true);
    }
}
