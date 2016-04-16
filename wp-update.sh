
read -p "Nhan [Enter] de tiep tuc ..."
cd ${OPENSHIFT_REPO_DIR}www
 rm -rf wp-admin && rm -rf wp-includes && wget https://wordpress.org/latest.zip && unzip latest.zip && rm -rf wp-content && cp -r wordpress/* ${OPENSHIFT_REPO_DIR}www   && rm -rf wordpress && rm -rf latest.zip
