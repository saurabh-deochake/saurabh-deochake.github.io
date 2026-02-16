FILE=Gemfile.lock
if [ -f "$FILE" ]; then
    rm $FILE
fi
# Clean up Jekyll cache to ensure a fresh build
rm -rf .jekyll-cache _site

docker run --rm -v "$PWD:/srv/jekyll/" -p "8080:8080" \
                    -it al-folio:latest bundler  \
                    exec jekyll serve --watch --force_polling --port=8080 --host=0.0.0.0 \
                    --verbose --livereload