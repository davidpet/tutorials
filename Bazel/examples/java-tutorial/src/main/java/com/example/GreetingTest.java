package com.example;

// Bazel makes these automatically available without any
// specified dependencies.

import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

import java.util.Optional;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

// Technically, the idiomatic Java way is to put the tests
// in their own folder with parallel structure, but coming
// from Angular world, I find this way nicer to deal with.

public class GreetingTest {
  @Mock Greeting.Printer printer;

  @Before
  public void setup() {
    MockitoAnnotations.openMocks(this);
  }

  @Test
  public void testSomething() {
    Greeting.sayHi(Optional.of(printer));

    verify(printer, times(1)).print("[Hello, World]");
  }
}
