/**
* Copyright (c) Aemon Cannon. All rights reserved.
* The use and distribution terms for this software are covered by the
* Common Public License 1.0 (http://opensource.org/licenses/cpl.php)
* which can be found in the file CPL.TXT at the root of this distribution.
* By using this software in any fashion, you are agreeing to be bound by
* the terms of this license.
* You must not remove this notice, or any other, from this software.
*/

package com.las3r.runtime{

	import com.las3r.jdk.io.PushbackReader;
	import flash.utils.*;


	public class ReaderEvalUnit extends EvalUnit{

		protected var _src:PushbackReader;
		public function get reader():PushbackReader { return _src }
		
		public function ReaderEvalUnit(src:PushbackReader, finishedCallback:Function, errorCallback:Function, formCallback:Function){
			super(finishedCallback, errorCallback, formCallback);
			_src = src;
		}
		
	}

}