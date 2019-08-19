.default: install
.phony: install generate clean

bin_directory:=bin
asset_directory:=data/assets
song_url:=https://www.youtube.com/watch?v=z8cgNLGnnK4
song_file:=$(bin_directory)/nsp-you-spin-me-cover.mp3
loop_file:=$(asset_directory)/spin-loop.mp3

install:
	go install .

.git/hooks/pre-commit:
	cp ./pre-commit .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

$(song_file):
	mkdir -p "${bin_directory}"
	youtube-dl "${song_url}" --extract-audio --audio-format mp3 --exec "mv {} ${song_file}"

$(loop_file):
	mkdir -p "${asset_directory}"
	ffmpeg -i "${song_file}" -ss 00:01:13.30 -to 00:01:30.38 -c copy "${loop_file}"

generate: .git/hooks/pre-commit $(song_file) $(loop_file)
	go generate ./data

clean:
	git clean -xdf