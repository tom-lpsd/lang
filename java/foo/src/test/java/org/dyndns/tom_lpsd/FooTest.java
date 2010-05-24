package org.dyndns.tom_lpsd;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class FooTest 
    extends TestCase
{
    /**
     * Create the test case
     *
     * @param testName name of the test case
     */
    public FooTest( String testName )
    {
        super( testName );
    }

    /**
     * @return the suite of tests being tested
     */
    public static Test suite()
    {
        return new TestSuite( FooTest.class );
    }

    /**
     * Rigourous Test :-)
     */
    public void testFoo()
    {
	Foo f = new Foo();
	assertEquals(0, f.getX());
    }
}
