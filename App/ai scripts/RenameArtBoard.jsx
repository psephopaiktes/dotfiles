//----------------------------------------------------
//ダイアログ設定
//----------------------------------------------------
setDialog = function(inputText){
    var win = new Window("dialog", "アートボード名変更");
    var myText = win.add("edittext", [0, 0, 400, 300], "", {multiline: true});
    myText.text = inputText;
    myText.active = true;

    win.add ("button", undefined, "OK");
    win.add ("button", undefined, "Cancel");

    if (win.show () == 1){
        myName = myText.text;
        changeName(abd);//アートボード名変更
    }
    else{
        return;
    }
}
//----------------------------------------------------

var abd = activeDocument.artboards;

//現在のアートボード名を確認
checkName(abd);

//現在のアートボード名をダイアログに表示 
var old_Name = set_Name.join("\n"); 
setDialog(old_Name);

//----------------------------------------------------
//関数
//----------------------------------------------------
//現在のアートボード名を確認
function checkName(target)
{
    set_Name = [];
    var n = target.length;
    for (var i=0; i<n; i++)
    {
        var set_old_Name = target[i].name;
        set_Name.push(set_old_Name);
    }
}

//アートボード名変更
function changeName(target)
{
    var new_Name = [];
    new_Name = myName.split("\n");
    var n = target.length;
    for (var i=0; i<n; i++)
    {
        var set_new_Name = new_Name[i];
        target[i].name = set_new_Name;
    }
}

