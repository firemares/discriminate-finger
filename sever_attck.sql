/*
 Navicat Premium Data Transfer

 Source Server         : mysql学习
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : spiders

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 08/03/2023 16:31:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sever_attck
-- ----------------------------
DROP TABLE IF EXISTS `sever_attck`;
CREATE TABLE `sever_attck`  (
  `id` int(11) NULL DEFAULT NULL,
  `name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ban_ben` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `leak_name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `leak_describe` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `poc_name` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `defense` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sever_attck
-- ----------------------------
INSERT INTO `sever_attck` VALUES (1, 'iis', '6.0', 'iis6.0解析漏洞', '该版本默认将*.asp;.jpg此类格式的文件名，当成asp解析，服务器默认；后面的内容不解析，相当于截断，例如上传asp木马，就可以用xx.asp;.jpg来绕过；iis除了会将asp解析成脚本执行文件之外，还会将 cer cdx asa扩展名解析成asp', NULL, '1.禁止上传和创建此类畸形文件2.图片存放目录设置为禁止脚本执行');
INSERT INTO `sever_attck` VALUES (2, 'iis', '6', 'iis6 PUT漏洞', 'IIS Server在web中开启了webDAV 配置了可以写入的权限，造成了任意文件上传。', NULL, '1.关闭webDAV\r\n2.关闭写入权限');
INSERT INTO `sever_attck` VALUES (3, 'iis', '7.x', 'iis7.x解析漏洞', 'iis7.x版本在Fast-CGI运行模式下，在任意文件，例如：a.jpg/png后面加上/.php,会将.jpg/png解析为php文件。', NULL, '配置 cgi fix_pathinfo（php inil中）为0并重启php-cgi程序');
INSERT INTO `sever_attck` VALUES (4, 'iis', NULL, 'iis短文件漏洞', 'IIS的短文件名机制，可以暴力破解文件名。访问构造某个存在的短文件，会返回404，访问构造某个不存在的短文件，会返回400。使用payload验证目标是否存在短文件漏洞，显示404时，说明存在短文件。', NULL, '1、升级.net framework\n2、修改注册表键值：HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\FileSystem修改NtfsDisable8dot3NameCreation为1。修改完成后,需要重启系统生效。\n命令行关闭 fsutil behavior set disable8dot3\r\n————————————————\r\n版权声明：本文为CSDN博主「shayebudon」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。\r\n原文链接：https://blog.csdn.net/shayebudon/article/details/123910745');
INSERT INTO `sever_attck` VALUES (5, 'Apache', NULL, 'Apache未知拓展名解析漏洞', 'apache默认一个文件可以有多个以点切割的后缀，当最右的后缀无法识别时，就继续向左识别，直到识别到合法后缀才开始解析，如xxx.php.qqq，qqq无法识别，就继续解析，到php时能够识别，就解析为php文件', NULL, NULL);
INSERT INTO `sever_attck` VALUES (6, 'Apache', '2.4.0~2.4.29', 'Apache换行解析漏洞', 'apache换行解析漏洞（CVE-2017-15715）\r\n\r\n其2.4.0~2.4.29版本中存在一个解析漏洞，在解析PHP时，1.php\\x0A将被按照PHP后缀进行解析，导致绕过一些服务器的安全策略。', NULL, '将上传的文件重命名为为时间戳+随机数+.jpg的格式并禁用上传文件目录执行');
INSERT INTO `sever_attck` VALUES (7, 'Apache', NULL, 'apache ssi 远程命令执行漏洞', '当目标服务器开启了SSI与CGI支持,我们就可以上传shtml,利用 语法执行命令。\n\n使用SSI(Server Side Include)的html文件扩展名，SSI（Server Side Include)，通常称为\"服务器端嵌入\"或者叫\"服务器端包含\"，是一种类似于ASP的基于服务器的网页制作技术。默认扩展名是 .stm、.shtm 和 .shtml。\n\n上传一个shell.shtml 内容\r\n————————————————\r\n版权声明：本文为CSDN博主「shayebudon」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。\r\n原文链接：https://blog.csdn.net/shayebudon/article/details/123910745', NULL, NULL);
INSERT INTO `sever_attck` VALUES (8, 'Tomcat', NULL, 'Tomcat弱口令&war远程部署', 'Tomcat存在后台管理，账号密码设置在conf/tomcat-users.xml\r\n\r\n可能存在的安全问题：弱口令或爆破(爆破采用数据包base64传递认证)\r\n这里先把我们的shell.jsp在本地打包成zip，然后重命名为war，之后上传war，它会自动解压，从而getshell', NULL, NULL);
INSERT INTO `sever_attck` VALUES (9, 'nginx', '<8.03', 'nginx畸形解析漏洞', 'nginx默认是以CGI的方式支持PHP解析的,普遍的做法是在 Nginx配置文件中\n\n通过正则匹配设置 SCRIPT_FILENAME。\n\n当访可http://192.1681.103/ phpinfo. jpg/1.php这个URL时\n\n$fastcgi_script_name会被设置为 “phpinfo.jpg/1.php”,然后构造成\n\nSCRIPT_FILENAME传递给 PHP CGI,如果PHP中开启了 fix_pathing这个选项\n\nPHP会认为 SCRIPT_FILENAME是 phpinfo.jpg,而1.php是 PATH_INFO,所以就\n\n会将 phpinfo.jpg作为PHP文件来解析了。', NULL, '修改php.ini，设置cgi.fix_pathinfo = 0;然后重启php-cgi。此修改会影响到使用PATH_INFO伪静态的应用;对于存储图片的location{…}，或虚拟主机server{…}，只允许纯静态访问，不配置PHP访问。');
INSERT INTO `sever_attck` VALUES (10, 'iis', '7.0', 'iis7.0畸形解析漏洞', '在默认Fast-CGI开启状况下,黑阔上传一个名字为wooyun.jpg，内容为\n\n<?PHP fputs(fopen(\'shell.php\',\'w\'),\'<?php eval($_POST[cmd])?>\');?>\n的文件，然后访问wooyun.jpg/.php,在这个目录下就会生成一句话木马 shell.php\n\n或者直接访问wooyun.jpg/.php,就会被以PHP方式解析', NULL, '修改php.ini，设置cgi.fix_pathinfo = 0;然后重启php-cgi。此修改会影响到使用PATH_INFO伪静态的应用;对于存储图片的location{…}，或虚拟主机server{…}，只允许纯静态访问，不配置PHP访问。');
INSERT INTO `sever_attck` VALUES (11, 'iis', '7.5', 'iis7.5畸形解析漏洞', '在默认Fast-CGI开启状况下,黑阔上传一个名字为wooyun.jpg，内容为\n\n<?PHP fputs(fopen(\'shell.php\',\'w\'),\'<?php eval($_POST[cmd])?>\');?>\n的文件，然后访问wooyun.jpg/.php,在这个目录下就会生成一句话木马 shell.php\n\n或者直接访问wooyun.jpg/.php,就会被以PHP方式解析', NULL, '修改php.ini，设置cgi.fix_pathinfo = 0;然后重启php-cgi。此修改会影响到使用PATH_INFO伪静态的应用;对于存储图片的location{…}，或虚拟主机server{…}，只允许纯静态访问，不配置PHP访问。');
INSERT INTO `sever_attck` VALUES (12, 'JBoss', NULL, 'JMX Console未授权访问Getshell', '此漏洞主要是由于JBoss中/jmx-console/HtmlAdaptor路径对外开放，并且没有任何身份验证机制，导致攻击者可以进⼊到jmx控制台，并在其中执⾏任何功能', NULL, '1.升级jboss\r\n2.关闭jmx-console和web-console，提高安全性');
INSERT INTO `sever_attck` VALUES (13, 'JBoss', '5.x/6.x ', '反序列化命令执行漏洞（CVE-2017-12149）', '该漏洞出现在/invoker/readonly中 ，服务器将用户post请求内容进行反序列化用工具来验证，在验证之前我们可以访问路径进行初步判断url://invoker/readonly,看服务器返回情况如下则说明漏洞存在', NULL, '修复：升级新版本，删除 http-invoker.sar 组件。');
INSERT INTO `sever_attck` VALUES (14, 'WebLogic', NULL, 'WebLogic未授权访问漏洞(CVE-2018-2894)', '在ws-testpage-impl.jar/com.oracle.webservices.testclient.ws.res.WebserviceResource 类中存在importWsTestConfig方法\n跟进 RSdataHelper的convertFormDataMultiPart方法，接下来调用convertFormDataMultiPart方法，文件直接由字段 文件名拼接而成，没有任何限制', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
