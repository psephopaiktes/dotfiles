/********************************************************
JavaScript for Adobe Illustrator CS2 ( Win / Mac )

■■エリアからテキスト抜き出し■■

エリアテキストをポイントテキストに変換します。

作成者：倉田タカシ
「イラレで便利」 http://park17.wakwak.com/~ddpp/6ot/js_ill/
2007_05_01	v1.0
********************************************************/

//////必要に応じてここを書き換えてください////////

txtProps = "fillColor,font,size" ;
// 変換後に反映されるテキスト属性

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
			if( selArray[i] instanceof TextArtItem  &&  selArray[i].kind == TextType.AREATEXT  &&  ! selArray[i].locked )
			{ txArray.push( selArray[i] ); selArray[i].selected = false }
			// 選択を解除しないとテキストオブジェクト生成時にエラーになる
		}
		else
		{
			if( selArray[i] instanceof TextFrame  &&  selArray[i].kind == TextType.AREATEXT  &&  ! selArray[i].locked )
			{ txArray.push( selArray[i] ); selArray[i].selected = false }
		}
	}

	if( txArray.length > 0 ){ modText( txArray ) }
	else{ alert( msg("no_text") ) }
}

function modText( txArray )
{
	oLayers = openLayers( activeDocument.layers ) ;
	
	dFlg = confirm( msg( "cnf_del" ) ) ;
	txtProps = txtProps.split(",") ;
	
	for( i=0; i<txArray.length; i++ )
	{
		if( aiVersion == "10" )
		{
			pt = setText( txArray[i].layer , txArray[i].contents ) ;
			// ここで、targetがparentだと親レイヤーではなくグループになってしまう
			pt.position = [ txArray[i].position[0] , txArray[i].position[1] ] ;
			pt.moveBefore( txArray[i] ) ;
			
			for( j=0; j<txtProps.length; j++ )
			{ pt.textRange()[ txtProps[j] ] = txArray[i].textRange()[ txtProps[j] ] }
			pt.textPaths[0].orientation = txArray[i].textPaths[0].orientation ;
			if( pt.textPaths[0].orientation == TextOrientation.VERTICAL )
			{ pt.left = txArray[i].left + txArray[i].width }
			//pt.selected = true ;
			//選択するとエラーになる
			
			if( dFlg ){ txArray[i].remove() }
		}
		else
		{
			pt = setText( txArray[i].layer , "" ) ;
			txArray[i].textRange.duplicate().move( pt , ElementPlacement.INSIDE ) ;
			pt.position = [ txArray[i].position[0] , txArray[i].position[1] ] ;
			pt.move( txArray[i] , ElementPlacement.PLACEBEFORE ) ;
			
			for( j=0; j<txtProps.length; j++ )
			{ pt.textRange.characterAttributes[ txtProps[j] ] = txArray[i].textRange.characterAttributes[ txtProps[j] ] }/**/
			pt.orientation = txArray[i].orientation ;
			if( pt.orientation == TextOrientation.VERTICAL )
			{ pt.left = txArray[i].left + txArray[i].width }
			if( dFlg ){ txArray[i].remove() }
		}
	}

	closeLayers( activeDocument.layers , oLayers ) ;
	
	//alert( txArray.length + msg("end") ) ;
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


// テキストオブジェクトを作成
function setText( target , str , txtPref )
{
	if( aiVersion == "10" ) { txObj = target.textArtItems.add() }
	else { txObj = target.textFrames.add() }
	
	if( txtPref != undefined )
	{
		for( var pc in txtPref ){ txObj[pc] = txtPref[pc] }
	}
	txObj.contents = str ;

	return txObj ;
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
		"この書類上のすべてのエリアテキストを変換しますか？" ] ; break ;
case "cnf_del" : mA = [
		"変換後に元のエリアテキストを削除しますか？" ] ; break ;
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
case "cnf_del" : mA = [
		"Delete original texts ?" ] ; break ;
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