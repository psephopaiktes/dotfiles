/*************************************************
JavaScript for Illustrator CS2 ( Win / Mac )

■■レイヤー自動リネーム■■


作成者：倉田タカシ                      2006_05_23
*************************************************/

//////必要に応じてここを書き換えてください////////

var numMarker = "[num]" ;	//通し番号指定の識別文字
var jsMarker = "[js]" ;
var tNamesMarker = "tNames" ;
var subMarker = "	" ;		//サブレイヤー指定の識別文字
var printMarker = "" ;		//印刷禁止指定の識別文字
var templateMarker = "" ;	//テンプレートレイヤー指定の識別文字

//////////////////////////////////////////////////

var crCode = String.fromCharCode( 13 ) ;
var enterCode = String.fromCharCode( 3 ) ;
var aiVersion = version.slice(0,2) ;
var lNameArray = new Array() ;
var targetLArray = new Array() ;
var nameText = null ;
var oFlg = false ;

target = activeDocument ;
if( activeDocument.activeLayer.layers.length != 0 )
{
	lFlg = confirm( "名前を変更するのは、いま選択されているレイヤーのサブレイヤーですか？" )
	if( lFlg ) target = activeDocument.activeLayer ;
}

if( activeDocument.selection.length != 0 )
{
	t = activeDocument.selection[0] ;
	if( aiVersion == "10" )
	{ t instanceof TextArtItem ? nameText = t.contents : nameText = null }
	else
	{ t instanceof TextFrame ? nameText = t.contents : nameText = null }
}

if( nameText == null )
{
	dFlg = confirm( "現在のレイヤー名のリストを表示します。" )
	if( dFlg )
	{
		oZoom = activeDocument.views[0].zoom ;
		oCenter = activeDocument.views[0].centerPoint ;
		activeDocument.views[0].zoom = 1 ;
		
		for( i=0; i<target.layers.length; i++ )
		{
			lNameArray.push( target.layers[i].name ) ;
		}
		target.visible = true ;  target.locked = false ;
		
		if( aiVersion == "10" )
		{
			tItem = activeDocument.activeLayer.textArtItems.add() ;
		}
		else
		{
			tItem = activeDocument.activeLayer.textFrames.add() ;
		}
		tItem.contents = lNameArray.join( crCode )
		+ crCode + jsMarker
		+ crCode + msg( "msg1" ) ;
		tItem.position = [ oCenter[0] , oCenter[1] ] ;
		tItem.name = tNamesMarker ;
		tItem.selected = true ;
	}
	else
	{
		
	}
}
else
{
	// レイヤー名指定用テキストを分割
	lNArray = nameText.split( enterCode ).join( crCode ).split( crCode ) ;
	// 不要部分を削る
	cnt = 0 ;
	while( (lNArray[ cnt ] != jsMarker) && (cnt < lNArray.length) )
	{ lNameArray.push( lNArray[ cnt ] ) ; cnt ++ }
	
	for( i=0; i<target.layers.length; i++ )
	{
		//if( target.layers[i].name != tNamesMarker )
		{ targetLArray.push( target.layers[i] ) }
	}

	if( lNameArray.length < targetLArray.length )
	{
		flg = confirm( "新しいレイヤー名の数が実際のレイヤー数より少なくなっています。このまま続けますか？" ) ;
	}
	else if( lNameArray.length > targetLArray.length )
	{
		flg = confirm( "新しいレイヤー名の数が実際のレイヤー数を越えています。このまま続けますか？" ) ;
		oFlg = true ;
	}
	else{ flg = true }

	if( oFlg )
	{
		c = lNameArray.length - targetLArray.length ;
		for( i=0; i<c; i++ )
		{ target.layers.add(); }
	}

	if( flg )
	{
		for( i=0; i<lNameArray.length; i++ )
		{
			if( lNameArray[i] != jsMarker )
			{
				target.layers[i].name = lNameArray[i] ;
			}
			else break ;
		}
		dFlg = confirm( "リネームが完了しました。レイヤー名のリストを削除しますか？" ) ;
		if( dFlg ) activeDocument.selection[0].remove() ;
	}	
}


////////////////////////////////////////////////////////////////////////

// メッセージ
function msg( msgType )
{
	if( aiVersion != "11" )
	{

switch( msgType )
{
case "msg1" : mA = [
		"上記のレイヤー名のリストを書き換え、",
		"これを選択した状態でもう一度",
		"「レイヤー自動リネーム」を実行してください。" ] ; break ;
}

	}
	else
	{

switch ( msgType )
{
case "msg1" : mA = [
		"rewrite the list above and",
		"select this text object,",
		"then run the script again." ] ; break ;
}

	}
	ms = mA.join( crCode ) ;
	return ms ;
}