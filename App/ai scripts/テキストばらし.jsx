/********************************************************
JavaScript for Illustrator CS2 ( Win / Mac )

■■テキストばらし■■

複数行のテキストを改行で別オブジェクトに分割します。

作成者：倉田タカシ                             2007_05_01
********************************************************/

var itemsToSplit = new Array() ;	//各テキストを格納
var splitTexts = new Array() ;	//各分割テキストの配列を格納
var HorV ;
var txPos ;
var lineHeight ;

var aiVersion = version.slice(0,2);

var crCode = String.fromCharCode(13);		//改行コードを指定
var enterCode = String.fromCharCode( 3 ) ;

selectedObj = activeDocument.selection ;
if( selectedObj.length == 0 )
{
	alert("まず、改行で分割したいテキストを選択してください。  ( Select texts first. )");
}
else
{
	for( i=0; i<selectedObj.length; i++ )
	{
		if( aiVersion == "10" )
		{
			if( selectedObj[i] instanceof TextArtItem )
			itemsToSplit.push(selectedObj[i]) ;
		}
		else
		{
		if( selectedObj[i] instanceof TextFrame )
			// レガシーテキストへの対応
			if( selectedObj[i].converted == false )
			{
				selectedObj[i] = selectedObj[i].convertToNative() ;
				ct = selectedObj[i].textFrames[0] ;
				ct.move( selectedObj[i] , ElementPlacement.PLACEBEFORE ) ;
				itemsToSplit.push( ct ) ;
			}
			else { itemsToSplit.push(selectedObj[i]) }
			// レガシーテキストでない場合（ undefinedが返る ）
		}
	}
}
if( itemsToSplit.length == 0 )
{
	alert("まず、改行で分割したいテキストを選択してください。  ( Select texts first. )");
}
else
{
	for( i=0; i<itemsToSplit.length; i++ )
	{
		if( aiVersion == "10" )
		{
			lineHeight = itemsToSplit[i].textRange( 0 , 0 ).leading ;
			if( lineHeight == 0 )
				lineHeight = ( Math.round( itemsToSplit[i].textRange( 0 , 0 ).size*2.4 ) ) / 2 ;
				// バージョン10では行送りが自動のときに数値が文字サイズの120％から0.5ポイント単位で丸められる
			HorV = ( itemsToSplit[i].textPaths[0].orientation == TextOrientation.HORIZONTAL ) ;
		}
		else
		{
			lineHeight = itemsToSplit[i].textRange.characterAttributes.leading ;
			if( lineHeight == 0 )
				lineHeight = Math.round( itemsToSplit[i].textRange.characterAttributes.size*1.2 ) ;
			HorV = ( itemsToSplit[i].orientation == TextOrientation.HORIZONTAL ) ;
		}
		txPos = itemsToSplit[i].position ;
		//エンターキーの改行をリターンキーに置き換えてから分割
		txArray = itemsToSplit[i].contents.split( enterCode ).join( crCode ).split( crCode ) ;

		splitTexts[i] = new Array() ;
		for( j=0; j<txArray.length; j++ )
		{
			if( txArray[j] != "" )
			{
				splitTexts[i][j] = itemsToSplit[i].duplicate();
				splitTexts[i][j].contents = txArray[j] ;

				if( HorV )
				{
					splitTexts[i][j].position = [ txPos[0] , txPos[1]-(lineHeight*j) ] ;
					
					if( splitTexts[i][j].kind == TextType.AREATEXT )
					{
						if( aiVersion == "10" )
						{ splitTexts[i][j].textPaths[0].textPathObject.height
						 = lineHeight * splitTexts[i][j].textRange().textLines.length }
						else
						{ splitTexts[i][j].textPath.height
						 = lineHeight * splitTexts[i][j].lines.length }
						
						if( j > 0 )
						{ splitTexts[i][j].top
						 = splitTexts[i][j-1].top - splitTexts[i][j-1].height }
					}
				}
				else
				{
					// 縦書きのエリアテキストの場合は、先に幅を決める
					if( splitTexts[i][j].kind == TextType.AREATEXT )
					{
						if( aiVersion == "10" )
						{ splitTexts[i][j].textPaths[0].textPathObject.width
						 = lineHeight * splitTexts[i][j].textRange().textLines.length }
						else
						{ splitTexts[i][j].textPath.width
						 = lineHeight * splitTexts[i][j].lines.length }
					}
					
					splitTexts[i][j].position
					// = [ txPos[0]+(lineHeight*((txArray.length-1)-j)) , txPos[1] ] ;
					 = [ txPos[0] + itemsToSplit[i].width - splitTexts[i][j].width , txPos[1] ] ;
					
					if( j > 0 )
					{ splitTexts[i][j].left
					 = splitTexts[i][j-1].left - splitTexts[i][j].width }
				}

				if( aiVersion == "10" )
				{ splitTexts[i][j].moveBefore( itemsToSplit[i] ) }
				else
				{ splitTexts[i][j].move( itemsToSplit[i] , ElementPlacement.PLACEBEFORE ) }
			}
		}
		itemsToSplit[i].remove() ;
	}
}