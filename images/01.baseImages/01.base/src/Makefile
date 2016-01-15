-include config.mk

json_to_env.o:
	$(CC) $(CCFLAGS)  json_to_env.c -o json_to_env.o
	
json_to_env: json_to_env.o ../libjsmn.a
	$(CC) $(LDFLAGS) $^ -o $@

