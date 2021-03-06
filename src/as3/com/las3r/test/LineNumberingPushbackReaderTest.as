/**
* Copyright (c) Aemon Cannon. All rights reserved.
* The use and distribution terms for this software are covered by the
* Common Public License 1.0 (http://opensource.org/licenses/cpl.php)
* which can be found in the file CPL.TXT at the root of this distribution.
* By using this software in any fashion, you are agreeing to be bound by
* the terms of this license.
* You must not remove this notice, or any other, from this software.
*/


package com.las3r.test{
	import flexunit.framework.TestCase;
 	import flexunit.framework.TestSuite;
	import flash.utils.*;
	import com.las3r.jdk.io.StringReader;
	import com.las3r.io.LineNumberingPushbackReader;

	public class LineNumberingPushbackReaderTest extends RichTestCase {
		
		override public function setUp():void {
		}
		
		override public function tearDown():void {
		}

		public function testCreate():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("hello"));
		}


		public function testReadStringWithNewline():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("a\nb"));
			assertTrue("first character should be a 'a'", String.fromCharCode(s.readOne()) == "a");
			assertTrue("next character should be '\\n'", String.fromCharCode(s.readOne()) == "\n");
			assertTrue("next character should be 'b'", String.fromCharCode(s.readOne()) == "b");
			assertTrue("next character should be -1", s.readOne() == -1);
		}


		public function testReadingStringWithNewlinesCheckingLineNumbers():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("a\nb"));
			assertTrue("should be on line 1 now", s.getLineNumber() == 1);
			s.readOne();
			assertTrue("should be on line 1 now", s.getLineNumber() == 1);
			s.readOne();
			assertTrue("should be on line 2 now", s.getLineNumber() == 2);
			s.readOne();
			assertTrue("should be on line 2 now", s.getLineNumber() == 2);
			s.readOne(); // -1
			assertTrue("should be on line 2 now", s.getLineNumber() == 2);
		}


		public function testReadingStringWithCarriageReturnsAndNewlinesCheckingLineNumbers():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("a\r\nb"));
			assertTrue("should be on line 1 now", s.getLineNumber() == 1);
			s.readOne();//a
			assertTrue("should be on line 1 now", s.getLineNumber() == 1);
			s.readOne();//\r\n Reads both.
			assertTrue("should be on line 2 now", s.getLineNumber() == 2);
			s.readOne();//\b
			assertTrue("should be on line 2 now", s.getLineNumber() == 2);
			s.readOne(); // -1
			assertTrue("should be on line 2 now", s.getLineNumber() == 2);
		}


		public function testReadQuotedStringCharByChar():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("\"hello\""));
			assertTrue("first character should be '\"'", String.fromCharCode(s.readOne()) == "\"");
			assertTrue("next character should be 'h'", String.fromCharCode(s.readOne()) == "h");
			assertTrue("next character should be 'e'", String.fromCharCode(s.readOne()) == "e");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'o'", String.fromCharCode(s.readOne()) == "o");
			assertTrue("next character should be '\"'", String.fromCharCode(s.readOne()) == "\"");
			assertTrue("next character should be -1", s.readOne() == -1);
		}

		public function testReadStringCharByChar():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("hello"));
			assertTrue("first character should be 'h'", String.fromCharCode(s.readOne()) == "h");
			assertTrue("next character should be 'e'", String.fromCharCode(s.readOne()) == "e");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'o'", String.fromCharCode(s.readOne()) == "o");
			assertTrue("next character should be -1", s.readOne() == -1);
		}


		public function testReadStringIntoArray():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("hello"));
			var a:Array = new Array(20);
			assertTrue("return value should be 5", s.readIntoArray(a) == 5);
			assertTrue("first character should be 'h'",String.fromCharCode(a[0]) == "h");
			assertTrue("next character should be 'e'", String.fromCharCode(a[1]) == "e");
			assertTrue("next character should be 'l'", String.fromCharCode(a[2]) == "l");
			assertTrue("next character should be 'l'", String.fromCharCode(a[3]) == "l");
			assertTrue("next character should be 'o'", String.fromCharCode(a[4]) == "o");
			assertTrue("next character should be null", !a[5]);
			assertTrue("return value should be -1", s.readIntoArray(a) == -1);
		}

		public function testSkip():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("hello"));
			assertTrue("first character should be 'h'", String.fromCharCode(s.readOne()) == "h");
			assertTrue("should return 1, one char skipped", s.skip(1) == 1);			
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("should return 2, two chars skipped", s.skip(2) == 2);
			assertTrue("next character should be -1", s.readOne() == -1);
		}

		public function testUnreadingOneCharacter():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("hello"));
			assertTrue("first character should be 'h'", String.fromCharCode(s.readOne()) == "h");
			var c:int = s.readOne();
			assertTrue("next character should be 'e'", String.fromCharCode(c) == "e");
			s.unread(c);
			assertTrue("next character should be 'e'", String.fromCharCode(s.readOne()) == "e");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'o'", String.fromCharCode(s.readOne()) == "o");
			assertTrue("next character should be -1", s.readOne() == -1);
		}

		public function testUnreadingArrayOfChars():void{
			var s:LineNumberingPushbackReader = new LineNumberingPushbackReader(new StringReader("hello"), 2);
			assertTrue("first character should be 'h'", String.fromCharCode(s.readOne()) == "h");
			var a:int = s.readOne();
			var b:int = s.readOne();
			s.unreadArray([a,b]);
			assertTrue("next character should be 'e'", String.fromCharCode(s.readOne()) == "e");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'l'", String.fromCharCode(s.readOne()) == "l");
			assertTrue("next character should be 'o'", String.fromCharCode(s.readOne()) == "o");
			assertTrue("next character should be -1", s.readOne() == -1);
		}


	}

}