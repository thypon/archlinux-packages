.PHONY: clean

clean:
	git reset --hard HEAD
	git clean -f -d -x
