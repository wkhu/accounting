pwd=`pwd`
mkdir -p $pwd/assets/images/uploads
ln -sf $pwd/assets/images/uploads $pwd/.tmp/public/images/uploads
exit 0