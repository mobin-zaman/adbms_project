import cx_Oracle

dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name=r'XE') 
conn = cx_Oracle.connect(user='scott', password='password', dsn=dsn_tns) 


c = conn.cursor()
# result=c.execute("")

# print('c',result)
# row=list()
# for r in c:
# 	print(r)
# 	row.append(r)

return_value = c.callfunc('test',int)
print(return_value)
