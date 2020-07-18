/*************************************************
JavaScript for Illustrator CS2 ( Win / Mac )

■■入れ替え■■

選択した二つのオブジェクトの座標と重ね順を
入れ替える

作成者：倉田タカシ                      2005_02_24
*************************************************/


thisObj = activeDocument.selection ;
if( thisObj.length < 2 )
{
	alert("二つのオブジェクトを選んでください。");
}
else
{
	flg = confirm("二つの位置（座標）も入れ替えますか？");
	posA = thisObj[0].position ;
	posB = thisObj[1].position ;
	mA = thisObj[0].clipping ;
	mB = thisObj[1].clipping ;
	cObj = thisObj[0].duplicate() ;
	cObj.moveBefore(thisObj[1]) ;
	thisObj[1].moveBefore(thisObj[0]) ;
	if(flg)
	{
		cObj.position = posB ;
		thisObj[1].position = posA ;
	}
	thisObj[0].remove() ;
	
	
	//以降はマスク入れ替えの場合の処理（両方がマスクの場合にも対応）
	if( mA || mB ) 
	{
		cObj.clipping = mB ;
		thisObj[1].clipping = mA ;
	
		cS = cObj.stroked ;
		cSC = cObj.strokeColor ;
		cSW = cObj.strokeWidth ;
		
		cObj.stroked = thisObj[1].stroked ;
		cObj.strokeColor = thisObj[1].strokeColor ;
		cObj.strokeWidth = thisObj[1].strokeWidth ;
		
		thisObj[1].stroked = cS ;
		thisObj[1].strokeColor = cSC ;
		thisObj[1].strokeWidth = cSW ;
	}
}