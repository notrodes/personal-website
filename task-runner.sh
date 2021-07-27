find ./articles -type f -name "*.txt.html" -exec rm -f {} \;

for file in articles/*; do
	./transform.scm $file;
	done