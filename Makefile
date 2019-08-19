.phony: install generate clean

install:
	go install .

generate: data/assets/spin-loop.mp3

data/assets/spin-loop.mp3: .git/hooks/pre-commit
	./can-i-haz-muzic.sh
	go generate ./data

.git/hooks/pre-commit:
	echo "Installing git pre-commit hook"
	cp ./pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

clean:
	rm -rfv ./bin
	rm -rfv ./data/assets/*