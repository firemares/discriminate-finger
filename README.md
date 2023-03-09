# discriminate-finger


<h1>本项目基于爬虫识别网站的中间件</h1>
安装所有需求库请执行：pip install -r requirements.txt

<br>!并且需要连接本地mysql的库，然后创建名为spiders的库，账号为root，密码为root，再将两个sql文件导入spiders库中）</br>
<br>（内容可以根据自己的想法调整）</br>
<br>能提供的帮助有：</br>
<br>1.获取网页的中间件信息</br>
<br>2.给出网页中间件可能存在的漏洞</br>
<br>3.获取网页的指纹</br>
<br>4.识别该指纹是否是使用cms</br>

<br>使用方式：</br>
<br>针对一条url</br>
<br>python finger.py -u url</br>
<br>针对多条url，只支持txt文件</br>
<br>python finger.py -f x.txt</br>


<h1>未来项目--多功能渗透工具-Hbhack</h1>
<h2>多功能渗透工具-Hbhack</h2>

该工具基于python开发，目标是针对（中间件、cms、操作系统）实现全自动渗透测试。</br>
具体实现如下功能：</br>

一、爬虫</br>
1.爬取各大中间件官网披露的历史漏洞以及介绍（并按版本分类）</br>
2.爬取各大CMS官网披露的历史漏洞以及介绍（并按版本分类）</br>
3.爬取Windows/Linux操作系统的历史漏洞以及介绍（并按版本分类）</br>

二、中间件（WebSever）
<br>1.爬虫请求网站，获取响应头里的Sever字段</br>
2.识别中间件，判断版本</br>
3.提示该版本中间件可能存在那些漏洞</br>
4.调用针对该版本漏洞的攻击脚本</br>
5.输出报告</br>

三、CMS（软件搭建的网站程序）</br>
1.爬虫遍历该网站所有网页</br>
2.通过响应内容获取该网站所有网页的hash值</br>
3.判断是否匹配已知CMS的hash</br>
4.提示该CMS存在的漏洞</br>
5.调用针对该CMS漏洞的攻击脚本</br>
6.输出报告</br>

四、操作系统</br>
1.爬虫执行shell命令</br>
2.判断操作系统类型（windows/linux）</br>
3.识别操作系统版本</br>
4.判断该系统下补丁是否齐全</br>
5.输出报告</br>

