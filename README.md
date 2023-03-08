# discriminate-finger


<h1>本项目基于爬虫识别网站的中间件</h1>
需要安装的库有：
pymysql
，re
，requests
，ddddocr
，os
,sys
,hashlib
，requests
，argparse
，threading
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




