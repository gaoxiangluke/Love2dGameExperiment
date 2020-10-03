# Love2dGameExperiment
## minesweeper
 把release/minesweeper.love 放在/home/cpi/games/love2D 文件夹 

 .love 文件本身是一个压缩文件，可以把.love 改成.zip 然后就可以查看其中的源码。 另外minesweeper 文件夹里面也是源码，可以直接把那个文件夹里面的文件打包成zip 然后后缀改成..love 也可以游玩

#### 更改配置
 ```
源码 conf.lua 有一些选项可以更改
delayMax 调整可以改摁住方向键选择方块的移动速度
以下三个数字是简单中等和难状态炸弹的数量，可以随意更改
easynum = 25
mediumnum = 35
hardnum = 40

其他的就最好不要改了，可能会出错
 ```
#### 操作方法
```
刚进游戏上下建选择难易度， B 确定
游戏开始后，B 打开方格， A 放置旗子， 在有棋子的地方再恩A 可以取消掉棋子
游戏左上数字剩余旗子， 右上计时
如果打开有雷的方格游戏失败，表情变为哭脸
如果所有有雷的地方都有旗子，表情变为带太阳镜笑脸
游戏成功或失败后恩B 重新开始
```