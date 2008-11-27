/**
* Copyright (c) Aemon Cannon. All rights reserved.
* The use and distribution terms for this software are covered by the
* Common Public License 1.0 (http://opensource.org/licenses/cpl.php)
* which can be found in the file CPL.TXT at the root of this distribution.
* By using this software in any fashion, you are agreeing to be bound by
* the terms of this license.
* You must not remove this notice, or any other, from this software.
*/


package com.las3r.util
{

	public class StringBuffer{

		private var _pieces:Array = [];
		
		public function append(str:String):StringBuffer{
			_pieces.push(str);
			return this;
		}

		public function toString():String{
			return _pieces.join("");
		}

		public function clear():void{
			_pieces = [];
		}
		
	}

}
