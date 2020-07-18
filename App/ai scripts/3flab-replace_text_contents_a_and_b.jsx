/*
3flab-replace_text_contents_a_and_b.jsx

Date Created: 2014/04/20
Date Modified: 2015/11/13
Version: 1.0

Copyright (c) 2015 Seiji Miyazawa @3flab inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>
*/

//2015/04/08

if (documents.length > 0){
	var sels = app.activeDocument.selection;
	if (sels.length > 0 && sels.typename != "TextRange"){
		var selItems = [];
		for(var i = 0; i < sels.length; i++){
			check(sels[i]);
		}
		if (selItems.length == 2 && selItems[0].typename == "TextFrame" && selItems[1].typename == "TextFrame"){
			var textA = selItems[0].textRange.contents;
			var textB = selItems[1].textRange.contents;
				selItems[0].textRange.contents = textB;
				selItems[1].textRange.contents = textA;
		}
	}
}

function check(item){
	if (item.typename == "TextFrame"){
		selItems.push(item);
	} else if (item.typename == "GroupItem"){
		for (var i = item.pageItems.length-1; i >= 0; i--){
			var childitem = item.pageItems[i];
			check(childitem);
		}
	}
}