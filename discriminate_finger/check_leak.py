import pymysql
import re


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
        print("=========该网站管理员屏蔽了sever的展示，或者这个中间件漏洞内容未被收录")
    return result

if __name__=="__main__":
    x=sql_search(sever_name)
    print(type(x))
