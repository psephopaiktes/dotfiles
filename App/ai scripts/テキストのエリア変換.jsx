/********************************************************
JavaScript for Adobe Illustrator CS2 ( Win / Mac )

■■テキストをエリアに入れる■■

選択したテキストか、指定が無い場合は書類上の全てのテキストの
うち、ポイントテキスト（エリアに入っていないテキスト）を
テキストエリアに入った形に変換します。

作成者：倉田タカシ
「イラレで便利」 http://park17.wakwak.com/~ddpp/6ot/js_ill/
2007_04_15	v1.0
********************************************************/

//////必要に応じてここを書き換えてください////////

var maxW = 0.5 ;	// ボックス幅の上限（書類の幅に対する割合）
var maxH = 0.5 ;	// ボックス高さの上限（書類の高さに対する割合）
var ajustNum = 1.2 ;
// 複数行ボックスのサイズ調整値
// （単に幅・高さを整数倍しただけでは足りないので、暫定的に）

//////////////////////////////////////////////////


var osStr = $.os.slice( 0 , 3 ) ;
var aiVersion = version.slice(0,2) ;
var crCode = String.fromCharCode(13);
var enterCode = String.fromCharCode( 3 ) ;

var selArray = new Array() ;
var txArray = new Array() ;

// 書類が開かれているかどうかの確認
if( documents.length == 0 ){ alert( msg("no_files") ) }
else
{
	selArray = activeDocument.selection ;
	
	if( selArray.length == 0 )
	{
		// 全テキストを処理するか確認
		if( confirm( msg( "cnf_alltext" ) ) )
		{ aiVersion == "10" ? selArray = activeDocument.textArtItems : selArray = activeDocument.textFrames }
	}

	// ロックされていないテキストオブジェクトのみを抽出
	for( i=0; i<selArray.length; i++ )
	{
		if( aiVersion == "10" )
		{
			if( selArray[i] instanceof TextArtItem  &&  selArray[i].kind == TextType.POINTTEXT  &&  ! selArray[i].locked )
			{ txArray.push( selArray[i] ) }
		}
		else
		{
			if( selArray[i] instanceof TextFrame  &&  selArray[i].kind == TextType.POINTTEXT  &&  ! selArray[i].locked )
			{ txArray.push( selArray[i] ) }
		}
	}

	if( txArray.length > 0 ){ modText( txArray ) }
	else{ alert( msg("no_text") ) }
}

function modText( txArray )
{
	oLayers = openLayers( activeDocument.layers ) ;
	
	for( i=0; i<txArray.length; i++ )
	{
		if( aiVersion == "10" )
		{
			perW = 1 ;  perH = 1 ;	// 長いテキストの幅調整用
			tw = txArray[i].width ;
			if( tw > activeDocument.width * maxW )
			{ perH = Math.ceil( tw / (activeDocument.width * maxW) ) ;  tw = activeDocument.width * maxW }
			th = txArray[i].height ;
			if( th > activeDocument.height * maxH )
				{ perW = Math.ceil( th / (activeDocument.height * maxH) ) ;  th = activeDocument.height * maxH }
			txArray[i].kind = TextType.AREATEXT ;
			txArray[i].textPaths[0].textPathObject.width = tw * perW ;
			txArray[i].textPaths[0].textPathObject.height = th * perH ;
			if( perW > 1 ){ txArray[i].textPaths[0].textPathObject.width *= ajustNum }
			if( perH > 1 ){ txArray[i].textPaths[0].textPathObject.height *= ajustNum }
			txArray[i].selected = true ;
		}
		else
		{
			// エリアの範囲取得( left , top , right , bottom )
			cb = txArray[i].controlBounds ;
			// 文字組み方向取得
			to = txArray[i].orientation ;
			
			perW = 1 ;  perH = 1 ;	// 長いテキストの幅調整用
			tw = txArray[i].width ;
				{ perH = Math.ceil( tw / (activeDocument.width * maxW) ) ;  tw = activeDocument.width * maxW }
			th = cb[1] - cb[3] ;
				{ perW = Math.ceil( th / (activeDocument.height * maxH) ) ;  th = activeDocument.height * maxH }
			tw *= perW ;	if( perW > 1 ){ tw *= ajustNum }
			th *= perH ;	if( perH > 1 ){ th *= ajustNum }
			
			tArea = activeDocument.pathItems.rectangle( cb[1] , cb[0] , tw , th ) ; 
			// top , left , width , height
			tBox = activeDocument.textFrames.areaText( tArea , to ) ;
			// テキスト内容移動
			txArray[i].textRange.move( tBox , ElementPlacement.INSIDE ) ;
			// テキストの重ね順移動
			tBox.move( txArray[i] , ElementPlacement.PLACEBEFORE ) ;
			tBox.selected = true ;
			// 元テキストを削除
			txArray[i].remove() ;
		}
	}

	closeLayers( activeDocument.layers , oLayers ) ;
	
	alert( txArray.length + msg("end") ) ;
}



////////////////////////////////////////////////////////////////////////

// レイヤーを操作可能にする処置
function openLayers( ls /*layers*/ )
{
	var lArray = new Array ; var vArray = new Array ;
	for( lc=0; lc<ls.length; lc++ )
	{
		if( ls[lc].locked == true )
		{ ls[lc].locked = false ; lArray.push( lc ) }
		if( ls[lc].visible == false )
		{ ls[lc].visible = true ; vArray.push( lc ) }
	}
	return[ lArray , vArray ] ;
}
function closeLayers( tLayers , arrays )
{
	for( loc=0; loc<arrays[0].length; loc++ )
	{ tLayers[ arrays[0][loc] ].locked = true }
	for( vc=0; vc<arrays[1].length; vc++ )
	{ tLayers[ arrays[1][vc] ].visible = false }
}

////////////////////////////////////////////////////////////////////////


// メッセージ
function msg( msgType )
{
	if( aiVersion == "10" )
	{

switch( msgType )
{
case "cnf_alltext" : mA = [
		"この書類上のすべてのポイントテキストを変換しますか？" ] ; break ;
case "no_files" : mA = [
		"まず、処理したいファイルを開いてください。" ] ; break ;
case "no_text" : mA = [
		"変換できるテキストはありません。" ] ; break ;
case "end" : mA = [
		" 点のテキストを変換しました。" ] ; break ;
}

	}else{

switch ( msgType )
{
case "cnf_alltext" : mA = [
		"Modify all texts in this document ?" ] ; break ;
case "no_files" : mA = [
		"Open a file first." ] ; break ;
case "no_text" : mA = [
		"There is no text to modify." ] ; break ;
case "end" : mA = [
		" texts modified." ] ; break ;
}
	}
	ms = mA.join( crCode ) ;
	return ms ;
}