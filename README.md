# Crowd-funding basic Framework
## 一、项目进度条
1.SSM整合完成，项目前后已跑通    
2.数据库的SQL脚本放在了atcrowdfunding-common的resources下的SQL文件夹    
3.MBG已生成相关的JavaBean、Mapper.xml和Mapper接口，gneratorConfig.xml在atcrowdfunding-common的resources    
## 二、常见问题
1.MBG中使用mybatis-generator：generate命令，出现generator插件不可用，百度的原因有驱动包的位置配置什么的。但是    
 都不能解决我遇到的问题。现在开来当初的问题根本就不值一提。如果当初要不是嫌error info一行的信息的太长而没有往后继
 续阅读信息，可能早就解决了。告诫自己，bug要仔细阅读，百度的不一定就是你遇到的问题。有时候自己耐着性子读一读，立马
 就知道了。
 bug原因：数据库中存在一个视图，MBG不能正常运行
