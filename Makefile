.PHONY: clean

prepare:
	aur/*.sh

clean:
	git clean -f -d -x
