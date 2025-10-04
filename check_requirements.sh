while read p; do
	if ! command -V $P; then
		echo "Missing ${p}!"
	fi
done < requirements.txt
