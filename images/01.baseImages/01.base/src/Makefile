-include config.mk


json_to_env: json_to_env.o ../libjsmn.a
	$(CC) $(LDFLAGS) $^ -o $@

