# dotfiles
- 平田のMac環境構築用
- English前提

## 手順

1. $ `sudo bash -c "$(curl -L raw.githubusercontent.com/psephopaiktes/dotfiles/master/install.sh)"`

1. [Macのシステム環境設定](./doc/mac-setting.md)  
`defautl`コマンドは現実的に管理できないので使わない

1. $ `cd ~/.ssh && ssh-keygen -t rsa` して $ `pbcopy < ~/.ssh/id_rsa.pub` して[GitHub](https://github.com/settings/ssh)にSSH設定。  
不要なら古いのは消す。  
// .sshって最初からあるっけ？

1. [アプリ設定](./doc/app-setting.md)  
mackup 同期がめんどいので使わない  
// [BST](https://itunes.apple.com/jp/app/bettersnaptool/id417375580)必要?

1. [Apple](https://developer.apple.com/fonts/) からSFフォントをすべて入れる

1. アピアランスの整備
    - Finderツールバーをカスタマイズ
        – 不要なものを消す
     - Chrome,Ps,Ai,Codeを追加
    - 壁紙を変える
    - Dock整理
    - 通知センターに Calendar、天気、計算機
