USER_NAME="Peter Hutkins"
USER_EMAIL="peter.hutkins@glydways.com"
 
git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}"
 
# Create ssh key
# Use defaults values by using the "Enter" key
ssh-keygen
 
# copy the content of public key
echo "--- SSH Key is everything below this line ----"
cat ~/.ssh/*.pub 

echo "Now copy and paste the above output to GitHub"
