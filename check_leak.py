import pymysql
import re
import requests
import ddddocr
import os,sys,hashlib
import requests


sever_name = 'iis'
def sql_search(sever_name):
    db = pymysql.connect(host='localhost', user='root', password='root', db='spiders')
    cursor = db.cursor()
    search_infor = 'select leak_name from sever_attck where name = %s'
    result =''
    cursor.execute(search_infor,(sever_name))
    k = list(cursor.fetchall())
    # print(k)
    if k!=[]:
        for i in k:
            # print(list(i))
            for j in i:
                # print(j)
                result= result+j+'\n'
        print("该网站可能存在:" +"\n"+ result)
    else:
        print("                    这个中间件漏洞内容未被收录！！！！                ")
    db.close()
    return result

def get_hash(url):
    db = pymysql.connect(host='localhost', user='root', password='root', db='spiders')
    cursor = db.cursor()
    search_infor = 'select cms_name from cms where match_pattern = %s'
    result = ''
    r = requests.get(url=url)
    text = r.text
    md5 = hashlib.md5()
    md5.update(text.encode('utf-8'))
    cursor.execute(search_infor, (md5.hexdigest()))
    k = list(cursor.fetchall())
    if k!=[]:
        for i in k:
            # print(list(i))
            result= result+j+'\n'
        print("                   "+"该网页使用的框架是:"+result+"目标网页Hash值:  {}".format(md5.hexdigest()))
    else:
        print("目标网页Hash值:  {}".format(md5.hexdigest())+"       该Hash值未在指纹库中找到！！！")
    db.close()
    return result

if __name__=="__main__":
    # x=sql_search(sever_name)
    # print(type(x))
    get_hash("http://www.baidu.com")
