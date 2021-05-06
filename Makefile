build:
	docker build -t pxt_arcade -f dockerfiles/node_pxt_arcade_micropython.dockerfile .

serve:
	docker run -it --rm -v "$$(pwd)/projects:/opt/pxt/arcade/projects" -p 3232:3232 pxt_arcade

.PHONY : build serve
