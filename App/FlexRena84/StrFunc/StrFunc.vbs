'StrFuc.DLL Sample code	by Naru

'Create StrFunc wrapper
Set f = CreateObject("StrFunc.Wrapper")

'Sample parameters
strConv = "<Ç†Ç¢Ç§ÉAÉCÉE±≤≥ABCabcÇ`ÇaÇbÇÅÇÇÇÉ> aBC_DEFÅ@ÇÅÇaÇbÅQÇcÇdÇe"
strFormat = "%s=%08x, %s=%10.8lf"
strDateFormat = "gg y'îN'M'åé'd'ì˙'"

'Use wrapper function
strLCMapString = f.LCMapString(0,f.LCMAP_HIRAGANA or  f.LCMAP_PROPERCASE or f.LCMAP_FULLWIDTH, strConv)
strStrConv = f.StrConv(strConv, f.vbProperCase or f.vbKatakana or f.vbNarrow)
strSprintf = f.sprintf(strFormat, "Value", 512, "PI", 3.141592)	'sprintf(pass variable number of parameters)
strSprintfV = f.sprintf(strFormat, Array("Value", 512, "PI", 3.141592))	'sprintf(pass variable number of parameters as array)
strVsprintf = f.vsprintf(strFormat, Array("Value", 512, "PI", 3.141592))	'vspritf(pass variable number of parameters as array)
strDateFormat = f.GetDateFormat(0,0, Date(), strDateFormat)
'strImmConversion = f.ImmGetConversionList("Ç÷ÇÒÇ±Ç§",f.GCL_CONVERSION)
'strImmRevConversion = f.ImmGetConversionList("ïœçX",f.GCL_REVERSECONVERSION)

'Show result
MsgBox("LCMapString: " + vbNewLine + vbTab + strLCMapString + vbNewLine + _
	"StrConv: " + vbNewLine + vbTab + strStrConv + vbNewLine + _
	"sprintf: " + strSprintf + vbNewLine + _
	"(v)sprintf: " + strSprintfV + vbNewLine + _
	"vsprintf: " + strVsprintf + vbNewLine + _
	"DateFormat: " + strDateFormat + vbNewLine + _
	"ImmConversion: " + strImmConversion + vbNewLine + _
	"ImmRevConversion: " + strImmRevConversion)
