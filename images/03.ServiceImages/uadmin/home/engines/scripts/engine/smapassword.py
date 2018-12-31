import hashlib

password = raw_input("Password")
nt_password = hashlib.new('md4', password.encode('utf-16le')).digest().encode('h
ex').upper()
print nt_password
