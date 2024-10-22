render:
	mkdir ./cv-output || true
	docker run -it -v ./cv:/tmp/input -v ./cv-output:/tmp/output ghcr.io/soerenschneider/pdflatex --output-dir=/tmp/output "/tmp/input/cv-soerenschneider.tex"
