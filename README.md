# 后台系统的权限管理模块
**项目SSM+springSecurity+bootstrap+zTree**    
atcrowdfunding-parent是父工程，以下都是子工程，其中atcrowdfunding-web是war工程
1. atcrowdfunding-bean
2. atcrowdfunding-common
3. atcrowdfunding-manager-api
4. atcrowdfunding-manager-impl
5. atcrowdfunding-web    

项目相关的表结构和数据SQL脚本放在atcrowdfunding-common的resources的sql文件下，拿出来执行就可以创建表和向
表中插入数据。项目使用了MBG逆向生成bean、Mapper接口和Mapper.xml。MBG的配置文件generatorConfig.xml和SQL在
同一项目的同一文件下。     

SSM三大框架的整合配置文件都在atcrowdfunding-web的resources文件下，如果SQL脚本已经执行，数据库的相关配置在
db.properties文件中已配置，就可以部署运行项目。  

项目的功能模块主要页面的效果图    
1. 用户管理页面
![image](https://github.com/UserJustins/Crowd-funding/blob/master/images/user.png)
2. 权限管理页面    
![image](https://github.com/UserJustins/Crowd-funding/blob/master/images/authentic.png)
3. 菜单管理页面    
![image](https://github.com/UserJustins/Crowd-funding/blob/master/images/menu.png)
4. 角色管理页面    
![image](https://github.com/UserJustins/Crowd-funding/blob/master/images/role.png)




