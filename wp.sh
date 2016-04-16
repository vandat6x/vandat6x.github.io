cd ${OPENSHIFT_REPO_DIR}www
wget https://wordpress.org/latest.zip && unzip latest.zip && cp -r wordpress/* ${OPENSHIFT_REPO_DIR}www   && rm -rf wordpress && rm -rf latest.zip
