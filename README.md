# Crowd-funding
## 一、项目进度条
1、该分支完成权限管理模块下用户管理、权限维护、菜单维护、角色维护四个页面的增删改查    
2、其中菜单维护和权限维护属于树形数据结构的查询    
## 二、知识点的梳理
1、树形数据结构表中使用的是PID的自关联，后台数据没有进行树形结构的封装    
2、前台使用JQuery的ZTree插件的简单数据模式进行树形数据的封装    
3、ZTree树的初始化、动态按钮组加模态框对数据进行增删改查 ，zTree的基础和高级使用    
## 处理树形结构数据的相关的JS代码在代码中都有详细的注释
### 1、zTree中添加图标,需要结合页面的源代码解读下面代码
```js

      view: {
			addDiyDom: function(treeId, treeNode){
				//treeNode:setting.treeId + "_" + 内部计数
				//将id="treeDemo_序号_icon"的标签的class属性删除
				$("#"+treeNode.tId+"_ico").removeClass();
				//在id="treeDemo_序号_span"的标签前添加一个<span>标签，属性class值为treeNode.icon
				//treeNode.icon就是TMenu中每个节点都封装了一个icon属性
				$("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")
			},
```
### 2、禁止点击页面跳转
```js
      key:{
				//很重要，跳转的话，点击之后页面跳转了按钮组就出不来
				url:"notExistsProperty"//不让节点进行跳转
			}

```
