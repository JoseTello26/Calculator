package com.checha.calculator;

import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class CalculatorTest {
    private Calculator calculador = new Calculator();
    @Test
    public void testSum() {
        assertEquals(5, calculador.sum(2, 3));
    }

}