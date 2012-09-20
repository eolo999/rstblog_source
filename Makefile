all: clean build serve

run: build serve

clean:
	rm -rf _build/*

build:
	run-rstblog build

serve:
	run-rstblog serve

