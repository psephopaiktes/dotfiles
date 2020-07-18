/*
3flab-remove_selected_handle.jsx

Date Created: 2014/02/05
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

if (documents.length > 0){
	var sels = app.activeDocument.selection;
	if (sels.length > 0 && sels.typename != "TextRange"){
		for (var i = 0; i < sels.length; i++){
			action(sels[i]);
		}
	}
}
function action(item){ //グループ内のテキストを探しまくる
	if (item.typename == "PathItem"){
		var points = item.pathPoints;
		for (var p = 0; p < points.length; p++){
			var anchor = points[p].anchor;
			var leftD = points[p].leftDirection;
			var rightD = points[p].rightDirection;
			
			if (points[p].selected == PathPointSelection.ANCHORPOINT){
				points[p].leftDirection = points[p].rightDirection = anchor;
			} else if (points[p].selected == PathPointSelection.LEFTDIRECTION){
				points[p].leftDirection = anchor;
			} else if (points[p].selected == PathPointSelection.RIGHTDIRECTION){
				points[p].rightDirection = anchor;
			}
		}
	} else if (item.typename == "CompoundPathItem"){
		for (var j = 0; j < item.pathItems.length; j++){
			var childitem = item.pathItems[j];
			action(childitem);
		}
	}
}