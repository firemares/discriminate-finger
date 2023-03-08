import argparse
import re
import threading
import time
import requests
import check_leak

def banner():
    print("============================================")
    print("  _      _   _      _                _    ")
    print(" | |    | | | |    | |_    __ _ ____| | __")
    print(" | |____| | | |_   | '_ \ / _` | '--| |/ /")
    print(" | |____| | |___ \ | | | | (_| | |  |   < ")
    print(" | |    | |,|___) || | |_|\\___,|_|  |_|\_\\")
    print(" |_|    |_|_|____/                        \n")
    print("============================================")
    print("Welcome")
    print("")
    print("")
    print("")

header={
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
}

# 获取url对应的server名称（服务器名称）
def get_sever_name(url):
    r = requests.get(url,headers=header)
    if r.status_code == 200:
        # r.headers是个字典，取字典中sever对应的值
        r_infor = r.headers['Server']
        print("**************"+url+"它的中间件是"+r_infor+"**************")
        # name是str
        name = re.sub("/\d.*\d", '', r_infor)
        # vers是list
        vers_list = re.findall("\d.*\d", r_infor, re.S)
        # vers=vers_list[0]
        check_leak.sql_search(str(name))
        check_leak.get_hash(url)
        with open("url_server_name.txt",'a') as file_1:
            file_1.write(url+" : "+r_infor+'\n')
    else:
        print("本次访问失败"+url)
    return r_infor

def thread(urls):
    threads=[]
    for url in urls:
       threads.append(
           threading.Thread(target=get_sever_name,args=(url,))
       )
    for thread in threads:
        thread.start()
        time.sleep(5)
    for thread in threads:
        thread.join()

    print("over")

# 从txt文件读取url
def read_file(file_name):
    file=open(file_name,'r')
    urls = file.readlines()
    return urls
    # sever_names = []
    # # 取urls中的每条url
    # for i in urls:
    #     url = i
    #     # 调用读取url服务器名称的函数
    #     thread(urls)
    #     sever_name=get_sever_name(url)
    #     sever_names=sever_names+[sever_name]
    #     # 将所有url和其对应的服务器名称写入txt文件中
    #     with open("url_server_name.txt",'a') as file_1:
    #         file_1.write(url+" : "+sever_name+'\n')
    # print(urls+sever_names)
    #
    # # 输出所有url，输出所有url对应的服务器名称
    # return urls,sever_names
# url = input()


if __name__ == "__main__":
    # 使用终端跑的时候
    banner()
    print("请按要求输入内容")
    parser = argparse.ArgumentParser()
    parser.add_argument("-u", "--url", dest="url", help="指定需要检测的网站地址")
    parser.add_argument("-f", "--file", dest="file", help="读取指定后缀为txt的文件中的url")
    args = parser.parse_args()
    file_name = (args.file)
    check_url = re.search("^http",str(args.url), re.S)
    check_file = re.search("txt$",str(args.file), re.S)
    if check_url != None:
        print("========================================================================================")
        sname=get_sever_name(args.url)
        print("========================================================================================")
        # check_leak.sql_search(sname)
        # check_leak.get_hash(args.url)
        # 调用check_leak.py的sql_search函数

    elif check_file != None:
        urls = read_file(file_name)
        thread(urls)
        print('已打印完成')
        print('详情请查看url_server_name.txt文件')
    else:
        print("========================================================================")
        print("请输正确的参数")

        parser.print_help()

    # 使用pycharm跑的时候
    # banner()
    # print("========================================================================")
    # print("请输入要进行查询的url")
    # file_name = input()
    # urls = read_file(file_name)
    # thread(urls)



    # print(url_infor(url))
    # 还需要做什么？
    # 1.交互(优化)
    # 2.输出每个中间件版可能存在的漏洞，给出漏洞编号，和攻击脚本建议
    # read_file('1.txt')